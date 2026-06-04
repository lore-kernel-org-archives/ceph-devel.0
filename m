Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4345D2BE7CD
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603481; cv=none; b=a2tizZXt4ai4ibpXPdQcASRicvd7j6Vt0lKuT1aP2FjJHIjFNWXUorf16wHX140CCMYQoWiafiXHrkpYAOX8/uJxfJZVcJddByR7o3cgT9//kv3XnUhkhKdv4Ll1ZrFzR3miNYKN02WAkOsjnm/ZNFfmgC0pgQ+5tmPM8YLly4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603481; c=relaxed/simple;
	bh=onRNBoVp7T3mcj+RC1k5d/BQzKGH/ntl7fWRtDJPg8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XeGsbhdZoBzk+6k4eKEXamcJ/pOnFGm5QKZkXKVhw13TcORLP3vk5GHrkbhD5EucD/Od24dVzKz1RS3KI/5JpURByRo9CMM4RWqsVBpMKDxnzukFlvJVLjd+Xerpy4EkiTPa6WGywD6iKlC+wtdmaanxr55Gk8tHKMjKG1ecTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=hCVh2+OO; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="hCVh2+OO"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-660e9fef1d4so1431434d50.1
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780603479; x=1781208279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5bdCWx1PU8J5y9cmNrSBKfAjsivF5anLoixUZhAEaYU=;
        b=hCVh2+OOEr90hAabR3rYpCISb8J6PiNtzpusK811UmzFO/VDmx1k1V4EbpBXcGHC/9
         C7FRQiVXns5DJDCMwLZL51U95DCcLwXXhiQBV9dh1dPK1w3+vy8DsFBkggfSetc6E3QE
         TT4ds9HpgAoi5czF9wNP6asSNpNVfA7sJ2zsaQI0JtibN20+84WyjPr5syBBw8Xs7m52
         OX/CIRKDKiEvyJAfvq59FBUmnCyA5l1T17W1lClSJ8hCrNXGiuIIM/Rt0KTlmDAFTKdn
         +zzr2yDuLsYlsUjiltQP1DiLL+Rk7y6gYeGpEifIJiEcy42/KTxYyXd/TPWc6WxCjNLM
         m7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780603479; x=1781208279;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bdCWx1PU8J5y9cmNrSBKfAjsivF5anLoixUZhAEaYU=;
        b=rWNR024S7L6lA7+uM6qZ6c2RnLqKfImFWSl0N2+vI7DRxoe3hk8FuQbeWr9F/Pp+Nl
         YCgVCkJ427MTUoc8MGNYrgYMKjm9uE9Srl23paenAwdpjmI7DAp92GOd57F1MQ9mHC4E
         CK5iR+D7fqaxdOXfCoxKiBnDZhd0t6NfkI/PbxIAICbAyJLU+zdxpoHhzOciNQ4HXlkw
         ayYBMgiweaUOYxf/hBnu0P3E8kINLPNcDeIgmvocq3SKQm3/doMAuoB6X2iewwZQNd7D
         2ShKrQCq2Z7d5KUtc9Gsi6+Y2BIzhDyTmBhxEXh0HjVW3i5ph+ZI29+tYgXLRo1RAVCH
         PvBg==
X-Gm-Message-State: AOJu0YzOUtBeAnWvSW5oAjR+Ti+8JvO+tMzOPglX31QIumRJGjhHxjlQ
	1B/2mSe1WIAfwdlrO8WzDi3OIphpXX6SM388qpz8Hhc0YFX6JBr+Adu0Hoezx0vnxVOze+Zgwkc
	49t7U2jma7A==
X-Gm-Gg: Acq92OFbudujcntbHUySRbjT8YKxsd3j69SntuzyhwcpKZtQsWOReMMfxyEcDSYIggO
	TL3L+NyeDfpEEXCIS5RBo0QKKT/w9C/iy314peMdCxLSdC+nKDyQPR0suzxsCXh4tLPJdYfWcmj
	+RLwfZO7rOijyhz8mNkyvmgZu+WawwtSl9sKvkOcQVAFhehCZvQqL4QFrLp+gOnmYbsig+Qsiiy
	Ty40sQPHxk1+Y4F3Wde5pkBh3AOYtP83PJd+pK4Hy1nJ1SWnt01YPUDfAhCX36/nxG5hUQtQRgL
	NgyLqf5MTtftzVZAVhhsZMh+WJbE8XHXZfhTo5hnTCwE+pBwSHEpfWpjsLf9NL5bTVBzuO3mrs2
	suRPACfFIOaVQ82TymMEaUd3Fn84Je4DSS859ebv4yTOjbmXJJ7pCnHLAltony3VtzOT3TExUqt
	MU46mV1Xy4OF5W+1mOL7nXoXAvr/V2Yqls4yrCRtzL+iDibJ43+yGl37iAkGTfOWlvN6/vaf0xI
	NMY6oPlc0Dj5AtoUa6NpxYhG3dQyjxFeQL3it+muqAriw8MHOP1LWyZGGAg+MvBtl66tco=
X-Received: by 2002:a05:690e:b85:b0:661:80f:5991 with SMTP id 956f58d0204a3-661080f6c52mr24016d50.7.1780603479285;
        Thu, 04 Jun 2026 13:04:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ae19:b6b2:5990:ed2a? ([2600:1700:6476:1430:ae19:b6b2:5990:ed2a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d644a68fsm4443835d50.14.2026.06.04.13.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:04:38 -0700 (PDT)
Message-ID: <7b8422920ac092593e811b6cc2a11350622521b7.camel@dubeyko.com>
Subject: Re: [PATCH 3/4] ceph: bound num_export_targets array for mds info
 v2/v3
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 13:04:37 -0700
In-Reply-To: <4ac3b57dcf0fba1dc5cc08bfb9a453be55cc465d.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
	 <4ac3b57dcf0fba1dc5cc08bfb9a453be55cc465d.1780596023.git.michael.bommarito@gmail.com>
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

On Thu, 2026-06-04 at 14:08 -0400, Michael Bommarito wrote:
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
> Add a ceph_decode_need() for num_export_targets * sizeof(u32) before
> advancing the cursor, so the bound is enforced for every info_v >=3D 2,
> not only info_v >=3D 4. This mirrors the count-then-need idiom already
> used for m_data_pg_pools later in the same function.
>=20
> Fixes: d463a43d69f4 ("ceph: CEPH_FEATURE_MDSENC support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> =C2=A0fs/ceph/mdsmap.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index d8e46eb7e5eb5..7cb65f9f4783c 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -224,6 +224,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct
> ceph_mds_client *mdsc, void **p,
> =C2=A0		*p +=3D namelen;
> =C2=A0		if (info_v >=3D 2) {
> =C2=A0			ceph_decode_32_safe(p, end,
> num_export_targets, bad);
> +			ceph_decode_need(p, end,
> +					 num_export_targets *
> sizeof(u32), bad);

We extract the num_export_targets from the message. What if the
num_export_targets is huge enough? I assume we could potentially have
overflow during the multiplication. What do you think?

Thanks,
Slava.

> =C2=A0			pexport_targets =3D *p;
> =C2=A0			*p +=3D num_export_targets * sizeof(u32);
> =C2=A0		} else {
