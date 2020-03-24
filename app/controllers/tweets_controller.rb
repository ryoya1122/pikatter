class TweetsController < ApplicationController
	PER = 8
	def create
		@newtweet = Tweet.new(tweet_params)
		@newtweet.user_id = current_user.id

		require 'cotoha'
		client_id = ENV['COTOHA_API_KEY']
		client_secret = ENV['COTOHA_API_SECRET']
		client = Cotoha::Client.new(client_id: client_id, client_secret: client_secret)
		client.create_access_token

		@data = client.sentiment(sentence: @newtweet.body)
		@newtweet.sentiment = @data["result"]["sentiment"]
		@newtweet.score = @data["result"]["score"]

		case @newtweet.sentiment
			when 'Positive'
				@newtweet.score *= 33
				@newtweet.score += 66
			when 'Neutral'
				@newtweet.score *= 33
				@newtweet.score += 33
			when 'Negative'
				@newtweet.score *= -33
				@newtweet.score += 33
		end
		@user = current_user
		@user.tweet_count += 1
		@user.score_average = ( @user.score_average * ( @user.tweet_count - 1 ) + @newtweet.score ) / @user.tweet_count
		@user.save
		if AverageScore.find_by(user_id: current_user.id, day: Date.today).blank?
			@average_score = AverageScore.new
			@average_score.user_id = current_user.id
			@average_score.score = @newtweet.score
			@average_score.count = 1
			@average_score.day = Date.today
		else
			@average_score = AverageScore.find_by(user_id: current_user.id, day: Date.today)
			@average_score.score = ( @average_score.score * @average_score.count + @newtweet.score ) / (@average_score.count + 1 )
			@average_score.count += 1
		end
		@average_score.save
		if @newtweet.save
			@newtweet = Tweet.new
			@user = current_user
			group_by_id = tweets_get
			tweets_array = group_by_id.values.map{|a| a[0] }.sort_by! { |a| a[:updated_at] }.reverse!
			@tweets = Kaminari.paginate_array(tweets_array).page(params[:page]).per(10)
			@favorite = Favorite.new
			@newreply = Reply.new
		else
		   #ツイートできなかった時の処理
		end
	end
	def show
		@tweet = Tweet.find(params[:id])
		@user = current_user
		@newreply = Reply.new
		@replys = Reply.where(tweet_id: @tweet.id)
	end

	def destroy
		tweet = Tweet.find(params[:id])
        tweet.destroy
        @newtweet = Tweet.new
        @user = current_user
		group_by_id = tweets_get
		tweets_array = group_by_id.values.map{|a| a[0] }.sort_by! { |a| a[:updated_at] }.reverse!
		@tweets = Kaminari.paginate_array(tweets_array).page(params[:page]).per(10)
		@favorite = Favorite.new
		@newreply = Reply.new
		if Tweet.where(id: params[:id]).empty?
			redirect_to root_url
		end
	end
	private
	def tweet_params
      params.require(:tweet).permit(:body)
    end

end
