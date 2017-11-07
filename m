From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: don't WARN() if user tries to add invalid key
Date: Tue, 7 Nov 2017 09:11:07 +0100
Message-ID: <CAOi1vP9ORzr46306U=dQ=7Wv=FsrjhRBTvw-L=WDDwiKsaURDw@mail.gmail.com>
References: <20171107055726.28099-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171107055726.28099-1-ebiggers3@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, keyrings@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 7, 2017 at 6:57 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> The WARN_ON(!key->len) in set_secret() in net/ceph/crypto.c is hit if a
> user tries to add a key of type "ceph" with an invalid payload as
> follows (assuming CONFIG_CEPH_LIB=y):
>
>     echo -e -n '\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' \
>         | keyctl padd ceph desc @s
>
> This can be hit by fuzzers.  As this is merely bad input and not a
> kernel bug, replace the WARN_ON() with return -EINVAL.
>
> Fixes: 7af3ea189a9a ("libceph: stop allocating a new cipher on every crypto request")
> Cc: <stable@vger.kernel.org> # v4.10+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  net/ceph/crypto.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> index 489610ac1cdd..bf9d079cbafd 100644
> --- a/net/ceph/crypto.c
> +++ b/net/ceph/crypto.c
> @@ -37,7 +37,9 @@ static int set_secret(struct ceph_crypto_key *key, void *buf)
>                 return -ENOTSUPP;
>         }
>
> -       WARN_ON(!key->len);
> +       if (!key->len)
> +               return -EINVAL;
> +
>         key->key = kmemdup(buf, key->len, GFP_NOIO);
>         if (!key->key) {
>                 ret = -ENOMEM;

Makes sense, applied.

Thanks,

                Ilya
