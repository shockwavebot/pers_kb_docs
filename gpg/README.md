# GPG keys

Keyservers:

- https://pgp.mit.edu/
- https://keyserver.opensuse.org/
- http://hkps.pool.sks-keyservers.net/

### Generate GPG key pair 

`gpg2 --full-generate-key`

### Encrypt and decrypt a document

`gpg --output doc.gpg --encrypt --recipient name@his.org doc`

`gpg --output doc --decrypt doc.gpg`

### Key mgm

#### List public keyrings 

`gpg --list-keys` or `gpg -k`

#### Get the key fingerprint 

`gpg --fingerprint keyname`

Example: `CE69 32C8 5798 5125 33E4  447D D588 E47E 9BD7 E6F6`

Last 8 can be used as keyID or keyname: `9BD7E6F6`

#### Edit key

`gpg --edit-key keyname`

#### Add email 

`gpg --edit-key keyname` -> adduid -> save

### Export public key

`gpg --export -a keyname > keyname.pub`

### Signing key

`gpg --list-sigs`

1. get key to sign `gpg --keyserver keyserver.opensuse.org --recv 29485B97`
2. `--edit-key` -> `sign` -> `save`
3. upload `gpg --send-keys --keyserver keyserver.opensuse.org keyname`

