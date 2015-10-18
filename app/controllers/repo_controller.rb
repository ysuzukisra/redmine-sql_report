class RepoController < ApplicationController
  unloadable

  def index
    # :cmd = 'xxx'
    # para {
    #   :name
    #   caption
    #   type
    #   optional
    #   default
    # }
    
    # クエリ・クエリパラメータ初期化
    @query_spec = {
      sql: 'select %{repo_user} as repo_user, %{repo_date} as repo_date',
      param_spec: {
        repo_user: User.current.id,
        repo_date: Date.today(),
      },
    };
    
    # クエリパラメータ読み出し
    @query_params = @query_spec[:param_spec].clone
    @query_spec[:param_spec].keys.each do |k|
      @query_params[k] = params[k] if params[k];
    end

    # デバッグ用
    @query_spec[:sql] = params[:sql] if params[:sql];

    # 必要パラメータが揃っていたらクエリ実行
    para_ok = true
    @query_spec[:param_spec].keys do |k|
      para_ok &= @query_params[k]
    end
    if para_ok then
      #@query_params = params.merge(@query_params) #.with_indifferent_access
      params.each do |k,v|
        @query_params[k.to_sym] ||= params[k]
      end
      p = @query_params.clone
      p.each do |k,v|
        p[k] = ActiveRecord::Base::sanitize(v)
        p[k.to_sym] = ActiveRecord::Base::sanitize(v)
      end
      begin
        @query = sprintf @query_spec[:sql], p
        ActiveRecord::Base.connection.transaction do
          @result = ActiveRecord::Base.connection.select_all(@query)
        end
      rescue StandardError => e # ActiveRecord::ActiveRecordError => e
        flash.now[:error] = e.message
      ensure
        @result ||= []
      end
    else
      @result = []
    end
    
  end
end
