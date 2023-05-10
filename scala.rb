# typed: false
# frozen_string_literal: true

# Experimental Scala Formula
class Scala < Formula
  desc "Experimental launcher for Scala"
  homepage "https://virtuslab.github.io/scala-cli/"
  url (RUBY_PLATFORM.include? "arm64") ?
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.0.0-RC2/scala-cli-aarch64-apple-darwin.gz" :
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.0.0-RC2/scala-cli-x86_64-apple-darwin.gz"
  version "v1.0.0-RC2"
  sha256 (RUBY_PLATFORM.include? "arm64") ?
    "da50481824e0d9c8412a60bd357069a2f971d1006d6d20cb67bb7ad8860e39f3" :
    "2fa8b78488066ed7896e9214176c268466c53dd3c663e9c7e4eb766a6e5b2e02"
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
