shared_examples_for :has_slug_functionality do
  describe "#slug" do
    context "when no slug is set" do
      specify 'slug is generated' do
        obj = described_class.new(described_class.slug_attribute => 'Generated slug')
        obj.valid?
        expect(obj.slug).to eq('generated-slug')
      end
    end

    context "when the slug is set" do
      specify 'slug is set to passed value' do
        obj = described_class.new(slug: 'passed-slug')
        obj.valid?
        expect(obj.slug).to eq('passed-slug')
      end
    end

    context "when slug is already taken" do
      before do
        existing = described_class.new(slug: 'taken-slug')
        existing.save(validate: false)
      end

      specify "object is not valid" do
        obj = described_class.new(slug: 'taken-slug')
        obj.valid?
        expect(obj.errors[:slug]).to_not be_empty
      end
    end
  end

  describe '#to_param' do
    specify 'parameter uses slug' do
      obj = described_class.new(slug: 'passed-slug')
      expect(obj.to_param).to eq('passed-slug')
    end
  end

  describe ".find_by_slug" do
    context 'when record is available to be found' do
      before do
        User.create(slug: 'named-slug')
      end

      specify 'record is returned' do
        record = described_class.find_by_slug('named-slug')
        expect(record).to be_present
      end
    end

    context 'when record is not found' do
      specify 'error is returned' do
        expect { described_class.find_by_slug('named-slug') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
