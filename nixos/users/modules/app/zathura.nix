{ lib, config, ... }:
with lib;
let
  cfg = config.modules.zathura;
in
{
  options.modules.zathura = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable Zathura document viewer";
    };
  };
  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
      };
    };
    programs.zathura = {
      enable = true;
      options = {
        default-bg = "#2E3440";
        default-fg = "#3B4252";
        statusbar-fg = "#D8DEE9";
        statusbar-bg = "#434C5E";
        inputbar-bg = "#2E3440";
        inputbar-fg = "#8FBCBB";
        notification-bg = "#2E3440";
        notification-fg = "#8FBCBB";
        notification-error-bg = "#2E3440";
        notification-error-fg = "#BF616A";
        notification-warning-bg = "#2E3440";
        notification-warning-fg = "#BF616A";
        highlight-color = "#EBCB8B";
        highlight-active-color = "#81A1C1";
        completion-bg = "#3B4252";
        completion-fg = "#81A1C1";
        completion-highlight-fg = "#8FBCBB";
        completion-highlight-bg = "#81A1C1";
        recolor-lightcolor = "#2E3440";
        recolor-darkcolor = "#ECEFF4";
        recolor = "false";
        recolor-keephue ="false";
      };
    };
  };
}
