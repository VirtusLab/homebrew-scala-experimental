# typed: false
# frozen_string_literal: true

# Experimental Scala Formula
class Scala < Formula
  desc "Experimental launcher for Scala"
  homepage "https://virtuslab.github.io/scala-cli/"
  url (RUBY_PLATFORM.include? "arm64") ?
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.8.5/scala-cli-aarch64-apple-darwin.gz" :
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.8.5/scala-cli-x86_64-apple-darwin.gz"
  version "1.8.5"
  sha256 (RUBY_PLATFORM.include? "arm64") ?
    "e6d945b53b67cb4ed67f498724634f86f01b476096c52751a8c47eb7ac214be4" :
    "f64dc744423ae9324530876958a91155e25312f73f6f25c86052317f08077229"
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
