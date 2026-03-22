class Bart < Formula
  desc "AI-powered TDD task runner for software development"
  homepage "https://github.com/leandrostoroli/bart-loop"
  url "https://github.com/leandrostoroli/bart-loop/archive/refs/tags/v#{version}.tar.gz"
  sha256 "876c86de76827c1bf75edc080579419378deebd0233c1b236bb788bc00bc48f6"
  license "MIT"

  depends_on "bun"

  def install
    libexec.install Dir["*"]
    cd libexec do
      system "bun", "install", "--production"
    end
    (bin/"bart").write <<~SH
      #!/bin/bash
      exec bun "#{libexec}/src/index.ts" "$@"
    SH
  end

  test do
    system bin/"bart", "--help"
  end
end
