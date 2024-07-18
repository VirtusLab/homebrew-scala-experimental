# typed: false
# frozen_string_literal: true

# Experimental Scala Formula
class Scala < Formula
  desc "Experimental launcher for Scala"
  homepage "https://virtuslab.github.io/scala-cli/"
  url (RUBY_PLATFORM.include? "arm64") ?
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.4.1/scala-cli-aarch64-apple-darwin.gz" :
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.4.1/scala-cli-x86_64-apple-darwin.gz"
  version "1.4.1"
  sha256 (RUBY_PLATFORM.include? "arm64") ?
    "d5d8caafd52cb1be7bb233615529156800599c57dc16550b57513961e0ee8323" :
    "d737be39cd6c36f82842738e85ff5e5d10358f67fa5c758413c8823b62cbf3dc"
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
