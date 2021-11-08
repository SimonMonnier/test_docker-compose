FROM elixir:1.12

RUN apt-get update \
&& apt-get install -y nodejs npm \
&& apt-get install -y postgresql-client \
&& apt-get install inotify-tools -y \
&& npm init -y

RUN mkdir /app

COPY . /app/

WORKDIR /app/

RUN mix local.hex --force \
&& mix deps.get --force \
&& mix local.rebar --force \
&& mix deps.compile \
&& chmod +x entrypoint.sh 

WORKDIR /app/assets/

RUN npm install -y

WORKDIR /app/

CMD ["/app/entrypoint.sh"]