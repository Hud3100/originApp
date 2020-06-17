require 'rails_helper'

RSpec.feature '質問の投稿とコメント機能' do
  given(:testuser) { create :user,
                   name: "Test User",
                   email: "testuser@user.com"}
  given(:anotheruser) { create :user }
  given(:company) { create :company }
  given(:testpost) { create :micropost, user_id: testuser.id}
  given!(:category) { create :category }
  background do
    # User.create(name: "Sample User", email: "samplecompany@company.com", password: "samplepassword")
    # Company.create!(name: "Sample Company", email: "samplecompany@company.com", password: "samplepassword")
  end

  context '質問の投稿画面' do
    scenario 'ユーザーが質問を投稿する' do
      act_as(testuser) do
        visit new_micropost_path
        fill_in 'form-title', with: "オデッセイのカスタムについて"
        fill_in 'form-content', with: "オデッセイの乗り心地改善やマフラーを変更したいです。"
        fill_in '予算', with: "30"
        fill_in 'form-search-car-name', with: "オデッセイ"
        check '内装'
        # attach_file "micropost[images_attributes][1][img]", "spec/fixtures/test.jpg"
        expect { click_on '投稿する' }.to change { Micropost.count }.by(1)
        expect(page).to have_content "投稿されました"
      end
    end

    scenario '質問に件名がなければエラーメッセージが表示される' do
      login(testuser)
      visit new_micropost_path
      fill_in 'form-title', with: ""
      fill_in 'form-content', with: "オデッセイの乗り心地改善やマフラーを変更したいです。"
      fill_in '予算', with: "30"
      fill_in 'form-search-car-name', with: "オデッセイ"
      check '内装'
      # attach_file "micropost[images_attributes][1][img]", "spec/fixtures/test.jpg"
      click_on '投稿する'
      expect(page).to have_content "タイトルを入力してください"
    end

    scenario '質問に内容がなければエラーメッセージが表示される' do
      login(testuser)
      visit new_micropost_path
      fill_in 'form-title', with: "オデッセイのカスタムについて"
      fill_in 'form-content', with: ""
      fill_in '予算', with: "30"
      fill_in 'form-search-car-name', with: "オデッセイ"
      check '内装'
      # attach_file "micropost[images_attributes][1][img]", "spec/fixtures/test.jpg"
      click_on '投稿する'
      expect(page).to have_content "質問内容を入力してください"
    end
  end

  context 'コメント' do
    scenario 'ユーザーが投稿した質問に、カスタマーショップがコメントを投稿する' do
      login_as_company(company)
      visit micropost_path(testpost)
      fill_in 'タイトル', with: "カスタムのご提案"
      fill_in 'コメント内容', with: "乗り心地改善に関しては、サスペンションやショックアブソーバーの交換をおすすめします。マフラーは当社自慢の可変バルブ付きマフラーがございます。"
      # attach_file "comment[images_attributes][0][img]", "spec/fixtures/test.jpg"
      click_on 'コメントする'
      expect(page).to have_content "コメントが投稿されました。"
    end

    scenario 'ユーザーが投稿した質問に、他ユーザーがコメントを投稿する' do
      act_as(anotheruser) do
        visit micropost_path(testpost)
        fill_in 'タイトル', with: "このカスタムいいなあ"
        fill_in 'コメント内容', with: "なるほどねーそういうやり方があったのか"
        # attach_file "comment[images_attributes][0][img]", "spec/fixtures/test.jpg"
        click_on 'コメントする'
        expect(page).to have_content "コメントが投稿されました。"
      end
    end

    scenario 'コメントにタイトルが入力されていなければエラーメッセージを表示する' do
      act_as(anotheruser) do
        visit micropost_path(testpost)
        fill_in 'タイトル', with: ""
        fill_in 'コメント内容', with: "なるほどねーそういうやり方があったのか"
        # attach_file "comment[images_attributes][0][img]", "spec/fixtures/test.jpg"
        click_on 'コメントする'
        expect(page).to have_content "タイトルを入力してください"
      end
    end

    scenario 'コメントに内容が入力されていなければエラーメッセージを表示する' do
      act_as(anotheruser) do
        visit micropost_path(testpost)
        fill_in 'タイトル', with: "そのカスタムいいなあ！"
        fill_in 'コメント内容', with: ""
        # attach_file "comment[images_attributes][0][img]", "spec/fixtures/test.jpg"
        click_on 'コメントする'
        expect(page).to have_content "コメント内容を入力してください"
      end
    end
  end

  context 'お気に入り' do
    scenario '質問に他ユーザーがお気に入り登録するとお気に入り解除ボタンへ切り替わり、お気に入り解除ボタンをクリック' do
      login anotheruser
      visit micropost_path(testpost)
      click_on 'お気に入りに登録'
      expect(page).to have_content "お気に入り解除"
    end
  end
end
