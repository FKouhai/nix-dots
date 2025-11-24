let
  franky = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyWsnvAIM23SRQCW4AIPKeNhVeCWtez/CV1hDegCunC franky@kraken";
  kraken = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyWsnvAIM23SRQCW4AIPKeNhVeCWtez/CV1hDegCunC franky@kraken";
in
{
  "ollama.age".publicKeys = [
    franky
    kraken
  ];
  "gemini.age".publicKeys = [
    franky
    kraken
  ];
}
