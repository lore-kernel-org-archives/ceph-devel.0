Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F637BE9E;
	Mon,  5 Oct 2026 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187740; cv=none; b=CfHINN5qf/NBl5l+T0s/+kPnnukOttY6mIekEJOUTD5Y+tlssrTj353W+Z8cX31cFGTiiwlOtF/eHMl4in4GaLOGmxNoIgLDs7dJgTzjfLtd5yJ22Y/70CCHGwMMkg4Qfm6MV3SFbeUC+mQhzzn4B8iXVL8qOCN0FkzfOMIBMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187740; c=relaxed/simple;
	bh=trtZaLJC3MhlKv9lnybxB/PWGn/R7M4m35xhpGgXBiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vih9S/b955qFBMv6qQ20CeB5FUZXIsjE9MXtClZeJ5L/qfJb1KNTf3dr1rZJhQmaRNtR978s+wGUSerGRJh9z9oo/LY8CPPXTzYiMy3Yp9wfrgZGsmQaYqzyLqW2VC+jha6/32k82bg3gbTtldA9o3LDDRvQkHINnKPnIY9y86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt3a4Fpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt3a4Fpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3591F000FF;
	Mon,  5 Oct 2026 08:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187738;
	bh=Mx+nbYRXzNl44D5NyykgGkBrWZ5MiNy9Yx1ZnBFphJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jt3a4FppBZLrmmVsjVqAQ6buJqHNbIHxZvpGHls9B6SuenV5GY6qGf33ihRhDEGJN
	 /2XigapzV3e62VBA6v9gCoMuUy9lgXX5n8NZT7o4kn0saqAOuCX96JRtpqByjgkrrP
	 EAWq+dvVkp2EwdNhv/ujRQRjsmChbFaNiTyyYSe36fsd1H223aZGjio8mq+GU3/Fnk
	 K5FwvnpSivfB777OxCgRjMFt7VIAPB20FfDakoaqSOa1nNpwvEYg2j/ql8+GqNJsKN
	 zKhr6Krro9ba3xlKPMqV5Lqa/Enz5ADn8sjtozG+4TLk/0nVHHuwzFbu6MLiIAZ3TY
	 fwjzCwLUxo98g==
Date: Mon, 5 Oct 2026 10:08:53 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] ceph: use a flexible array for monitor addresses
Message-ID: <asNa11wqowvRtIXE@debian>
References: <20261005001955.589395-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22jjbyyticpuppkd"
Content-Disposition: inline
In-Reply-To: <20261005001955.589395-1-rosenp@gmail.com>


--22jjbyyticpuppkd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] ceph: use a flexible array for monitor addresses
Message-ID: <asNa11wqowvRtIXE@debian>
References: <20261005001955.589395-1-rosenp@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261005001955.589395-1-rosenp@gmail.com>

Hi,

> Date: 2026-10-04 17:19:55-0700
> From: Rosen Penev <rosenp@gmail.com>
>
> ceph_alloc_options() allocates the monitor address array separately,
> always sized for CEPH_MAX_MON entries. Make it a flexible array member
> at the end of struct ceph_options and allocate both together with
> kzalloc_flex(). The array was already an 8 KiB slab object, so this
> only drops the separate allocation and its error path.
>=20
> num_mon is the number of addresses in use, not the capacity, so the
> array cannot be annotated with __counted_by().
>=20
> ceph_compare_options() memcmp()s the simple fields up to the first
> member that needs a custom comparison. With mon_addr gone from there,
> use num_mon as that boundary; the compared fields are unchanged.
> Document that num_mon has to stay first past that point.
>=20
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  include/linux/ceph/libceph.h |  7 ++++---
>  net/ceph/ceph_common.c       | 11 ++---------
>  2 files changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index f92fdd853f1f..e585d6d11303 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -57,15 +57,16 @@ struct ceph_options {
>  	/*
>  	 * any type that can't be simply compared or doesn't need
>  	 * to be compared should go beyond this point,
> -	 * ceph_compare_options() should be updated accordingly
> +	 * ceph_compare_options() should be updated accordingly.
> +	 * num_mon must stay the first member past this point, as
> +	 * ceph_compare_options() uses it as the end of the memcmp().
>  	 */
> =20
> -	struct ceph_entity_addr *mon_addr; /* should be the first
> -					      pointer type of args */
>  	int num_mon;
>  	char *name;
>  	struct ceph_crypto_key *key;
>  	struct rb_root crush_locs;
> +	struct ceph_entity_addr mon_addr[];
>  };
> =20
>  /*
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index a797c7360e3c..95dc18257056 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -133,7 +133,7 @@ int ceph_compare_options(struct ceph_options *new_opt,
>  {
>  	struct ceph_options *opt1 =3D new_opt;
>  	struct ceph_options *opt2 =3D client->options;
> -	int ofs =3D offsetof(struct ceph_options, mon_addr);
> +	int ofs =3D offsetof(struct ceph_options, num_mon);
>  	int i;
>  	int ret;
> =20
> @@ -309,17 +309,11 @@ struct ceph_options *ceph_alloc_options(void)
>  {
>  	struct ceph_options *opt;
> =20
> -	opt =3D kzalloc_obj(*opt);
> +	opt =3D kzalloc_flex(*opt, mon_addr, CEPH_MAX_MON);

Oh, there's indeed a kzalloc_flex().  Why is it not used in the other
patches?  (I'm not all that happy with the current API of this _flex()
variant, but it's better than nothing.)


Have a lovely day!
Alex

>  	if (!opt)
>  		return NULL;
> =20
>  	opt->crush_locs =3D RB_ROOT;
> -	opt->mon_addr =3D kzalloc_objs(*opt->mon_addr, CEPH_MAX_MON);
> -	if (!opt->mon_addr) {
> -		kfree(opt);
> -		return NULL;
> -	}
> -
>  	opt->flags =3D CEPH_OPT_DEFAULT;
>  	opt->osd_keepalive_timeout =3D CEPH_OSD_KEEPALIVE_DEFAULT;
>  	opt->mount_timeout =3D CEPH_MOUNT_TIMEOUT_DEFAULT;
> @@ -344,7 +338,6 @@ void ceph_destroy_options(struct ceph_options *opt)
>  		ceph_crypto_key_destroy(opt->key);
>  		kfree(opt->key);
>  	}
> -	kfree(opt->mon_addr);
>  	kfree(opt);
>  }
>  EXPORT_SYMBOL(ceph_destroy_options);
> --=20
> 2.56.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--22jjbyyticpuppkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrDWxQACgkQ64mZXMKQ
wqntOA//a86yyT3keMHPYFgUbEkw/SV6QoeAAvRkk0BuLl729WRbSRL8SIiEyldW
2SDHSk3OZgP2MUuEX7DO+vx2FJxkWlaD3Fuwx126ZuERASAP17a5gBMnb4UJ8yFo
rLWd87SbOhS7pHsV1jFUbw7lMftkQ+wM7G9D42Mfax03UWuQ2jTGSAGsLXccngbz
Ed7yaGbaLLorjunzIMhLicM5mMnhtoUGhgMW0bFRnoVQgxea+HlyRuiMyp3eJsoc
2+zsA4ioTsdY/WUoyXyeaWIiCqQB4WZ59qw2qDVA4JHdp+HqR2AF62xFehXB9jxn
cPlidWAi1ZBrEkPmSGx+ckufdwdmOZB80ntm5JV6ldRkNcUFpXZ29qT9tGtV4X0Q
2eP0JBzkizlaijztW+zbVfzgfowSKdcSMtzJAppGFKJ6xP8bQH+xSgiSO3ekmuVs
SjKcSsdPi923KIsQoqPvtboFPL70ga5uJE3sLNW0nQeeQl/WecPNainlDYrkIxAU
XwitnyvHgjKgO+yskTH+65rZKOyNm9ATc+CYtTRzGIkk+LEhIfVl8/A3NIlhC/wa
qiWISYKKHrbnZbXpBK4NOLkNZc58ilfHkAdDKCuAF4vt0MoMkOdOuxHKMqsgjVy7
BpZpgd00FxYVowg/fen2eZFPrQs9c20UDzRoaswRfW6xaBO7NIo=
=eXCR
-----END PGP SIGNATURE-----

--22jjbyyticpuppkd--
