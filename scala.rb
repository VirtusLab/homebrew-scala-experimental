# typed: false
# frozen_string_literal: true

# Experimental Scala Formula
class Scala < Formula
  desc "Experimental launcher for Scala"
  homepage "https://virtuslab.github.io/scala-cli/"
  url (RUBY_PLATFORM.include? "arm64") ?
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.12.0/scala-cli-aarch64-apple-darwin.gz" :
    "https://github.com/Virtuslab/scala-cli/releases/download/v1.12.0/scala-cli-x86_64-apple-darwin.gz"
  version "1.12.0"
  sha256 (RUBY_PLATFORM.include? "arm64") ?
    "d62b09cc32c9e688a915cb20d4925264bdf166d815160e5903bbb0f595105dc9" :
    "1af327ae60aeadeb1de0951df19b5c34754f6d9f791fb81b66f7963d6009e0a2"
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
