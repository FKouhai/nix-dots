{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Keymaps
    keymaps =
    [
      {
        action = ":m '>+1<CR>gv=gv'";
        key = "J";
        mode = "v";
        options = {
          silent = true;
          noremap =true;
          desc = "Move selection down";
        };
      }
      {
        action = ">gv";
        key = ">";
        mode = "v";
        options = {
          silent = true;
          noremap = true;
          desc = "Move selection right";
        };
      }
      {
        action = "<gv";
        key = "<";
        mode = "v";
        options = {
          silent = true;
          noremap = true;
          desc = "Move selection left";
        };
      }
      {
        action = ":m '<-2<CR>gv=gv'";
        key = "K";
        mode = "v";
        options = {
          silent = true;
          noremap = true;
          desc = "Move selection up";
        };
      }
      {
        action = ":Oil<CR>";
        key = "-";
        options = {
          silent = true;
          noremap = true;
          desc = "Oil Mapping";
        };
      }
      {
          action = ":Telekasten panel<CR>";
          key = "<leader>z";
          options = {
            silent = true;
            noremap = true;
            desc = "Open telekasten panel";
          };
      }
      {
          action = ":Telekasten find_notes<CR>";
          key = "<leader>zf";
          options = {
            silent = true;
            noremap = true;
            desc = "Open notes panel";
          };
      }
      {
          action = ":Telekasten search_notes<CR>";
          key = "<leader>zs";
          options = {
            silent = true;
            noremap = true;
            desc = "Open livegrep notes panel";
          };
      }
      {
          action = ":ToggleTerm";
          key = "<leader>tt<CR>";
          options = {
            silent = true;
            noremap = true;
            desc = "Open livegrep notes panel";
          };
      }
      {
          action = ":TermExec cmd='go run main.go'<CR>";
          key = "<leader>eg";
          options = {
            silent = true;
            noremap = true;
            desc = "go run main.go";
          };
      }
      # Go to definition
      {
          action = ":TermExec cmd='hms && exit'<CR>";
          key = "<leader>eh";
          options = {
            silent = true;
            noremap = true;
            desc = "home-manager switch";
          };
      }
      {
        action = ":lua vim.lsp.buf.definition()<CR>";
        key = "<leader>gd";
        options = {
          silent = true;
          noremap = true;
          desc = "Go to definition";
        };
      }
      # Go to references
      {
        action = ":lua vim.lsp.buf.references()<CR>";
        key = "<leader>gr";
        options = {
          silent = true;
          noremap = true;
          desc = "Go to references";
        };
      }
      # git blame open URL
      {
        action = ":GitBlameOpenCommitURL<CR>";
        key = "<leader>gb";
        options = {
          silent = true;
          noremap = true;
          desc = "Open git blame URL";
        };
      }
      # lazy git dashboard
      {
        action = ":LazyGit<CR>";
        key = "<leader>lg";
        options = {
          silent = true;
          noremap = true;
          desc = "Open lazygit";
        };
      }
      # markdown preview mapping
      {
        action = ":MarkdownPreview<CR>";
        key = "<leader>pm";
        options = {
          silent = true;
          noremap = true;
          desc = "Open markdown preview in browser";
        };
      }
      # Telescope search (live grep)
      {
          action = ":Telescope harpoon marks<CR>";
          key = "<leader>e";
          options = {
            silent = true;
            noremap = true;
            desc = "Search grep";
        };
      }
      {
        action = ":Telescope live_grep<CR>";
        key = "<leader>fg";
        options = {
          silent = true;
          noremap = true;
          desc = "Search grep";
        };
      }
      # Telescope search buffers
      {
        action = ":Telescope buffers<CR>";
        key = "<leader>fb";
        options = {
          silent = true;
          noremap = true;
          desc = "Search buffers";
        };
      }
      # Telescope buffer
      {
        action = ":Telescope current_buffer_fuzzy_find<CR>";
        key = "<leader>b";
        options = {
          silent = true;
          noremap = true;
          desc = "Search current buffer";
        };
      }
      # Telescope search commands
      {
        action = ":Telescope command_history<CR>";
        key = "<leader>sc";
        options = {
          silent = true;
          noremap = true;
          desc = "Search commands";
        };
      }
      # Telescope search files
      {
        action = ":Telescope find_files<CR>";
        key = "<leader>ff";
        options = {
          silent = true;
          noremap = true;
          desc = "Search files";
        };
      }
      # Telescope search commands
      {
        action = ":Telescope commands<CR>";
        key = "<leader>sc";
        options = {
          silent = true;
          noremap = true;
          desc = "Search commands";
        };
      }
      # Telescope diagnostics
      {
        action = ":Telescope diagnostics<CR>";
        key = "<leader>d";
        options = {
          silent = true;
          noremap = true;
          desc = "Diagnostics";
        };
      }
      # Telescope quickfixlist
      {
        action = ":Telescope quickfix<CR>";
        key = "<leader>ql";
        options = {
          silent = true;
          noremap = true;
          desc = "Quickfix list";
        };
      }
      # Telescope undo tree
      {
        action = ":Telescope undo<CR>";
        key = "<leader>u";
        options = {
          silent = true;
          noremap = true;
          desc = "Undo tree";
        };
      }
      # Diffview open comparing in git
      {
        action = ":DiffviewOpen<CR>";
        key = "<leader>do";
        options = {
          silent = true;
          noremap = true;
          desc = "Diffview open";
        };
      }
      # Diffview close comparing in git
      {
        action = ":DiffviewClose<CR>";
        key = "<leader>dp";
        options = {
          silent = true;
          noremap = true;
          desc = "Diffview close";
        };
      }
      # Mapping q for recording macros
      {
        action = "q";
        key = "q";
        options = {
          silent = true;
          noremap = true;
        };
      }

      # Mapping Ctrl+V for block visual mode
      {
        action = "<C-v>";
        key = "<C-v>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = ":wincmd k<CR>";
        key = "<c-k>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = ":wincmd j<CR>";
        key = "<c-j>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = ":wincmd h<CR>";
        key = "<c-h>";
        options = {
          silent = true;
          noremap = true;
        };
      }

      {
        action = ":wincmd l<CR>";
        key = "<c-l>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      # Buffers
      {
        action = ":BufferNext<CR>";
        key = "<Tab>";
        options = {
          silent = true;
          noremap = true;
          desc = "Next buffer";
        };
      }

      {
        action = ":BufferPrevious<CR>";
        key = "<S-Tab>";
        options = {
          silent = true;
          noremap = true;
          desc = "Prev buffer";
        };
      }
    ];
  };
}

