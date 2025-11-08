{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Keymaps
    keymaps = [
      {
        mode = "n";
        key = "<leader><leader>";
        action.__raw = "function() Snacks.picker.smart() end";
      }
      {
        mode = "n";
        key = "<leader>a";
        action.__raw = "function() require'harpoon':list():add() end";
      }
      {
        mode = "n";
        key = "<C-e>";
        action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
      }
      {
        mode = "n";
        key = "<C-1>";
        action.__raw = "function() require'harpoon':list():select(1) end";
      }
      {
        mode = "n";
        key = "<C-2>";
        action.__raw = "function() require'harpoon':list():select(2) end";
      }
      {
        mode = "n";
        key = "<C-3>";
        action.__raw = "function() require'harpoon':list():select(3) end";
      }
      {
        mode = "n";
        key = "<C-4>";
        action.__raw = "function() require'harpoon':list():select(4) end";
      }
      {
        mode = "n";
        key = "<leader>n";
        action = ":cnext<CR>";
      }
      {
        mode = "n";
        key = "<leader>c";
        action = ":cprev<CR>";
      }
      {
        mode = "n";
        key = "<leader>r";
        action = ":mksession! Session.vim | restart source Session.vim<CR>";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<C-a>";
        action.__raw = ''function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" }'';
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<C-x>";
        action.__raw = ''function() require("opencode").select() end'';
      }
      {
        action = ":m '>+1<CR>gv=gv'";
        key = "J";
        mode = "v";
        options = {
          silent = true;
          noremap = true;
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
        action = ":GoIfErr<CR>";
        key = "<leader>gie";
        options = {
          silent = true;
          noremap = true;
          desc = "Golang iferr binding";
        };
      }
      {
        action = ":Trouble diagnostics toggle<CR>";
        key = "<leader>xx";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle trouble diagnostics Mapping";
        };
      }
      {
        action = ":Trouble qflist toggle<CR>";
        key = "<leader>xQ";
        options = {
          silent = true;
          noremap = true;
          desc = "Quick fix list using trouble";
        };
      }
      {
        action = ":Trouble loclist toggle<CR>";
        key = "<leader>xL";
        options = {
          silent = true;
          noremap = true;
          desc = "Location list";
        };
      }
      {
        action = ":Trouble diagnostics toggle filter.buf=0<CR>";
        key = "<leader>xl";
        options = {
          silent = true;
          noremap = true;
          desc = "Location list";
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
        action = ":ToggleTerm<CR>";
        key = "<leader>tt";
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
        action = ":TermExec cmd='rebuild && exit'<CR>";
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
      # LazyGit
      {
        action = ":LazyGit<CR>";
        key = "<leader>lg";
        options = {
          silent = true;
          noremap = true;
          desc = "open lazygit";
        };
      }
      {
        action = ":Fugit2<CR>";
        key = "<leader>lf";
        options = {
          silent = true;
          noremap = true;
          desc = "open lazygit";
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
      # Harpoon marks
      {
        action = ":Telescope harpoon marks<CR>";
        key = "<leader>e";
        options = {
          silent = true;
          noremap = true;
          desc = "Harpoon marks";
        };
      }
      {
        action.__raw = "function() Snacks.picker.grep() end";
        key = "<leader>fg";
        options = {
          silent = true;
          noremap = true;
          desc = "Search grep";
        };
      }
      # Snacks picker search buffers
      {
        action.__raw = "function() Snacks.picker.buffers() end";
        key = "<leader>fb";
        options = {
          silent = true;
          noremap = true;
          desc = "Search buffers";
        };
      }
      # Snacks picker buffer
      {
        action.__raw = "function() Snacks.picker.lines() end";
        key = "<leader>b";
        options = {
          silent = true;
          noremap = true;
          desc = "Search current buffer";
        };
      }
      # Snacks picker search commands
      {
        action.__raw = "function() Snacks.picker.command_history() end";
        key = "<leader>fh";
        options = {
          silent = true;
          noremap = true;
          desc = "Search commands";
        };
      }
      # Snacks picker search files
      {
        action.__raw = "function() Snacks.picker.files() end";
        key = "<leader>ff";
        options = {
          silent = true;
          noremap = true;
          desc = "Search files";
        };
      }
      # Snacks picker search commands
      {
        action.__raw = "function() Snacks.picker.commands() end";
        key = "<leader>fc";
        options = {
          silent = true;
          noremap = true;
          desc = "Search commands";
        };
      }
      # Snacks picker diagnostics
      {
        action.__raw = "function() Snacks.picker.diagnostics() end";
        key = "<leader>fd";
        options = {
          silent = true;
          noremap = true;
          desc = "Diagnostics";
        };
      }
      # Snacks picker quickfixlist
      {
        action.__raw = "function() Snacks.picker.qflist() end";
        key = "<leader>ql";
        options = {
          silent = true;
          noremap = true;
          desc = "Quickfix list";
        };
      }
      # Snacks picker undo tree
      {
        action.__raw = "function() Snacks.picker.undo() end";
        key = "<leader>fu";
        options = {
          silent = true;
          noremap = true;
          desc = "Undo tree";
        };
      }
      {
        action.__raw = "function() Snacks.picker.git_log() end";
        key = "<leader>fx";
        options = {
          silent = true;
          noremap = true;
          desc = "git commit";
        };
      }
      {
        action.__raw = "function() Snacks.picker.git_branches() end";
        key = "<leader>ft";
        options = {
          silent = true;
          noremap = true;
          desc = "git branches";
        };
      }
      {
        action.__raw = "function() Snacks.picker.git_status() end";
        key = "<leader>fst";
        options = {
          silent = true;
          noremap = true;
          desc = "git status";
        };
      }
      {
        action.__raw = "function() Snacks.picker.git_status() end";
        key = "<leader>fst";
        options = {
          silent = true;
          noremap = true;
          desc = "git status";
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
