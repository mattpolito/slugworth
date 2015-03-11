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
        record = described_class.new(slug: 'named-slug')
        record.save(validate: false)
      end

      specify 'record is returned' do
        record = described_class.find_by_slug('named-slug')
        expect(record).to be_present
      end
    end

    context 'when record is not found' do
      specify 'nil is returned' do
        expect(described_class.find_by_slug('named-slug')).to eq(nil)
      end

      specify 'error is raised' do
        expect{ described_class.find_by_slug!('named-slug') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

shared_examples_for :has_updatable_slug_functionality do
  describe "#slug :updatable" do
    let!(:existing) { described_class.create(described_class.slug_attribute => 'Name') }
    context "when attribute is changed" do
      specify "updates the slug" do
        existing[described_class.slug_attribute] = 'New Name'
        expect(existing).to be_valid
        expect(existing.slug).to eq('new-name')
      end
    end
    context "when attribute is not changed" do
      specify "does not update the slug" do
        expect(existing).to be_valid
        expect(existing.slug).to eq('name')
      end
    end
  end
end

shared_examples_for :has_incremental_slug_functionality do
  describe "#slug :incremental" do
    context "when slug is already taken" do
      before do
        existing = described_class.new(slug: 'taken-slug')
        existing.save(validate: false)
      end

      specify "increments the slug" do
        obj = described_class.new(described_class.slug_attribute => 'Taken Slug')
        expect(obj).to be_valid
        expect(obj.slug).to eq('taken-slug-1')
      end
    end
    context "when incremented slug is already taken" do
      before do
        existing = described_class.new(slug: 'taken-slug')
        existing.save(validate: false)
        existing = described_class.new(slug: 'taken-slug-1')
        existing.save(validate: false)
      end

      specify "increments the slug" do
        obj = described_class.new(described_class.slug_attribute => 'Taken Slug')
        expect(obj).to be_valid
        expect(obj.slug).to eq('taken-slug-2')
      end
    end
    context "when existing slug is reset" do
      let!(:existing) { described_class.create(described_class.slug_attribute => 'New Name') }

      specify "does not increment the slug" do
        existing.slug = nil
        expect(existing).to be_valid
        expect(existing.slug).to eq('new-name')
      end
    end
  end
end

shared_examples_for :has_scoped_slug_functionality do
  describe "#slug :scope" do
    context "when slug is already taken on same scope" do
      before do
        existing = described_class.new(slug: 'taken-slug', described_class.slug_scope => 1)
        existing.save(validate: false)
      end

      specify "object is not valid" do
        obj = described_class.new(slug: 'taken-slug', described_class.slug_scope => 1)
        expect(obj).to_not be_valid
        expect(obj.errors[:slug]).to_not be_empty
      end
    end

    context "when slug is already taken on another scope" do
      before do
        existing = described_class.new(slug: 'taken-slug', described_class.slug_scope => 1)
        existing.save(validate: false)
      end

      specify "object is valid" do
        obj = described_class.new(slug: 'taken-slug', described_class.slug_scope => 2)
        expect(obj).to be_valid
      end
    end
  end
end

shared_examples_for :has_incremental_scoped_slug_functionality do
  describe "#slug :incremental" do
    context "when slug is already taken" do
      before do
        existing = described_class.new(slug: 'taken-slug', described_class.slug_scope => 1)
        existing.save(validate: false)
      end

      specify "increments the slug" do
        obj = described_class.new(described_class.slug_attribute => 'Taken Slug', described_class.slug_scope => 1)
        expect(obj).to be_valid
        expect(obj.slug).to eq('taken-slug-1')
      end
    end
    context "when incremented slug is already taken" do
      before do
        existing = described_class.new(slug: 'taken-slug', described_class.slug_scope => 1)
        existing.save(validate: false)
        existing = described_class.new(slug: 'taken-slug-1', described_class.slug_scope => 1)
        existing.save(validate: false)
      end

      specify "increments the slug" do
        obj = described_class.new(described_class.slug_attribute => 'Taken Slug', described_class.slug_scope => 1)
        expect(obj).to be_valid
        expect(obj.slug).to eq('taken-slug-2')
      end
    end
    context "when slug is already taken in another scope" do
      before do
        existing = described_class.new(slug: 'taken-slug', described_class.slug_scope => 1)
        existing.save(validate: false)
      end

      specify "does not increment the slug" do
        obj = described_class.new(described_class.slug_attribute => 'Taken Slug', described_class.slug_scope => 2)
        expect(obj).to be_valid
        expect(obj.slug).to eq('taken-slug')
      end
    end
  end
end
