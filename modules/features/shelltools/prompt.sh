#!/usr/bin/env bash
# kanoxo powerline prompt — single implementation shared by fish and zsh.
# Usage: prompt.sh <last-exit-status>
# Prints the prompt with no trailing newline.
#
# Escape discipline: every SGR sequence is wrapped in %{...%} so zsh gets
# correct line-wrapping width accounting; the fish wrapper strips those
# markers (fish measures raw escapes itself). Literal % in dynamic values
# (paths, branches, contexts) is doubled to %% for zsh and un-doubled
# again by the fish wrapper.
rc=${1:-0}

SEP=''
BRANCH_GLYPH=$'\356\234\245' # U+E8A5, from previous kanagawa theme
KUBE_GLYPH=$'\363\261\203\276' # U+F13FE, from previous kanagawa theme
MARKER='❯'

# kanoxo wave triplets
T_USER_BG='42;39;64'
T_USER_FG='220;215;186'
T_DARK='28;28;36'
T_PA='128;170;255'
T_PB='154;188;255'
T_GIT='92;192;112'
T_KUBE='176;140;240'
T_ERR='229;72;106'

out=''
prev=''

_add() { # $1 = SGR params, e.g. 38;2;1;2;3 — appends %{ESC[<params>m%}
  local _e
  printf -v _e '%%{\033[%sm%%}' "$1"
  out+=${_e}
}

seg() { # $1=bg-triplet $2=fg-triplet $3=text
  if [[ -n $prev ]]; then
    _add "38;2;${prev}"
    _add "48;2;$1"
    out+=${SEP}
  fi
  _add "48;2;$1"
  _add "38;2;$2"
  out+=$3
  prev=$1
}

# user@host — flat start, no leading separator ($HOSTNAME is not set by every shell)
_host=${HOSTNAME:-}
[[ -z $_host ]] && _host=${HOST:-}
[[ -z $_host ]] && _host=$(hostname -s 2>/dev/null)
seg "$T_USER_BG" "$T_USER_FG" " $USER@${_host%%.*} "

# cwd, split into per-component segments (last 3 + ellipsis when deep)
declare -a parts
if [[ $PWD == "$HOME" ]]; then
  parts=('~')
else
  if [[ $PWD == "$HOME"/* ]]; then
    IFS='/' read -ra _r <<< "${PWD#"$HOME"/}"
    parts=('~' "${_r[@]}")
  elif [[ $PWD == /* ]]; then
    IFS='/' read -ra _r <<< "$PWD"
    parts=('' "${_r[@]}")
    [[ -z ${parts[1]} ]] && parts[1]='/'
  else
    IFS='/' read -ra parts <<< "$PWD"
  fi
  if (( ${#parts[@]} > 4 )); then
    parts=('…' "${parts[@]: -3}")
  fi
fi
blues=("$T_PA" "$T_PB")
i=0
for c in "${parts[@]}"; do
  seg "${blues[$i]}" "$T_DARK" " ${c//%/%%} "
  (( i = 1 - i ))
done

# git branch (+ dirty flag for staged/unstaged changes), only inside a work tree.
# NOTE: deliberately no untracked-file scan — `git status --porcelain` walks
# the whole tree (~250ms in nixpkgs). symbolic-ref doubles as the
# inside-a-repo check; single `diff HEAD` covers staged+unstaged at once.
branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) \
  || branch=$(git rev-parse --short HEAD 2>/dev/null) \
  || branch=''
if [[ -n $branch ]]; then
  # diff exit 1 = dirty, 0 = clean, 128 = no HEAD yet (fresh repo) → clean.
  dirty=''
  git diff --no-ext-diff --quiet --exit-code HEAD 2>/dev/null
  [[ $? == 1 ]] && dirty=' *'
  seg "$T_GIT" "$T_DARK" " $BRANCH_GLYPH ${branch//%/%%}${dirty} "
fi

# kubectl context (+ namespace unless default), parsed straight from the
# kubeconfig files with bash builtins only — no kubectl/awk forks.
_kube_ctx=''
_kube_ns=''
_kubeconfigs=${KUBECONFIG:-$HOME/.kube/config}
IFS=':' read -ra _kcfiles <<< "$_kubeconfigs"
for _kf in "${_kcfiles[@]}"; do
  [[ -f $_kf && -r $_kf ]] || continue
  if [[ -z $_kube_ctx ]]; then
    while IFS= read -r _line || [[ -n $_line ]]; do
      if [[ $_line =~ ^[[:space:]]*current-context:[[:space:]]*(.+)$ ]]; then
        _kube_ctx=${BASH_REMATCH[1]}
        break
      fi
    done < "$_kf"
  fi
done
if [[ -n $_kube_ctx ]]; then
  for _kf in "${_kcfiles[@]}"; do
    [[ -f $_kf && -r $_kf ]] || continue
    _inctx=0
    _ns=''
    while IFS= read -r _line || [[ -n $_line ]]; do
      if [[ $_line =~ ^[[:space:]]*-[[:space:]]+context: ]]; then
        _inctx=1
        _ns=''
      elif (( _inctx )) && [[ $_line =~ ^[[:space:]]*namespace:[[:space:]]*(.+)$ ]]; then
        _ns=${BASH_REMATCH[1]}
      elif (( _inctx )) && [[ $_line =~ ^[[:space:]]*name:[[:space:]]*(.+)$ ]]; then
        if [[ ${BASH_REMATCH[1]} == "$_kube_ctx" ]]; then
          _kube_ns=$_ns
          break 2
        fi
        _inctx=0
      elif [[ $_line =~ ^[[:space:]]*-[[:space:]] ]]; then
        _inctx=0
      fi
    done < "$_kf"
  done
  kt="$KUBE_GLYPH ${_kube_ctx//%/%%}"
  [[ -n $_kube_ns && $_kube_ns != default ]] && kt+="/${_kube_ns//%/%%}"
  seg "$T_KUBE" "$T_DARK" " $kt "
fi

# close the last segment, newline, input marker colored by exit status
_add "38;2;${prev}"
out+=${SEP}
_add "0"
out+=$'\n'
if (( rc == 0 )); then
  _add "38;2;${T_GIT}"
else
  _add "38;2;${T_ERR}"
fi
out+="${MARKER} "
_add "0"

printf '%s' "$out"
