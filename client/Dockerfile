FROM node:22.13.0

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm install

# Fix esbuild platform mismatch issue
RUN npm rebuild esbuild

# (Optional) install react-router-dom only if it's not in package.json
# RUN npm install react-router-dom

COPY . .

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
