base:
  '(minion|minion-node2).Saltstack.com':
    - match: pcre
    - init.pkg
    - init.limit
