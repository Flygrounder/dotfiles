let
  flygrounder =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDO6tAAy/5hCN/F4/lcADbpJa9qd4nwW896Q3BV5pjBsNX2QM0+okkuUo7zRAjBktwmp1F9xIBSC067UEHoBfvWqeDgWHWrk58Se954kHyc9OLEXIdsqnLGfW72lGrLv/I1NKE2V81d7WC+Y/w4tcn9i9a4Bl+hlz4aA4lEscB7gXLDVchIvAEaivyd4J/Kx+qa6niIyNIDwoYwCuepbdMx0zFdJar0PGouUoriJKo8Hl1mEIrVesdH8O3VIi2hSJh+3Nyt5UV18LThzELt+7MYQNRcses8I4ps8jShn0St+fUFvSbCP+q1tWLP0MQh8IT0bu3oni4lIxj6R9GfEzLhFLr06JDewDAvWFEE3+eNQHYAD7lsGTt4t2eZ8Wmmmyw1QW6E1P3fMr7EqYEJfwJruAlWiHiZFTOEl5aceN9zXWHwGSSfD4DN0g1BnAQEa+/yLLgnA9dWaMgvGoyw79JcC8vQ5vacZ2lsKKeW9p37GtSmK+f5LlsL1o9wgLqr6Fc=";
  server =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH1/K7XWEASrJiS0LpUZSsRRsUQd4JycPmgzqVlyS7c0";
in {
  "drone.age".publicKeys = [ flygrounder server ];
  "nextcloudAdminPass.age".publicKeys = [ flygrounder server ];
}
