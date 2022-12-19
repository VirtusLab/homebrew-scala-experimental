# typed: false
# frozen_string_literal: true

# Experimental Scala Formula
class Scala < Formula
  desc "Experimental launcher for Scala"
  homepage "https://virtuslab.github.io/scala-cli/"
  url (RUBY_PLATFORM.include? "arm64") ?
    "https://github.com/Virtuslab/scala-cli/releases/download/v0.1.19/scala-cli-aarch64-apple-darwin.gz" :
    "https://github.com/Virtuslab/scala-cli/releases/download/v0.1.19/scala-cli-x86_64-apple-darwin.gz"
  version "0.1.19"
  sha256 (RUBY_PLATFORM.include? "arm64") ?
    "cd988fae74ab11bd680946b61e88943ae917b0cb37ed2a4467289f37ec01bdd8" :
    "99c493bd37c85a80a851577201935ad9310fdc3234fd2857feccc8e14c6be533"
  license "Apache-2.0"

  def install
    if (RUBY_PLATFORM.include? "arm64")
      bin.install "scala-cli-aarch64-apple-darwin" => "scala-cli"
    else
      bin.install "scala-cli-x86_64-apple-darwin" => "scala-cli"
    end
    bin.install_symlink "scala-cli" => "scala"
  end

  test do
    (testpath / "Hello.scala").write "object Hello {
                                def main(args: Array[String]): Unit =
                                  println(\"Hello from Scala\")
                              }"
    output = shell_output("#{bin}/scala-cli Hello.scala")
    assert_equal ["Hello from Scala\n"], output.lines
  end
end
