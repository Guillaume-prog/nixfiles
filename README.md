# Installing the age keys

```bash
mkdir -p /var/lib/sops/age
```

```bash
scp /var/lib/sops/age/keys.txt machine:/var/lib/sops/age/keys.txt
```

or 

```bash
scp machine:/var/lib/sops/age/keys.txt /var/lib/sops/age/keys.txt
```