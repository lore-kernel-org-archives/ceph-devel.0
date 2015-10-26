From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] libceph: introduce ceph_x_authorizer_cleanup()
Date: Mon, 26 Oct 2015 20:06:56 +0800
Message-ID: <5F42126B-0464-4C31-8C84-510C827D11ED@redhat.com>
References: <1445861006-5324-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43662 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbbJZMHA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 08:07:00 -0400
In-Reply-To: <1445861006-5324-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org


> On Oct 26, 2015, at 20:03, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> Commit ae385eaf24dc ("libceph: store session key in cephx authorizer"=
)
> introduced ceph_x_authorizer::session_key, but didn't update all the
> exit/error paths.  Introduce ceph_x_authorizer_cleanup() to encapsula=
te
> ceph_x_authorizer cleanup and switch to it.  This fixes ceph_x_destro=
y(),
> which currently always leaks key and ceph_x_build_authorizer() error
> paths.
>=20
> Cc: Yan, Zheng <zyan@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
> net/ceph/auth_x.c | 28 +++++++++++++++++-----------
> net/ceph/crypto.h |  4 +++-
> 2 files changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index ba6eb17226da..65054fd31b97 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -279,6 +279,15 @@ bad:
> 	return -EINVAL;
> }
>=20
> +static void ceph_x_authorizer_cleanup(struct ceph_x_authorizer *au)
> +{
> +	ceph_crypto_key_destroy(&au->session_key);
> +	if (au->buf) {
> +		ceph_buffer_put(au->buf);
> +		au->buf =3D NULL;
> +	}
> +}
> +
> static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
> 				   struct ceph_x_ticket_handler *th,
> 				   struct ceph_x_authorizer *au)
> @@ -297,7 +306,7 @@ static int ceph_x_build_authorizer(struct ceph_au=
th_client *ac,
> 	ceph_crypto_key_destroy(&au->session_key);
> 	ret =3D ceph_crypto_key_clone(&au->session_key, &th->session_key);
> 	if (ret)
> -		return ret;
> +		goto out_au;
>=20
> 	maxlen =3D sizeof(*msg_a) + sizeof(msg_b) +
> 		ceph_x_encrypt_buflen(ticket_blob_len);
> @@ -309,8 +318,8 @@ static int ceph_x_build_authorizer(struct ceph_au=
th_client *ac,
> 	if (!au->buf) {
> 		au->buf =3D ceph_buffer_new(maxlen, GFP_NOFS);
> 		if (!au->buf) {
> -			ceph_crypto_key_destroy(&au->session_key);
> -			return -ENOMEM;
> +			ret =3D -ENOMEM;
> +			goto out_au;
> 		}
> 	}
> 	au->service =3D th->service;
> @@ -340,7 +349,7 @@ static int ceph_x_build_authorizer(struct ceph_au=
th_client *ac,
> 	ret =3D ceph_x_encrypt(&au->session_key, &msg_b, sizeof(msg_b),
> 			     p, end - p);
> 	if (ret < 0)
> -		goto out_buf;
> +		goto out_au;
> 	p +=3D ret;
> 	au->buf->vec.iov_len =3D p - au->buf->vec.iov_base;
> 	dout(" built authorizer nonce %llx len %d\n", au->nonce,
> @@ -348,9 +357,8 @@ static int ceph_x_build_authorizer(struct ceph_au=
th_client *ac,
> 	BUG_ON(au->buf->vec.iov_len > maxlen);
> 	return 0;
>=20
> -out_buf:
> -	ceph_buffer_put(au->buf);
> -	au->buf =3D NULL;
> +out_au:
> +	ceph_x_authorizer_cleanup(au);
> 	return ret;
> }
>=20
> @@ -624,8 +632,7 @@ static void ceph_x_destroy_authorizer(struct ceph=
_auth_client *ac,
> {
> 	struct ceph_x_authorizer *au =3D (void *)a;
>=20
> -	ceph_crypto_key_destroy(&au->session_key);
> -	ceph_buffer_put(au->buf);
> +	ceph_x_authorizer_cleanup(au);
> 	kfree(au);
> }
>=20
> @@ -653,8 +660,7 @@ static void ceph_x_destroy(struct ceph_auth_clien=
t *ac)
> 		remove_ticket_handler(ac, th);
> 	}
>=20
> -	if (xi->auth_authorizer.buf)
> -		ceph_buffer_put(xi->auth_authorizer.buf);
> +	ceph_x_authorizer_cleanup(&xi->auth_authorizer);
>=20
> 	kfree(ac->private);
> 	ac->private =3D NULL;
> diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
> index d1498224c49d..2e9cab09f37b 100644
> --- a/net/ceph/crypto.h
> +++ b/net/ceph/crypto.h
> @@ -16,8 +16,10 @@ struct ceph_crypto_key {
>=20
> static inline void ceph_crypto_key_destroy(struct ceph_crypto_key *ke=
y)
> {
> -	if (key)
> +	if (key) {
> 		kfree(key->key);
> +		key->key =3D NULL;
> +	}
> }
>=20
> int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
> =E2=80=94=20
> 2.4.3
>=20

Reviewed-by: Yan, Zheng <zyan@redhat.com>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
