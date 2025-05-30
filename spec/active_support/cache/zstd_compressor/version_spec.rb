# frozen_string_literal: true

RSpec.describe "ActiveSupport::Cache::ZstdCompressor::VERSION" do
  subject { ActiveSupport::Cache::ZstdCompressor::VERSION }

  it { is_expected.to be_a(String).and match(%r{\A\d+(\.\d+){2}}) }
end
