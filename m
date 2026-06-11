Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C82BE7D1
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156297; cv=none; b=rwslZjv5f4rgZ7QUDiXjT2+tVLoVOugFRxyqM96kuzxR77sxKNCpkyO2JplORdI/sxRd/jElydYaJFGoiMALnwAwdY9F30yDIv/bohlGbufeh4m6uUFaWqiGWdR+1BU4+JTVVFeHx/NZKzXUx0WeFjYvhFimcE5Inl3klKlDskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156297; c=relaxed/simple;
	bh=+Fdtxa5F4I3B1m6IrpUXcbRnO49UYwJSgHWvKWLKZBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5wPqM3m8MkFNBfXH9C7RJRnMkHXHpXtJCgvvco/++RrriP/a8nWbP5CpL+cSfbZ8KE613kxvIV/qT4jpqfxEOsuIvKgnZuf57DqNXTah3raw6wsMzKCSgdhI5x5oIPQ9oJdbm9qN4nYSkKXg8fx8M5g6bl+fygzzwY0rASqpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Ech7pjxY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Ech7pjxY"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so7624589e87.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 22:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781156294; x=1781761094; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+gb50sn9udPMwB2zWS57M9z2FN0zYJfa0lks3a19q6E=;
        b=Ech7pjxYtEGKkeVDIN4dUx1C7zcYjCGSnyUznpem55/ooATNpfLrMKIzwUXLVNKJX3
         O6yNTgS5N7Y2U60cEhJHxiCwPWUIgFcBC7XGUgmX4ucDHHHYrFMEq8ktL7STyfHbBnJt
         OGxwkPLrLweTsfM83JfrBStPu2j0dOVnsjOMSuF33Cyht6qxOZ97ehA8EyY7jv3I7v4A
         RuLZnAvGoYPPyR4p0+5QLN8SG7CXqBgxfBonqx2EcQGeE0dxly66LBtuZePbWcjiiiMZ
         fZK6mcMbDy96cRSte6cDHGw9U1m5h/+r26bp6UcOzRgon1d6jVq0sWPODKhi/blXwkPj
         Dysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781156294; x=1781761094;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gb50sn9udPMwB2zWS57M9z2FN0zYJfa0lks3a19q6E=;
        b=gY5Ily3iR9dllRemlHDwCFSMkPxfsQaqfmyshGTPfK0jiTe4/8xxyg36VnwVis6VCV
         E13wlWx6MF2Dgs5Ei3S1VsbMWTxS80ZjbU/XX4hfYuiD0OkeVAj8RTysOpriu5VYXr99
         C3GBui9OXdWCXoTlhkz4XPs9yiVLYKeDiNxrLUOLXHGI4tB3a5lQRVHeFEqosSX0jaPb
         ZcpOEL7SJVsz5GnULFA9w9SJc9Zy/AFe86oGHPBMNuVJoufWDl+VZLWXQg9+i5c6XCQs
         DW+/QCk6z5Gukxbx+x8itfM+/QGO0vjv7EGJPbwcn/yMxmN3xKDXS7+HiJj8yVnY31yk
         RH9w==
X-Gm-Message-State: AOJu0YwyKdoNmGQhISOpFaM639vS2hs5XV8055YMWJIO/KPUk8QlAryz
	MFXsL7vLxx2v0RxEMj2goHwkVBN7ooFF1IEm6fX7FUu2s/yBQdBHMPEBLl6VtOlR5/tS2vom6Bl
	6p2vpsk/8Xg==
X-Gm-Gg: Acq92OF4/kkHTBBEfxubXAzpHyOnMunSB2wZQiGqHLSkX3qgaPOufIcgPCMoYuMYdci
	SjRAX160Ze19KicoekFPzlo1UC4DovHcmOtyALLeZSm3pnas3474298KfGzU1JXN9WSAlsw5ElO
	jEuMC/lo4H5ul3aLkMRSFvPJVgYTw+zRdJkW6x84MC9uNFCbfNksJT1dV+4tW6fs1tCe8vNeO5t
	IOiZ2mfwsagzu5gJ8r5t/AQxrooI4cpWpNsyOmKqJUKU/aHLtB4bPf2I+Mp21lQnrKJxtEFO3KT
	eLtPwAiEXUqY67Ef84swqmuR6REip8WDFsxVHsKhzJvS9JfLf1kmvAs1tPn0PPXKODa7T2/w9Eo
	zZUQftGeQfdG0/sACWbZxiZgksgIN+Xywt5UXmTQLAdT3a0my6CU06QlwR98iV1X14EtK/joNm9
	HenXz8TWrXRG+VvobF4DeTAoZ2pJF7jutvXo4VlbnCCD6QpeslHT0DAQ99r2iqVP678mny/2fLI
	RNY3gaTeeXzXstpuj5SnTNTf5Yua/mTLczJzaKYQlD/laO321JVGN0cVRrlNgEH75k=
X-Received: by 2002:a05:6512:3d17:b0:5aa:6c26:bb25 with SMTP id 2adb3069b0e04-5ad27aa557amr350541e87.11.1781156294004;
        Wed, 10 Jun 2026 22:38:14 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991aca423esm1561551fa.12.2026.06.10.22.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 22:38:13 -0700 (PDT)
Message-ID: <959f085e6081d34fd5a02826e1309d83b433a06e.camel@dubeyko.com>
Subject: Re: [PATCH v2 3/4] ceph: bound num_export_targets array for mds
 info v2/v3
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2026 22:38:12 -0700
In-Reply-To: <9d77173c026185448a9a7fc9b22c18f0a915d161.1780766417.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
	 <cover.1780766417.git.michael.bommarito@gmail.com>
	 <9d77173c026185448a9a7fc9b22c18f0a915d161.1780766417.git.michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-06 at 15:00 -0400, Michael Bommarito wrote:
> ceph_mdsmap_decode() in fs/ceph/mdsmap.c reads num_export_targets
> from
> each per-mds info record and advances the decode cursor by
> num_export_targets * sizeof(u32) without first checking that many
> bytes
> remain. The only upper-bound check that catches a runaway cursor
> (*p > info_end) is gated on info_v >=3D 4, because info_end is left
> NULL
> for info_v 2 and 3. When the monitor sends an MDS map whose per-mds
> info version is 2 or 3 with an oversized num_export_targets, the
> cursor
> moves past the message front buffer and the later export-targets loop
> calls the unchecked ceph_decode_32() on out-of-bounds memory.
>=20
> A kernel client processes CEPH_MSG_MDS_MAP from its monitor session
> (net/ceph/mon_client.c dispatches it; fs/ceph/super.c routes it to
> ceph_mdsc_handle_mdsmap(), which sets end to the front buffer bound
> and
> calls ceph_mdsmap_decode()). A malicious or compromised monitor, or
> an
> on-path attacker on an unsigned/unencrypted messenger session, can
> therefore drive an out-of-bounds read in the client kernel; on x86_64
> with KASAN it is reported as a slab-out-of-bounds read in
> ceph_mdsmap_decode(). The decoded values land in the internal
> info->export_targets[] array, so the consequence is a kernel
> out-of-bounds read, not an information leak to the attacker.
>=20
> Impact: a malicious or compromised Ceph monitor sending an MDS map
> with
> a per-mds info version of 2 or 3 and an oversized num_export_targets
> field triggers an out-of-bounds read in the CephFS client kernel.
>=20
> Add a ceph_decode_need() for the export-targets array before
> advancing
> the cursor, so the bound is enforced for every info_v >=3D 2, not only
> info_v >=3D 4. This mirrors the count-then-need idiom already used for
> m_data_pg_pools later in the same function.
>=20
> Compute the export-targets byte count with size_mul() and reuse that
> checked length when advancing the cursor, so the attacker-controlled
> num_export_targets multiplication fails closed on overflow rather
> than
> relying on the later kcalloc() guard.
>=20
> Fixes: d463a43d69f4 ("ceph: CEPH_FEATURE_MDSENC support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2:
> - Compute the export-targets byte count with size_mul() and reuse the
> =C2=A0 checked length when advancing the cursor.
>=20
> =C2=A0fs/ceph/mdsmap.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index d8e46eb7e5eb5..c0f63f0460f67 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -3,6 +3,7 @@
> =C2=A0
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/err.h>
> +#include <linux/overflow.h>
> =C2=A0#include <linux/random.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/types.h>
> @@ -126,6 +127,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct
> ceph_mds_client *mdsc, void **p,
> =C2=A0	u8 mdsmap_v;
> =C2=A0	u16 mdsmap_ev;
> =C2=A0	u32 target;
> +	size_t export_targets_len;
> =C2=A0
> =C2=A0	m =3D kzalloc_obj(*m, GFP_NOFS);
> =C2=A0	if (!m)
> @@ -224,8 +226,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct
> ceph_mds_client *mdsc, void **p,
> =C2=A0		*p +=3D namelen;
> =C2=A0		if (info_v >=3D 2) {
> =C2=A0			ceph_decode_32_safe(p, end,
> num_export_targets, bad);
> +			export_targets_len =3D
> size_mul(num_export_targets,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(u32));
> +			ceph_decode_need(p, end, export_targets_len,
> bad);
> =C2=A0			pexport_targets =3D *p;
> -			*p +=3D num_export_targets * sizeof(u32);
> +			*p +=3D export_targets_len;
> =C2=A0		} else {
> =C2=A0			num_export_targets =3D 0;
> =C2=A0		}

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
