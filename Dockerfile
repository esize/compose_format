FROM alpine:3.16
LABEL maintainer="Shukri Yusof"

ENV PYTHONUNBUFFERED=1

RUN \
  apk add --no-cache python3 \
  gcc \
  musl-dev \
  python3-dev && \
  if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --no-cache --upgrade pip setuptools wheel && \
  if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

RUN pip3 install --prefer-binary --no-cache-dir ruamel.yaml
COPY bin /bin
COPY compose_format /usr/lib/python3.8/site-packages/compose_format
RUN chmod +x /bin/compose_format
ENTRYPOINT ["python3", "/bin/compose_format"]
