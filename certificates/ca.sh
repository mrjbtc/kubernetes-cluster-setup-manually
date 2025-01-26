sudo openssl genrsa -out ca.key 4096
openssl req -x509 -new -sha512 -noenc \
    -key ca.key -days 3653 \
    -config ca.conf \
    -out ca.crt


# output
# ca.crt ca.key