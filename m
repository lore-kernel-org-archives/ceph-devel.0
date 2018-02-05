From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/2] ceph: avoid NULL pointer dereference in ceph_crypto_key_destroy()
Date: Mon, 5 Feb 2018 12:51:02 +0100
Message-ID: <CAOi1vP8bFvd5OjC+whKQMSaLV46YyErF5DA-Q4udzWpFuCk7Dw@mail.gmail.com>
References: <1517738929-229785-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:38194 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeBELvD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 06:51:03 -0500
Received: by mail-io0-f193.google.com with SMTP id d13so29956985iog.5
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 03:51:03 -0800 (PST)
In-Reply-To: <1517738929-229785-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

On Sun, Feb 4, 2018 at 11:08 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> There are many reasons of failure from get_secret(),
> so it's necessary to add a check before calling crypto_free_skcipher()
> in case of NULL pointer dereference.
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
>  net/ceph/crypto.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> index bf9d079..bb1dc2d 100644
> --- a/net/ceph/crypto.c
> +++ b/net/ceph/crypto.c
> @@ -136,8 +136,10 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
>         if (key) {
>                 kfree(key->key);
>                 key->key = NULL;
> -               crypto_free_skcipher(key->tfm);
> -               key->tfm = NULL;
> +               if (key->tfm) {
> +                       crypto_free_skcipher(key->tfm);
> +                       key->tfm = NULL;
> +               }
>         }
>  }

Hi Chengguang,

crypto_free_skcipher() can handle a NULL pointer just fine:

    void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
    {
            struct crypto_alg *alg;

            if (unlikely(!mem))
                    return;

Thanks,

                Ilya
