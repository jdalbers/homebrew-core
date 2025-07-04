class Keploy < Formula
  desc "Testing Toolkit creates test-cases and data mocks from API calls, DB queries"
  homepage "https://keploy.io"
  url "https://github.com/keploy/keploy/archive/refs/tags/v2.6.15.tar.gz"
  sha256 "96b09e0d8a7bc658f5c99ca2c7bd7c3e7a8a5392885c870822b590a88d742235"
  license "Apache-2.0"
  head "https://github.com/keploy/keploy.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c85253a55e9093973dd960239fa705abf16a19ca2b175fe3d1d1f35e38562762"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c85253a55e9093973dd960239fa705abf16a19ca2b175fe3d1d1f35e38562762"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c85253a55e9093973dd960239fa705abf16a19ca2b175fe3d1d1f35e38562762"
    sha256 cellar: :any_skip_relocation, sonoma:        "8c60e804b11bb8f929464251a5c57a4df2e75538b2ff5f9bede07253c8de92b3"
    sha256 cellar: :any_skip_relocation, ventura:       "8c60e804b11bb8f929464251a5c57a4df2e75538b2ff5f9bede07253c8de92b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7371435a8e563852d07e976bdf8e6d3c7edff3368980fecf0b07003502e8112e"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  test do
    system bin/"keploy", "config", "--generate", "--path", testpath
    assert_match "# Generated by Keploy", (testpath/"keploy.yml").read

    output = shell_output("#{bin}/keploy templatize --path #{testpath}")
    assert_match "No test sets found to templatize", output

    assert_match version.to_s, shell_output("#{bin}/keploy --version")
  end
end
