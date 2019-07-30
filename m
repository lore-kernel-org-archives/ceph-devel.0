From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] net: ceph: Fix a possible null-pointer dereference in ceph_crypto_key_destroy()
Date: Tue, 30 Jul 2019 11:41:20 +0200
Message-ID: <CAOi1vP8Q=fYZWv9qFZcyBdKV1VYq_yr3qWyAb44W=jHZ6zfYrA@mail.gmail.com>
References: <20190724094306.1866-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190724094306.1866-1-baijiaju1990@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jul 24, 2019 at 11:43 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> In set_secret(), key->tfm is assigned to NULL on line 55, and then
> ceph_crypto_key_destroy(key) is executed.
>
> ceph_crypto_key_destroy(key)
>     crypto_free_sync_skcipher(key->tfm)
>         crypto_skcipher_tfm(tfm)
>             return &tfm->base;
>
> Thus, a possible null-pointer dereference may occur.
>
> To fix this bug, key->tfm is checked before calling
> crypto_free_sync_skcipher().
>
> This bug is found by a static analysis tool STCheck written by us.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  net/ceph/crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> index 5d6724cee38f..ac28463bcfd8 100644
> --- a/net/ceph/crypto.c
> +++ b/net/ceph/crypto.c
> @@ -136,7 +136,8 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
>         if (key) {
>                 kfree(key->key);
>                 key->key = NULL;
> -               crypto_free_sync_skcipher(key->tfm);
> +               if (key->tfm)
> +                       crypto_free_sync_skcipher(key->tfm);
>                 key->tfm = NULL;
>         }
>  }

Hi Jia-Ju,

Yeah, looks like the only reason this continued to work after
69d6302b65a8 ("libceph: Remove VLA usage of skcipher") is because
crypto_sync_skcipher is a trivial wrapper around crypto_skcipher
added just for type checking AFAICT.

struct crypto_sync_skcipher {
    struct crypto_skcipher base;
};

Before that ceph_crypto_key_destroy() used crypto_free_skcipher(),
which is safe to call on a NULL tfm.

Applied with a slight modification -- I moved key->tfm = NULL under
the new if and amended the changelog.

https://github.com/ceph/ceph-client/commit/b3d79916ff99074d289d66f1643b423ae0008c50

Thanks,

                Ilya
