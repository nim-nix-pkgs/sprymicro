{
  description = ''Small demo Spry interpreters'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sprymicro-master.flake = false;
  inputs.src-sprymicro-master.owner = "gokr";
  inputs.src-sprymicro-master.ref   = "refs/heads/master";
  inputs.src-sprymicro-master.repo  = "sprymicro";
  inputs.src-sprymicro-master.type  = "github";
  
  inputs."spryvm".dir   = "nimpkgs/s/spryvm";
  inputs."spryvm".owner = "riinr";
  inputs."spryvm".ref   = "flake-pinning";
  inputs."spryvm".repo  = "flake-nimble";
  inputs."spryvm".type  = "github";
  inputs."spryvm".inputs.nixpkgs.follows = "nixpkgs";
  inputs."spryvm".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sprymicro-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sprymicro-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}