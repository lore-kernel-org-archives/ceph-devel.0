Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB637F8A7
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607170; cv=none; b=DXx4MstFpt0Hc9VmuZzVbxjPOdAIZ3v26/14I7d1rfpxeExJlAiQFJyH6r8/dvfF+f9kixkK9wEkHYhRcdlWJrcEWsJiUUN/t3UAxS8JjHON5FrABliJjs386LEaMHN+x0m5dDfz2rO+lXhUdT/dx0bW8uriAuupzkW0X8IQO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607170; c=relaxed/simple;
	bh=D/+9T/rWk46/UQc2ji2AyQfFK39SurpfzWh2acawIL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SstY0bLZ1rENjDGgFdtTVCjqjJTX+h72gJhz7jEXGhCNgHBkWMUG74dZISc7+Ph5ZqXSuoXm7p9W1Y0xL0m9mmaoWFN7c9xz2stKGGa2PcnziiogVWUiRDsRfY2Yi/O7LvwvdQevIJ6k0ECtBM48XcpTk1uPfm9nln4i0r8qCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=G+ofRN7Y; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="G+ofRN7Y"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66043ecf6b3so1455157d50.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780607168; x=1781211968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7+pkHNhCtwUHMRC2k2XmiuP3XGydlTUbqGjyr+dXCwg=;
        b=G+ofRN7YSlAHQTo8O/AwsqbG4KWPNt21xeEwW8LW5cop03lPSvt7VYn0udc8Pr625y
         cQvNCNBNxRwepE5Y0IGthPxlr11WLosJOmKmBYoBXJesgvqw5Gkn6TvwhN6y3AT5k/rY
         /QtHCMU9dKxOo//NJtAIhbH5vJe+GCbcOFhQtMESwSvHewmWVGOWIjMmQO/48sctWyqC
         8Y4ha6dhNGzoUMADjbO5jKs7icWtE1ECKfcb1gat2KnlWvPj3MONDcb3rdacg85zxe8D
         kSu/tA+eeWezIwDiZrZmVxN1SeDbHDpXgr/UTKeScQdhG7yNK9lusNzgNaX8riHMa6Oq
         K2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780607168; x=1781211968;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+pkHNhCtwUHMRC2k2XmiuP3XGydlTUbqGjyr+dXCwg=;
        b=bTlPG+ZEIRGAQYWpVlkTFLoKxCEDTyDc66o6JNZOnyLzMAR4w+ymWSuGVCxGloRjiS
         CFhZa6n4U85/llBw2Gg+nvE7R/khns8j20Nd+Y0gWhk4ui0RIdRwhe28+23wJqVa+Oj9
         KgSRRmRI5zPWuOufFak2B5uNUFM36w/OPm0vpdoDkA7IJNfio9IKtKsRMSOwI6Z8rYOM
         Zw0AwFRbP0A/UeEFKOt3NCw1w+CpfMYnmpZaB+zB31xwWa3I5gHbhhgAwEkFCkzuv/ih
         U6ajjgWdwU/AEpfNQiU6yrlaQmsv13RD9s1LViSDyPkhc6KIv78R8ZxIOMOatatU8Hw4
         2J+Q==
X-Gm-Message-State: AOJu0Yx45P0x1fWATgv/jLxkXYdabZu0T/wkIswsUUOZksBISz3l0Q/r
	F2X8yUpvdSJ9MFLElmTkZNkT0wc8MTP0osxTRi3OtC4etdDxxz08zjT/7uoUBg6s1XQ=
X-Gm-Gg: Acq92OG6VFaS4+c3nCXKR8HYBis+NkHd0nN5rZviAInqDgbVu+oKChG4Gcex6VixKDk
	iKj8/UFh8Pp2g0jyALXxRfvbKFc/GK+KZq1QW1Jwm7oxm4yUmJQK605iGK1Hiy0j69c9YhguWVJ
	/KdJSbYwbV5jHR5O0G7RIZMYsN0BaC5JA0KXfR3w1aEFUV6CtYzbnWtGOPcyQQsok9IVeyey9Md
	a3g1sm0VTD8Ldp4qjIRxQz4HRkfnYThU6EfVKxdhbkmiRjLMAfE+Of8ZRMmJ+cZSkRT02+kS09j
	qCmCRw9ekWfO/Q+GmdWkqk9ALNy9wuRvy70uiLFCbxIWxwWGrIbCCfbZ7PQ25zL5wFgkfxLAq3D
	9sUEN9riyxWzx7ASrWtZd4ogha1J1qQI9+KCwZ6SmUr5bltG5YN16mEVJd3TxWNy4iHUz7EN2GI
	qPy/XBKiTI9cCpUacyNvPKbTby7CNEldx+txRrs3R0PUPVDvL0FpxVzBH7b/+K4+YGcPJ03g/0p
	jpY1jZkERl2bTXPZzAxBi0igfOTlqDRjoSwgWIKUhKnnVBh+hL32MWLOltseyAUUL9PqAI=
X-Received: by 2002:a05:690e:a4f:b0:654:27b0:8881 with SMTP id 956f58d0204a3-66106de9af1mr533770d50.3.1780607167915;
        Thu, 04 Jun 2026 14:06:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ae19:b6b2:5990:ed2a? ([2600:1700:6476:1430:ae19:b6b2:5990:ed2a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d6484af2sm4502243d50.20.2026.06.04.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:06:07 -0700 (PDT)
Message-ID: <c3d563d16537d0bdb03f4d4b7c677de28ab33223.camel@dubeyko.com>
Subject: Re: [PATCH 4/4] ceph: cap delegated inode count in
 ceph_parse_deleg_inos()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 14:06:06 -0700
In-Reply-To: <8f25e9ac54cb3c408d061993a5a797186aa50506.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
	 <8f25e9ac54cb3c408d061993a5a797186aa50506.1780596023.git.michael.bommarito@gmail.com>
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

On Thu, 2026-06-04 at 14:09 -0400, Michael Bommarito wrote:
> ceph_parse_deleg_inos() decodes interval sets of delegated inode
> numbers
> from an MDS create-with-delegation reply. For each set it reads a 64-
> bit
> start and a 64-bit len with ceph_decode_64_safe(), which only
> validates
> that the eight bytes are present in the message, not the value, and
> then
> loops:
>=20
> 	while (len--) {
> 		xa_insert(&s->s_delegated_inos, start++,
> 			=C2=A0 DELEGATED_INO_AVAILABLE, GFP_KERNEL);
> 		...
> 	}
>=20
> len is fully attacker controlled. A malicious or compromised MDS can
> send
> a create reply whose interval set declares len near 2^63, driving an
> effectively unbounded loop that performs a GFP_KERNEL xarray insert
> on
> each iteration. This spins a kernel thread in the reply dispatch path
> and
> exhausts memory; on a client that has negotiated
> CEPHFS_FEATURE_DELEG_INO
> (enabled by default) a single reply is enough to wedge the mount.
>=20
> A legitimate MDS delegates only a small range per set (the userspace
> MDS
> prealloc window, mds_client_prealloc_inos, defaults to 1000). Reject
> any
> set whose len exceeds CEPH_MAX_DELEG_INOS (1M, far above any
> legitimate
> value) by treating the reply as malformed and returning -EIO,
> consistent
> with the existing decode error handling. Normal delegations are well
> under
> the cap and are unaffected.
>=20
> Fixes: d4846487870897 ("ceph: decode interval_sets for delegated
> inos")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
> =C2=A0fs/ceph/mds_client.c | 14 ++++++++++++++
> =C2=A0fs/ceph/super.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++++++
> =C2=A02 files changed, 23 insertions(+)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 4f36ac73305dc..0a084c4f3aae2 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -633,6 +633,20 @@ static int ceph_parse_deleg_inos(void **p, void
> *end,
> =C2=A0				start, len);
> =C2=A0			continue;
> =C2=A0		}
> +
> +		/*
> +		 * A legitimate MDS delegates a small range per set.
> Treat a
> +		 * count larger than any plausible delegation window
> as a
> +		 * malformed reply rather than spinning while(len--)
> and
> +		 * inserting unbounded xarray entries.
> +		 */
> +		if (len > CEPH_MAX_DELEG_INOS) {
> +			pr_warn_ratelimited_client(cl,
> +				"rejecting oversized inode range
> delegation (start=3D0x%llx len=3D0x%llx)\n",
> +				start, len);
> +			return -EIO;
> +		}
> +
> =C2=A0		while (len--) {
> =C2=A0			int err =3D xa_insert(&s->s_delegated_inos,
> start++,
> =C2=A0					=C2=A0=C2=A0=C2=A0 DELEGATED_INO_AVAILABLE,
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index afc89ce91804e..43a9b075f344c 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -634,6 +634,15 @@ static inline int ceph_ino_compare(struct inode
> *inode, void *data)
> =C2=A0#define CEPH_MDS_INO_LOG_OFFSET		(2 * CEPH_MAX_MDS)
> =C2=A0#define CEPH_INO_SYSTEM_BASE		((6*CEPH_MAX_MDS) +
> (CEPH_MAX_MDS * CEPH_NUM_STRAY))
> =C2=A0
> +/*
> + * Upper bound on the number of inodes the MDS may delegate to a
> client in a
> + * single interval set. The userspace MDS hands out at most a few
> thousand
> + * (mds_client_prealloc_inos, default 1000); 1M is far above any
> legitimate
> + * value and guards ceph_parse_deleg_inos() against an unbounded
> loop driven
> + * by an attacker controlled 64-bit length.
> + */
> +#define CEPH_MAX_DELEG_INOS		(1024 * 1024)

Technically speaking, I am not completely convinced by this limit.
Also, this limit is for one single interval. But if attacker tries
multiple times, then we can still have memory pressure or run out of
memory. I think we need to consider more robust solution. Could we
improve the fix?

Thanks,
Slava.

> +
> =C2=A0static inline bool ceph_vino_is_reserved(const struct ceph_vino
> vino)
> =C2=A0{
> =C2=A0	if (vino.ino >=3D CEPH_INO_SYSTEM_BASE ||
