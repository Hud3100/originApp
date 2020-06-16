require 'rails_helper'

RSpec.describe "CommentsController", type: :request do
  let(:user) { create(:user) }
  let!(:micropost) { create(:micropost) }
  describe "POST #create" do
    context 'パラメータが有効な場合' do
      it 'リクエストが成功すること' do
        sign_in user
        post micropost_comments_url(micropost.id),
        params: { comment: FactoryBot.attributes_for(:comment,
                  commentable_id: user.id) }
        expect(response.status).to eq 302
      end

      it 'コメントが保存されること' do
        sign_in user
        expect { post micropost_comments_url(micropost.id),
                  params: { comment: FactoryBot.attributes_for(:comment,
                            commentable_id: user.id) }
                  }.to change{ Comment.count }.by(1)
        expect(response.status).to eq 302
      end

      it 'リダイレクトすること' do
        sign_in user
        post micropost_comments_url(micropost.id),
          params: { comment: FactoryBot.attributes_for(:comment,
                    commentable_id: user.id) }
        expect(response).to redirect_to Micropost.first
      end
    end

    context 'パラメータが無効な場合' do
      it 'リクエストが成功すること' do
        post micropost_comments_url(micropost.id),
          params: { comment: FactoryBot.attributes_for(:comment, :title_invalid) }
        expect(response.status).to eq 200
      end

      it 'コメントが保存されないこと' do
        expect { post micropost_comments_url(micropost.id), params: { comment: FactoryBot.attributes_for(:comment, :title_invalid) }}.not_to change{ Comment.count }
      end

      it 'エラーが表示されること' do
        skip
        post micropost_comments_url(micropost.id), params: { comment: FactoryBot.attributes_for(:comment, :title_invalid) }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end
end
