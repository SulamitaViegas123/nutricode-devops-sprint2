FROM node:18-alpine
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /usr/src/app
#copiar package.json e instalar dependências
COPY app/package.json ./
RUN npm install --production
COPY app/ ./
RUN chown -R appuser:appgroup /usr/src/app
USER appuser
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget -qO- --timeout=2 http://localhost:3000/ || exit 1
EXPOSE 3000
CMD ["node", "index.js"]
