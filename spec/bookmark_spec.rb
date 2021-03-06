require 'bookmark'
require './spec/features/database_helpers'

describe Bookmark do
  describe '.all' do
		it 'returns an array of bookmarks' do
			connection = PG.connect(dbname: 'bookmark_manager_test')

			bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers')
			Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'DAS')
			Bookmark.create(url: 'http://www.google.com', title: 'Google')

			bookmarks = Bookmark.all

			expect(bookmarks.length).to eq(3)
			expect(bookmarks.first).to be_a(Bookmark)
			expect(bookmarks.first.id).to eq(bookmark.id)
			expect(bookmarks.first.title).to eq('Makers')
			expect(bookmarks.first.url).to eq('http://www.makersacademy.com')
		end
	end

	describe '.create' do
		it 'creates a new bookmark' do
			bookmark = Bookmark.create(url: 'http://www.example.com', title: 'EXAMPLE-TITLE')
			persisted_data = persisted_data(id: bookmark.id)

			expect(bookmark).to be_a(Bookmark)
			expect(bookmark.id).to eq(persisted_data['id'])
			expect(bookmark.title).to eq('EXAMPLE-TITLE')
			expect(bookmark.url).to eq('http://www.example.com')
		end
	end

	describe '.delete' do
		it 'deletes a bookmark' do
			bookmark = Bookmark.create(url: 'http://www.example.com', title: 'EXAMPLE-TITLE')
			bookmark_array = Bookmark.all

			expect { Bookmark.delete(id: bookmark.id) }.to change { Bookmark.all.length }.by(-1)
			expect(Bookmark.all).to_not include(bookmark)
		end
	end
end
