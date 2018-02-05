From: Chengguang Xu <cgxu519@icloud.com>
Subject: Re: [PATCH 1/2] ceph: avoid NULL pointer dereference in
 ceph_crypto_key_destroy()
Date: Mon, 05 Feb 2018 20:06:26 +0800
Message-ID: <EA91EF3C-968A-4277-A887-2FD6E22A1030@icloud.com>
References: <1517738929-229785-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP8bFvd5OjC+whKQMSaLV46YyErF5DA-Q4udzWpFuCk7Dw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:45675 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeBEMGo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 07:06:44 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp001.me.com by
 pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3O00J00EYD4M00@pv33p36im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Mon, 05 Feb 2018 12:06:44 +0000 (GMT)
In-reply-to: <CAOi1vP8bFvd5OjC+whKQMSaLV46YyErF5DA-Q4udzWpFuCk7Dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>



Thanks,
Chengguang.



> =D4=DA 2018=C4=EA2=D4=C25=C8=D5=A3=AC=CF=C2=CE=E77:51=A3=ACIlya =
Dryomov <idryomov@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Sun, Feb 4, 2018 at 11:08 AM, Chengguang Xu <cgxu519@icloud.com> =
wrote:
>> There are many reasons of failure from get_secret(),
>> so it's necessary to add a check before calling =
crypto_free_skcipher()
>> in case of NULL pointer dereference.
>>=20
>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>> ---
>> net/ceph/crypto.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
>> index bf9d079..bb1dc2d 100644
>> --- a/net/ceph/crypto.c
>> +++ b/net/ceph/crypto.c
>> @@ -136,8 +136,10 @@ void ceph_crypto_key_destroy(struct =
ceph_crypto_key *key)
>>        if (key) {
>>                kfree(key->key);
>>                key->key =3D NULL;
>> -               crypto_free_skcipher(key->tfm);
>> -               key->tfm =3D NULL;
>> +               if (key->tfm) {
>> +                       crypto_free_skcipher(key->tfm);
>> +                       key->tfm =3D NULL;
>> +               }
>>        }
>> }
>=20
> Hi Chengguang,
>=20
> crypto_free_skcipher() can handle a NULL pointer just fine:
>=20
>    void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
>    {
>            struct crypto_alg *alg;
>=20
>            if (unlikely(!mem))
>                    return;

Hi Ilya,

How about crypto_skcipher_tfm() in below call stack?

ceph_crypto_key_destroy() -> crypto_free_skcipher() -> =
crypto_destroy_tfm() -> crypto_skcipher_tfm()
                                                                         =
     =20
static inline struct crypto_tfm *crypto_skcipher_tfm(
	struct crypto_skcipher *tfm)
{
	return &tfm->base;
}





