Doorkeeper::OpenidConnect.configure do
  issuer 'asdfghj'

  signing_key <<-EOL
-----BEGIN PRIVATE KEY-----
MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQD0cs0Z72VkMOZE
LQQ/mkke1+bxU3FjTME/9RmONQ1/siliU6/uYI3HdepNkbYlRk2l05T/Mqs81mKT
pUg/s3LK7SARDknrcPt23lVXXjydfT8H5qSp18UvaP/ibIB9zffgAO1FVUGkDsQJ
k1vWPJd1SEctj80BebQpxuCRHAiyVEzILoHKZ0IYCpL0Wm9S8HxrGILkv6b0lo8T
6Jmj8xMRVyaXJXj424Z9vxdBnvsKe4UnB6IonrEzDO7Q4TFe/yyC8Trl0t/AuNEx
0GDJycWCvZ6UnbDVlGdxWU/dJsS9cTbNirRdo60PZWBCcLigRdw0xmTX63ZHV4iA
7zQuqdv7AgMBAAECggEBAKK/gCBBS77984D2e7qgzQf09LQ9OuPC6XLci0wrtDYN
dxIY56wMqrheoEVOuvdsLCw4hx21LV7O2Ui1pTmMDuReJZhVbA+N5E4KzsThX/f2
uC1ZeM3/czASdzLXzGB17g88brxXe+FvV0OM0Xr8UlZqbcE+2V2fGr0pxL+3625V
9rbV2Qz4+WZrXIef+7v0Cva0/lMa3XKwPMJSV7lxG4jvaQooBHdQv1xh7LN/lA7I
Otz/gsLahNxRdfHNp/T0dpJBwGjTlFn5PxI/TuM8Arm9u1Y0XyTUqKxVwBA0NNpl
QDwFcXUOg/2WsPKlHN35ibMPvd1uvlPbgUmS1wJr2/kCgYEA/lIfQ0l+Z+Gyd3ux
Q0wTKsTIfocd5CKLD3Styl9llhyf6VCH7qXB63ApntGgV4f1VHmUBpL+7zBbzmqS
eXsbq40KhJnBrMtim09zNGIvf0FtDeDgH7n5qKculVFJA1+9JyoTMWnnhcHE1wAk
FV2YlnTFf/HuN2y2jTWQ6TAjycUCgYEA9g/96dGQkVKgBVi0mtnn9l7Ybul8O09t
VgJUpG1mitTXDQ/5ffXsTTsX62OzkM8qJ5yL1aGw6jyHL9WgblwggEgXf8hHr5of
flQaCQRU4l5vuBym8/GyYYUpRvVhAKCtCNHBIpxusg9a+PMIw471cJ+XR9KnTKxl
nIQ50EssKr8CgYEAseiVAicpjFYw2LDo4mEXj3W1o/21hWA804UWBloR4J8Jpte1
H9dI/wCpvPZ8Kn9rubqLOMYgHQdBUfbvnJfoVWwHDZfaCp0E0A0WVHDTNTx5o5nK
b6dT5Q1+4unIH9oboogmgQzK76ELqDPrCh89nRL3DngZ4x/j3Ii6ZMZOYtkCgYEA
wRyn4BuSZBr+b3PAuk8OF3M0VUd1Mm8RlhDaMPmTIp4L8Lp6yfp5a9tW2Gw0/w83
PENGE3GEkTDTwBzeff5bm5H4r1aVvCEvWkvS6wS1Qbtv3oTOGmGz54lEbeYiLQXt
ByDnfKxcy+31LbA/Tosh4TO+3KVcm3YpgP7dCLYWga0CgYBZbKzqXNi4RvCO0LEl
sGmgG1kl1xxF3ehZ5Ves2DtQSWjg3zi4R0PdVeeen7WcSDCHljVzDK5l9CNctQpJ
KaMo6Wk7jW2xSwBmRPHWT+uLkH87ymRNEDh9apfhH6lXiPEQvMpNA7AyPkfhNX1M
ApAfnkhWwh8/q2r1QyBgxYPgqQ==
-----END PRIVATE KEY-----  
EOL

  subject_types_supported [:public]

  resource_owner_from_access_token do |access_token|
    # Example implementation:
    User.find_by(id: access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    # Example implementation:
    resource_owner.current_sign_in_at
  end

  reauthenticate_resource_owner do |resource_owner, return_to|
    # Example implementation:
    store_location_for resource_owner, return_to
    sign_out resource_owner
    redirect_to new_user_session_url
  end

  subject do |resource_owner, application|
    # Example implementation:
    resource_owner.id

    # or if you need pairwise subject identifier, implement like below:
    # Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{'your_secret_salt'}")
  end

  # Protocol to use when generating URIs for the discovery endpoint,
  # for example if you also use HTTPS in development
  # protocol do
  #   :https
  # end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  # Example claims:
  # claims do
  #   normal_claim :_foo_ do |resource_owner|
  #     resource_owner.foo
  #   end

  #   normal_claim :_bar_ do |resource_owner|
  #     resource_owner.bar
  #   end
  # end
end
