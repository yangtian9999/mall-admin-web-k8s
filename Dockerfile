FROM node:12.14.0 AS builder

ADD . /home/

WORKDIR /home
RUN npm config set registry https://registry.npm.taobao.org \
    && npm config set registry https://registry.npmjs.org 
#RUN npm audit fix --force
RUN npm install
RUN npm run build

FROM nginx:1.22
RUN mkdir -p /usr/share/nginx/html/
COPY --from=builder /home/dist /usr/share/nginx/html
ADD ./nginx.conf /usr/share/nginx
