Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38837C0FB
	for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086923; cv=none; b=L3nNdSTMJ0dbhI3JTaMLuqbjEnADm+bRw33cwiyv3D1aZEwxuOClL/0X09OrDHnmhEt1wOwrzCEyu4LzQL8K4w7ons+hLDKCpTDPvXcvNFdloZu9emfX27bPyTxkgNPLikEClRIavVv16qK+I8jL72ORSZ6WKwNjEyCCIqE4tEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086923; c=relaxed/simple;
	bh=HKJxfEcxPZCNIb8eOzZHKs4t30gvRay1eQW47xZ8qcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vqxkj8CMnmfycesVnxbcnG068bS5DvxnD3EsC5a8akGXMah+TCulDP699ygdQR5wJXsipQQkYc+reEH983DoKONVL8THZOKHqJRIzSlFbx4kPjbit3FvQQh5OFoLKWa2UBppA/Ps7fQ0BSUcu9Rjb7CfHRkwxKY5Sl/vz64NntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBix8z7x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h94hgVhR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBix8z7x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h94hgVhR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780086921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=md2s7Le80YLcKkd87PcFhNS6MkcPGpt1yotu4GDnbN8=;
	b=SBix8z7x1S4blIUOznBKx0KqoKi+lUiPZaucc6Xuv4VVQxXZnl4p4Ks3EgnFJCYC29EtvR
	Hy/+aR/fE7s5PORD3X0kbhZA39Aj6Sdx0xvK+PR97qN2gb7KuTbgAqSBs/EjoXcZEZQpae
	qyadGDfR0q6w5AgFdNXEFRmJj8/p298=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-rleCqHNCM8-iovJe1HND4w-1; Fri, 29 May 2026 16:35:19 -0400
X-MC-Unique: rleCqHNCM8-iovJe1HND4w-1
X-Mimecast-MFC-AGG-ID: rleCqHNCM8-iovJe1HND4w_1780086919
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4857b690d44so2187158b6e.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780086919; x=1780691719; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=md2s7Le80YLcKkd87PcFhNS6MkcPGpt1yotu4GDnbN8=;
        b=h94hgVhRC6r/r8njxaJhZKdJVuDygh9kErzgaDcU+xA/qDCmWn7H/uCNQ1HXXvftQl
         qjFyn4rVWxlaIWUb2pKP+eEyfn6/o1bN0eIX4pV6J3sXYceK5w+r1q4AqPSRjM5R8/dD
         PehuxdEQ1IIqTNLZdsTq+n61ydzIsub16TEuYjFIj4lypMOLWX3zpUCow/ge2vOykrqA
         gmMY7MM8aWm6f0bLz3DhZDg6QMM2LSdAF5VUuWRGVupZtBL70Os/ZewTSDDuT02iGNRc
         QhibRHhvnwwzYDKS+asmI82UwTCAOYo0O0/QtOFuuShQuFp1OGBKFDQ6rCHq/DODnzZI
         4zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086919; x=1780691719;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=md2s7Le80YLcKkd87PcFhNS6MkcPGpt1yotu4GDnbN8=;
        b=bOmD+IvbnU8069PgdxR0hdvbgG/qxvjcZ2W/d3aUHoWpmuAgK62zn7XupeuOezr/XE
         eR271N1KPMhshiPIH8gWR8zOjJyIdUbiejotk1eFFueYiZWM5+4uW8vxg7/4G2DMKODt
         jXTpKlBiZvBtJ41vTapoz2fH0Ht2dcveFnqZT3CQhGcCp9kLEv/panDXMRBMxy4ip/td
         MhsLINY32qvJHj3f+3vL5W7B9I6dgO8D/WSirapqxTkBnt80k5SWsdvoYeU3MLwQvWON
         3Jv+olK5XqWf4r6kfCpz3Q0sCb3fVUMihE5R1cUze4poXwyM7RrMvemEIR1WC1SAMFoh
         eLfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PDCbbrUDouJtk0uFq5XM3oaOI+LsUpsNWq7530yqHGBzC4gmB3nLE+TyN1mIR8AphFVz02XI/vp3W@vger.kernel.org
X-Gm-Message-State: AOJu0YzMisFrafX3kZkZ1/N6lIwfKsU+TExeBQfLHA45GambpAxaXwJb
	3O/TTzCVJPcBLNqrQ3dRgP8109Uk2mwhBtXpHZwFT76TYcCW2ZJs3VMFVI0Mixgg2QUokIy7bby
	44GpJ/DmoRJ4w3nRjZ2j3abx3eW3OTsvzTJQhGty5K8/qvbPVpk1qlhfCjc4KIWk=
X-Gm-Gg: Acq92OH19pinU6va3nE5ElqA9kACDhWheOPdGY92aVpTcoVE0iGX/lZyeiMNzsjJNVY
	5Usb76kApowDWkSEMViEkgUr8/nOwHra+S4bDc+sPqnO6xsD4pwgdGOq7byj2RorFfatSiMI6/r
	eGpQfcTAkozVijv/0yaDPAXZ7aDWSWuCzy7ode4PLI5e0ih4QDD0hhDx6TawPuTIEUkVKx5mQ5t
	5qCGsSquMvdeTr/bht4nQ8xmmkkSyUhl0syJGPOe5+3YeT5yLBd+em5nUN2MxLGOYbJ7lwDblUs
	uLl9GUatppmVQWNKa8SuVSqclW45xTgvQkB7R9Sf9ioWjfGI0A1vHmiTFal0mfiuHU2X2uNyeN+
	89Ha6KP0r8DB4TYbmiE30Xcx+Iu+OiCJ2HozsrQZX0Q8fZTsQIX+DLkq2DqHNBV8=
X-Received: by 2002:a05:6808:c2f3:b0:479:db65:8dbc with SMTP id 5614622812f47-485fb3a09e5mr704612b6e.30.1780086918909;
        Fri, 29 May 2026 13:35:18 -0700 (PDT)
X-Received: by 2002:a05:6808:c2f3:b0:479:db65:8dbc with SMTP id 5614622812f47-485fb3a09e5mr704599b6e.30.1780086918529;
        Fri, 29 May 2026 13:35:18 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485edbc7454sm1311587b6e.1.2026.05.29.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:35:18 -0700 (PDT)
Message-ID: <1cab97763b0564d03a583deb7eed485b68be6182.camel@redhat.com>
Subject: Re: [PATCH 1/1] libceph: reject zero bucket types in crush_decode
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com,
 sage@newdream.net, 	yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, 	ldy3087146292@gmail.com
Date: Fri, 29 May 2026 13:35:16 -0700
In-Reply-To: <4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779949116.git.ldy3087146292@gmail.com>
References: <cover.1779949116.git.ldy3087146292@gmail.com>
	 <4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779949116.git.ldy3087146292@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 16:11 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> CRUSH bucket type 0 is reserved for devices.  The mapper relies on
> that invariant and uses type 0 to identify leaf devices.
>=20
> If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
> can make the mapper treat a negative bucket ID as a device and pass it
> to is_out(), which then indexes the OSD weight array with a negative
> value.
>=20
> Reject zero bucket types while decoding the CRUSH map so the invalid
> state never reaches the mapper.
>=20
> Fixes: f24e9980eb86 ("ceph: OSD client")
> Cc: stable@kernel.org

If I am not wrong, the correct email is stable@vger.kernel.org.

> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4

I am not sure that it's correct to mention it. But, maybe, my opinion is
slightly outdated.

> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/ceph/osdmap.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cf..226c9e0b7821 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -518,6 +518,8 @@ static struct crush_map *crush_decode(void *pbyval, v=
oid *end)
>  		ceph_decode_need(p, end, 4*sizeof(u32), bad);
>  		b->id =3D ceph_decode_32(p);
>  		b->type =3D ceph_decode_16(p);
> +		if (b->type =3D=3D 0)

I don't like of hardcoding the constant. Do we have named constant for devi=
ces
type? If we do not have, maybe, do we need to introduce some?

Thanks,
Slava.

> +			goto bad;
>  		b->alg =3D ceph_decode_8(p);
>  		if (b->alg !=3D alg) {
>  			b->alg =3D 0;

