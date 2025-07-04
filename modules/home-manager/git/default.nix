{ pkgs, ... }: {

  home.packages = [
    pkgs.diff-so-fancy
  ];

  xdg.configFile."git/config".source = ./config;
  xdg.configFile."git/template".source = ./template;

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Git aliases 
      alias ga='git add'
      alias gap='ga --patch'
      alias gb='git branch'
      alias gba='gb --all'
      alias gc='git commit'
      alias gca='gc --amend --no-edit'
      alias gce='gc --amend'
      alias gco='git checkout'
      alias gcl='git clone --recursive'
      alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
      alias gds='gd --staged'
      alias gi='git init'
      alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
      alias gm='git merge'
      alias gn='git checkout -b'  # new branch
      alias gp='git push'
      alias gr='git reset'
      alias gs='git status --short'
      alias gu='git pull'
    '';
  };

}