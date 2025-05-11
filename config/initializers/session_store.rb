if Rails.env.development?
  # Em desenvolvimento: força invalidação das sessões antigas a cada reinício
  Rails.application.config.session_store :cookie_store,
                                         key: "_app_session_#{Time.now.to_i}"
else
  # Em produção: mantém uma chave fixa e segura
  Rails.application.config.session_store :cookie_store, key: '_app_session'
end
