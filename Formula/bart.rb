class Bart < Formula
  desc "AI-powered TDD task runner for software development"
  homepage "https://github.com/leandrostoroli/bart-loop"
  url "https://github.com/leandrostoroli/bart-loop/archive/refs/tags/v#{version}.tar.gz"
  sha256 "234943ace040e2671c0663449dc21c5f361b762ac34beb53f6d79cb002454fb0"
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

  def post_install
    system bin/"bart", "install"
  end

  test do
    system bin/"bart", "--help"
  end
end
