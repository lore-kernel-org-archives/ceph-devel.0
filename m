Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639638E8BF
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825568; cv=none; b=BxFsxx3NBx1tI4DSLseN/7b98qbaBRQIXr6CPLKu/+dHhX9EwQhsU+H7iKfI1SdZALe1On650Fd+wLJn/+kySddUHv60Snx84aRzYXwNg1E6fuOiJssbLdcFgo/lKVlxY6yEOZft99khPlbE7wkaav6JelGiqqYdNM+WozHDZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825568; c=relaxed/simple;
	bh=WF5l8f4G1c4QIJgFsWoYg70EHRiTrOToxL/pWxJZlsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UszOUMUkIHzX/PJuXdv1va7bM8WbqcvgrAIUTf/PWT+WPpxyQOfzQIcgsAZPSxYEURA4Xy+W9g8abf1mXL7Bv+dO5ksPMraUl12NxHzDUNuS5mZIINcWfq7Hs9qBRolno6nTU2DJ1iRJMKiJVNxSvHgZ/rDc9lXJLoRJtyhl10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=rr+o55jf; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="rr+o55jf"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6688acd1a51so1011536d50.3
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784825563; x=1785430363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vLc4/ReatWJrter8ft9/eBEsB1actahNwIuG7Q7Rbas=;
        b=rr+o55jfPOmYHjTYR02YtNyzQDtHmYJqyqR8t1sFfHlfyt6n8dxmMEJtdruRkRwf/G
         KPUhBnXX9LUduJLhvl3MxuepTnL9a1ydWuZmpMu4HK4ya/brXinvjqh55Dg57Sp5h7Sd
         QENSX2QpMbRsg61u0fptds6tMi6swAOlqnsVBYQFKiaPyH2BCOcftL6qwmhd8kTwhcsX
         dECkU1VLo+MYCUyUE/pBIW+BMqouU71QMeHFHmFFMrZj5pvlYh1h2xeKVrxa6pS7XUZu
         PDrIyMDd3JgZTK30e98xPrzJAciIWB+sQ/s5TiftgCLJqPN2WNpRfgt00+tiVrpp51WZ
         vlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825563; x=1785430363;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vLc4/ReatWJrter8ft9/eBEsB1actahNwIuG7Q7Rbas=;
        b=bqemtrHiBsKRsGpXZZoj18c9/1B0R4hKmtB2EHVksPqM5DYO/E744hu7LTS3IQa/RG
         OiwMUmplmH4RhDf58ZL63DZbC4G01jSQiFe63sHpO0dOUlR9J7zmMki+x05aB0rPAqnl
         7q6M8c7s1Xo7lWGoVS6cXLcLVMnotiat9B3p/4lBaI8+T6ZeXu2Rft/Yj42rZ6zihiXB
         jzDZ3DhpTg6BCJHJl+DFKG4R66aYwFWuPeSaF2M9GwcK2segSAr3IpAw0DlnPj8K3RQp
         zoBOTeIFfYXLlpOQcv8ghFjbkYe9mcMTYhqXiYGrKKCTyPcj5kH8JwlZdBsj33pBTOeJ
         1odQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfQIG1hOAX+H8icgzHTnz209QTbOrcEAY4QxhpMCGlEzxcwSmZRFXR95QqqnltY1GCMn5exEXfvYVx@vger.kernel.org
X-Gm-Message-State: AOJu0Yytm0qp31AyGFr8rIHlgOFGYxqmLaWqN49dMf9EQ1IiCzzj61fj
	GZ69C/3eGWNSjVUdexXNtL0LJLIBmAN9+5Re1VM8PwDkr4MsnHTtJTUgdT/qArSqZP0=
X-Gm-Gg: AR+sD10S/u/oPGdVZh308OnUNW94l5Tunr5VvDJndhj/ksmpvD8R1nokGkmW5l6YCOO
	zepIgzHviLz7dPcDychFxwifms1UUyfxOGJOFDT6OXIbitqz4OQ93BNnMrAwKt0SMb1OtWmNRaY
	hfcARxYHQIgRn0GfRMCvPDjvFMpphaoGlhypmjsjzYKIZDhcMENdV7N67opUczkvQa8D/dIEEF6
	+nEeBo33f1j9IvYLZN0mktKbiVphQazP5sD23jtl+Wad29mE2HqmoHGqz9tLQPnVsxWF+6mnOy+
	8NxaFjHG56Q/S/yABMZ2lKFIkVw4r2RP7ajhi08Vdemwdjp6+fEnlKqHxjXuIM6r5miKzWnixbA
	CuDFk2YWqQNoRtxQv8aPeAjb0K4TijCoemMQmH9xfMIJeCcsPruC0J2GTBUcu9ki0Bqy4KnP3Ws
	PBjTD7rFtSNtQy9GAdM+C2m6Wgc5d35ScIm8LftSCh+x4TekNErZ6ilINhzT/4DN9u6FDQmxfxg
	PvwoDTQIMzBg/1invmsrNYpbpTyHvkh71vZSmJKVPZj1QVRPyLWHjld+FiMOOoP9I6gDVild9j6
	ds0Myw==
X-Received: by 2002:a05:690e:440b:b0:668:9d0f:ab70 with SMTP id 956f58d0204a3-668a4c58eb4mr679579d50.18.1784825562805;
        Thu, 23 Jul 2026 09:52:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:12d8:c69b:ed00:1fe4? ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f3df5275esm25680817b3.9.2026.07.23.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:52:42 -0700 (PDT)
Message-ID: <f8be59729e99bfc9182d74eb0fe6f1782dbc1dc8.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: do not cache negative dentries for snapped
 directories
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: Dhairya Parmar <dparmar@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andras Pataki <apataki@flatironinstitute.org>
Date: Thu, 23 Jul 2026 09:52:40 -0700
In-Reply-To: <20260723-b4-snap-negative-dentry-v1-1-c78178117929@clyso.com>
References: <20260723-b4-snap-negative-dentry-v1-1-c78178117929@clyso.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 14:28 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> When a LOOKUP/LOOKUPSNAP in a snapped directory returns ENOENT
> without a trace, ceph_finish_lookup() creates a negative dentry
> via d_add(dentry, NULL).=C2=A0 For live directories this is fine =E2=80=
=94 the
> dentry naturally expires.=C2=A0 But for snapped directories,
> ceph_d_revalidate() unconditionally trusts all cached dentries
> (valid =3D 1), so a negative dentry created by a transient error
> persists forever, hiding entries that genuinely exist in the
> snapshot.
>=20
> Only cache negative dentries for live (non-snapshotted) parent
> directories.=C2=A0 For snapped parents, skip the negative dentry so
> that VFS retries the lookup on the next access.=C2=A0 Since the
> conditions that trigger a negative dentry (MDS transient error,
> local ENOENT shortcut, or MDS null dentry lease) are all rare in
> snapped directories, the performance impact of this change is
> negligible.
>=20
> Reported-by: Andras Pataki <apataki@flatironinstitute.org>
> Closes: https://tracker.ceph.com/issues/78529
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/dir.c=C2=A0=C2=A0 | 10 ++++++++--
> =C2=A0fs/ceph/inode.c |=C2=A0 3 ++-
> =C2=A02 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index b4b541a1180c..d5d8f935fb62 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -774,8 +774,13 @@ struct dentry *ceph_finish_lookup(struct
> ceph_mds_request *req,
> =C2=A0				d_drop(dentry);
> =C2=A0				err =3D -ENOENT;
> =C2=A0			} else {
> -				if (d_unhashed(dentry))
> -					d_add(dentry, NULL);
> +				if (d_unhashed(dentry)) {
> +					struct inode *parent =3D
> +						d_inode(dentry-
> >d_parent);
> +					if (!parent ||
> +					=C2=A0=C2=A0=C2=A0 ceph_snap(parent) =3D=3D
> CEPH_NOSNAP)
> +						d_add(dentry, NULL);
> +				}
> =C2=A0			}
> =C2=A0		}
> =C2=A0	}
> @@ -840,6 +845,7 @@ static struct dentry *ceph_lookup(struct inode
> *dir, struct dentry *dentry,
> =C2=A0			=C2=A0=C2=A0=C2=A0 dentry->d_name.len) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 !is_root_ceph_dentry(dir, dentry) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 ceph_test_mount_opt(fsc, DCACHE) &&
> +		=C2=A0=C2=A0=C2=A0 ceph_snap(dir) =3D=3D CEPH_NOSNAP &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 __ceph_dir_is_complete(ci) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 __ceph_caps_issued_mask_metric(ci,
> CEPH_CAP_FILE_SHARED, 1)) {
> =C2=A0			__ceph_touch_fmode(ci, mdsc,
> CEPH_FILE_MODE_RD);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 61d7c0b8161f..d52e2b389e0b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1814,7 +1814,8 @@ int ceph_fill_trace(struct super_block *sb,
> struct ceph_mds_request *req)
> =C2=A0				ceph_dir_clear_ordered(dir);
> =C2=A0				d_delete(dn);
> =C2=A0			} else if (have_lease) {
> -				if (d_unhashed(dn))
> +				if (d_unhashed(dn) &&
> +				=C2=A0=C2=A0=C2=A0 ceph_snap(dir) =3D=3D CEPH_NOSNAP)
> =C2=A0					d_add(dn, NULL);
> =C2=A0			}
> =C2=A0
>=20
> ---
> base-commit: 602bb4525c8146865b7f6e44c81d54bf97861aed
> change-id: 20260722-b4-snap-negative-dentry-bbf74719a151
>=20
> Best regards,
> --=C2=A0=20
> Xiubo Li <xiubo.li@clyso.com>
>=20
>=20

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
