let
  franky = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyWsnvAIM23SRQCW4AIPKeNhVeCWtez/CV1hDegCunC franky@kraken";
  franktory = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKE6/DnKjMtoqx3juH9QkphTsjAaLmwSd7eQT1sxMj40 franky@franktory";
  kraken = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyWsnvAIM23SRQCW4AIPKeNhVeCWtez/CV1hDegCunC franky@kraken";
in
{
  "ollama.age".publicKeys = [
    franky
    franktory
    kraken
  ];
  "gemini.age".publicKeys = [
    franky
    franktory
    kraken
  ];
}
