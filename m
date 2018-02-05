From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/2] ceph: avoid NULL pointer dereference in ceph_crypto_key_destroy()
Date: Mon, 5 Feb 2018 14:11:29 +0100
Message-ID: <CAOi1vP_edS5MRhO0tJo6Zg9t4M-7yJY+1J-kOzS4pg02EwtNOQ@mail.gmail.com>
References: <1517738929-229785-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP8bFvd5OjC+whKQMSaLV46YyErF5DA-Q4udzWpFuCk7Dw@mail.gmail.com> <EA91EF3C-968A-4277-A887-2FD6E22A1030@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:43623 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeBENLb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 08:11:31 -0500
Received: by mail-io0-f196.google.com with SMTP id 72so30143267iom.10
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 05:11:30 -0800 (PST)
In-Reply-To: <EA91EF3C-968A-4277-A887-2FD6E22A1030@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

On Mon, Feb 5, 2018 at 1:06 PM, Chengguang Xu <cgxu519@icloud.com> wrote:
>
>
> Thanks,
> Chengguang.
>
>
>
>> =E5=9C=A8 2018=E5=B9=B42=E6=9C=885=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=887:=
51=EF=BC=8CIlya Dryomov <idryomov@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Sun, Feb 4, 2018 at 11:08 AM, Chengguang Xu <cgxu519@icloud.com> wrot=
e:
>>> There are many reasons of failure from get_secret(),
>>> so it's necessary to add a check before calling crypto_free_skcipher()
>>> in case of NULL pointer dereference.
>>>
>>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>>> ---
>>> net/ceph/crypto.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
>>> index bf9d079..bb1dc2d 100644
>>> --- a/net/ceph/crypto.c
>>> +++ b/net/ceph/crypto.c
>>> @@ -136,8 +136,10 @@ void ceph_crypto_key_destroy(struct ceph_crypto_ke=
y *key)
>>>        if (key) {
>>>                kfree(key->key);
>>>                key->key =3D NULL;
>>> -               crypto_free_skcipher(key->tfm);
>>> -               key->tfm =3D NULL;
>>> +               if (key->tfm) {
>>> +                       crypto_free_skcipher(key->tfm);
>>> +                       key->tfm =3D NULL;
>>> +               }
>>>        }
>>> }
>>
>> Hi Chengguang,
>>
>> crypto_free_skcipher() can handle a NULL pointer just fine:
>>
>>    void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
>>    {
>>            struct crypto_alg *alg;
>>
>>            if (unlikely(!mem))
>>                    return;
>
> Hi Ilya,
>
> How about crypto_skcipher_tfm() in below call stack?
>
> ceph_crypto_key_destroy() -> crypto_free_skcipher() -> crypto_destroy_tfm=
() -> crypto_skcipher_tfm()
>
> static inline struct crypto_tfm *crypto_skcipher_tfm(
>         struct crypto_skcipher *tfm)
> {
>         return &tfm->base;
> }

That's an address-of, not a dereference.  When tfm is NULL, the result
is the offset of base in crypto_skcipher.

Thanks,

                Ilya
