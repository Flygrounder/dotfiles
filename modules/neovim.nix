{ pkgs, lib, config, ... }: {
  options = { custom.neovim.enable = lib.mkEnableOption "Enable Neovim"; };
  config = lib.mkIf config.custom.neovim.enable {
    my = {
      home.packages = with pkgs; [
        biome
        nerd-fonts.fira-code
        nixfmt-classic
        wl-clipboard
        xclip
        ripgrep
        luajitPackages.lua-utils-nvim
        sqlfluff
        tinymist
        websocat
        typst
        typstyle
      ];
      programs.nixvim = {
        enable = true;
        autoCmd = [{
          command = "setlocal conceallevel=2";
          event = [ "BufEnter" "BufWinEnter" ];
          pattern = [ "*.norg" ];
        }];
        globals = {
          mapleader = " ";
          maplocalleader = ",";
          zig_fmt_autosave = 0;
        };
        clipboard.register = "unnamedplus";
        colorschemes.catppuccin.enable = true;
        extraConfigLua = ''
          require 'typst-preview'.setup {
            dependencies_bin = {
              ['tinymist'] = 'tinymist',
              ['websocat'] = 'websocat',
            },
          }

          for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
            local default_diagnostic_handler = vim.lsp.handlers[method]
            vim.lsp.handlers[method] = function(err, result, context, config)
              if err ~= nil and err.code == -32802 then
                return
              end
              return default_diagnostic_handler(err, result, context, config)
            end
          end
        '';
        extraPlugins = [
          (pkgs.vimUtils.buildVimPlugin {
            name = "typst-preview";
            src = pkgs.fetchFromGitHub {
              owner = "chomosuke";
              repo = "typst-preview.nvim";
              rev = "06778d1";
              hash = "sha256-oBJ+G4jTQw6+MF/SMwaTkGlLQuYLbaAFqJkexf45I1g=";
            };
          })
        ];
        opts = {
          number = true;
          ignorecase = true;
          smartcase = true;
          swapfile = false;
          expandtab = true;
          shiftwidth = 4;
          tabstop = 4;
        };
        keymaps = [
          {
            action.__raw = ''
              function()
                if vim.bo.filetype == 'typst' then
                  vim.cmd [[TypstPreviewToggle]]
                elseif vim.bo.filetype == 'markdown' then
                  vim.cmd [[MarkdownPreview]]
                end
              end'';
            key = "<leader>p";
          }
          {
            action = "<cmd>Telescope projects<cr>";
            key = "<leader>sp";
          }
          {
            action = "<cmd>Oil<cr>";
            key = "<leader>o";
          }
          {
            action = "<cmd>Oil<cr>";
            key = "<leader>o";
          }
          {
            action = "<cmd>lua require('harpoon.mark').add_file()<cr>";
            key = "<leader>k";
          }
          {
            action = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>";
            key = "<leader>j";
          }
          {
            action = "<cmd>lua require('harpoon.ui').nav_file(1)<cr>";
            key = "<M-q>";
          }
          {
            action = "<cmd>lua require('harpoon.ui').nav_file(2)<cr>";
            key = "<M-w>";
          }
          {
            action = "<cmd>lua require('harpoon.ui').nav_file(3)<cr>";
            key = "<M-e>";
          }
          {
            action = "<cmd>lua require('harpoon.ui').nav_file(4)<cr>";
            key = "<M-r>";
          }
          {
            action = "<cmd>Telescope find_files<cr>";
            key = "<leader>sf";
          }
          {
            action = "<cmd>Telescope live_grep<cr>";
            key = "<leader>sg";
          }
          {
            action = "<cmd>Telescope help_tags<cr>";
            key = "<leader>sh";
          }
          {
            action = "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>";
            key = "<leader>ss";
          }
          {
            action = "<cmd>Trouble diagnostics focus<cr>";
            key = "<leader>q";
          }
          {
            action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
            key = "]d";
          }
          {
            action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
            key = "[d";
          }
          {
            action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
            key = "<leader>a";
          }
        ];
        plugins = {
          vimtex = {
            enable = true;
            texlivePackage = pkgs.texlive.combined.scheme-full;
            settings = { view_method = "zathura"; };
          };
          markdown-preview.enable = true;
          web-devicons.enable = true;
          illuminate.enable = true;
          comment.enable = true;
          conform-nvim = {
            enable = true;
            settings = {
              default_format_opts = { lsp_format = "fallback"; };
              format_on_save = ''
                function(bufnr)
                  local ignore_filetypes_raw = os.getenv("NEOVIM_DISABLE_FORMAT_ON_SAVE_FT") or ""
                  local ignore_filetypes = {}
                  for ft in string.gmatch(ignore_filetypes_raw, "([^,]+)") do
                    table.insert(ignore_filetypes, ft)
                  end
                  if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                  end
                  return { lsp_format = "fallback" }
                end'';
              formatters_by_ft = let jsConfig = { __unkeyed-1 = "biome"; };
              in {
                javascript = jsConfig;
                typescript = jsConfig;
                typescriptreact = jsConfig;
                typst = { __unkeyed-1 = "typstyle"; };
              };
              formatters = { biome = { command = "biome"; }; };
            };
          };
          autoclose.enable = true;
          ts-autotag.enable = true;
          treesitter = {
            enable = true;
            settings = {
              highlight = {
                enable = true;
                disable = [ "latex" ];
                additional_vim_regex_highlighting = false;
              };
            };
          };
          trouble = {
            enable = true;
            settings = {
              warn_no_results = false;
              open_no_results = true;
            };
          };
          oil.enable = true;
          harpoon.enable = true;
          direnv.enable = true;
          fidget.enable = true;
          cmp-nvim-lsp-signature-help.enable = true;
          cmp = {
            enable = true;
            settings = {
              snippet.expand = ''
                function(args)
                require('luasnip').lsp_expand(args.body)
                end
              '';

              sources = [
                { name = "nvim_lsp"; }
                { name = "luasnip"; }
                { name = "nvim_lsp_signature_help"; }
              ];

              mapping = {
                "<C-n>" = "cmp.mapping.select_next_item()";
                "<C-p>" = "cmp.mapping.select_prev_item()";
                "<cr>" = "cmp.mapping.confirm({ select = true })";
                "<C-Space>" = "cmp.mapping.complete()";
              };
            };
          };
          cmp-nvim-lsp.enable = true;
          lualine.enable = true;
          luasnip.enable = true;
          lsp = {
            enable = true;
            inlayHints = true;
            onAttach = ''
              client.server_capabilities.semanticTokensProvider = nil
            '';
            servers = {
              biome.enable = true;
              cssls.enable = true;
              dartls.enable = true;
              pyright.enable = true;
              gopls.enable = true;
              metals.enable = true;
              tailwindcss.enable = true;
              tinymist = {
                enable = true;
                rootDir = {
                  __raw = ''
                    require('lspconfig.util').root_pattern({'.project', '.git'}) 
                  '';
                };
              };
              rust_analyzer = {
                enable = true;
                installCargo = false;
                installRustc = false;
              };
              nil_ls = {
                enable = true;
                settings.formatting.command = [ "nixfmt" ];
              };
              clangd.enable = true;
              ts_ls.enable = true;
              yamlls.enable = true;
              zls.enable = true;
            };
            keymaps = {
              silent = true;
              lspBuf = {
                K = "hover";
                "<leader>r" = "rename";
              };
              extra = [
                {
                  action = "<cmd>Telescope lsp_definitions<cr>";
                  key = "gd";
                }
                {
                  action = "<cmd>Telescope lsp_type_definitions<cr>";
                  key = "gt";
                }
                {
                  action = "<cmd>Telescope lsp_references<cr>";
                  key = "gD";
                }
                {
                  action = "<cmd>lua require('conform').format({})<cr>";
                  key = "<leader>i";
                }
              ];
            };
          };
          project-nvim = {
            enable = true;
            enableTelescope = true;
            settings = {
              detection_methods = [ "pattern" ];
              patterns = [ ".git" ".project" ];
            };
          };
          vim-surround.enable = true;
          telescope = {
            enable = true;
            extensions = { ui-select.enable = true; };
          };
          gitsigns.enable = true;
          nvim-lightbulb = {
            enable = true;
            settings = { autocmd = { enabled = true; }; };
          };
        };
      };
    };
  };
}
