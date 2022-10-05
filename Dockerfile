FROM node:16-alpine3.15

WORKDIR "/app"

RUN npm install create-elm-app -g

RUN create-elm-app building-elm-app

RUN cd building-elm-app && ls -a

EXPOSE 3000
WORKDIR "/app/building-elm-app"
CMD ["elm-app", "start"]

