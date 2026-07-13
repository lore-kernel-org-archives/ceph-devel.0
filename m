Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AE38CFEE
	for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981680; cv=none; b=gDlR3cUR49/FZ3rsY7sm+TtigvU4sFX46W13WewUz97hAapbKfeJmkbmUM9RZXjInzMKe3I2h25UrC/0+Gj+TgAonQLsSgZaT9qZD2YQ6iLuTrSwuprK4WCnfeuQ/fSt6vX0F6zVOm9Py4IlVkC8WindAkZqB270WDereN/iZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981680; c=relaxed/simple;
	bh=B2PMpUvblp5hyxjnA/hFM71N7/kvSkCyfKwQezd7D7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kN4vvVEwbV7J64ej2ryxLOCSNk3dWbBERx24PtGNFseVItPDpsyTdt5Vvtf1aRK0MtvZdd3fKLD8K3i/hrPq2LSu2/Gj0BTlC0eaREoe8CmMDEZnVuIs8ZRaZammXdIpGt0Zu8m2elUOEefehlpJJugPUDqOKjanSMTlwtg0uTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=PW/KNB5w; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="PW/KNB5w"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664d530fcfdso6442738d50.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783981678; x=1784586478; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+d9JIH+nqFpF2LO/9v6L6+WLXY2mSweMKR5vNXN1VU=;
        b=PW/KNB5w8NegITRt9T+zxUQ8u703i/DfAluoZ22EwzzqxolTOsT+7+kJBzx2KAfGPd
         tx390vdcDqwoEZv6I+1Rsc7zcI8fApCUNhHK+8d1HJyWcbwO7GpuP6rFLFyHDjnYSNV9
         e75RUiLp+ahyMMhOZhTDfW4m+EaJTgOEe2b5Q5SMxYVPjlfMTzBuEPK7V1+xogqPfajw
         m+TTxXYiZDTm5kv96StZCcPlJ0Jw0T5lLoFsfs/IwCZWcn2S1tyod/QTNpQGRt4drfY6
         nqgZ7U2f6xlb93XRZquyvEayAyHdjwI4UmiWVEfN/Af7qLJOkmKILKuRl93CcdONBwX/
         VNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981678; x=1784586478;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K+d9JIH+nqFpF2LO/9v6L6+WLXY2mSweMKR5vNXN1VU=;
        b=mMqB3JKTFvvP8xhNUPugUZ+NEaEifIawlYi4Lq26Z9FlHV3Ff6zQpuNqMz+s4gaGpG
         xSpTddaRtXyr77/WGAqKeWHIDcOHC2Qix+2zzquzmc35MG625MspvWwOZaM3j2XXauLV
         IwDaXRm+V6ZCreWBdrENJQZx5JB53lP8MA45myFPu9llhvXg1pmnD0GdAekV7DpAl4Vc
         E9m7N0RVIzkl78cIXUN42GGpi4z3gIO+tJn2tvqXCQh3/D5lvj+QL0oCdkMZ1EL6qdw3
         yhKVxxbaT+roXudUHGbVkAm1Qu+zLtpdocEa5/CUOUBCOP05KfpdOkOPoxVgZmbYmWRt
         cdpg==
X-Forwarded-Encrypted: i=1; AHgh+RqWragbeMptvk5TcYagCcLTa3QtvonJu/8GgwMC5JEMA7IBD5/UBAc+8LuqNbci9JgQSCSPUgjACH0f@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYjg2lzYUi94OHXpDS16nkEC2+6BLZQRYA6aWMJMNzqgFaYxM
	yXhhpcW9Pm/tDFQ5kqdGcs8jolcOTLoNsKhQlawfRrdjoFeTosMdhRPK14AXyHk/zMo=
X-Gm-Gg: AfdE7cnwvdCofFR5hITZzxgYrsX8CC1QhoD/ic4VlxucgRt9SFTZI04quuGvKh8srdr
	8L6KEsxJ8xTGjp16FlOlPrNIP31rPwciO8LYrIRpgZO49lJczejnOKhcFUujYWBb8Yi4mUmw8RT
	L27h2oxG2kRo2f4krWHlJMOKB0lRAiTDOa8TOa8MIHwESIqWLewrr1R29onHwHH291xXxuVi2h7
	zASUhtvSeyVCFeRNTjmrVmqjkKMj4Q10iW2k8gI4OfNeTVcfuSjo3lyt6L0vpkVTFCIIpAs+HFN
	v4cy9nf0UNdPIFQh2KtpKHKaiMixuHLElPP+H6cSlRiPDRH4a676PlY64Oh8DZOXEmikvh8bo06
	Ca89o1Dm4Hwt/kRO+ZyXOtgSH76xLjVmJ6L5t+XiEWQIpQwicjkzWA5w0AGX7knApeajJBRAEZZ
	BUkP3/BHcDKn3BUdoHOw9mmo+74ri3aRxUOhgFoVoAClfWxXOnHneKfdKmBxIjZogfj6NemzxLz
	r5ZkO4T5xzgIqpwdOWC9EY3YSoD74a2GIXPc28h9d8R3EzoOSd209VyyGaHS8+H0k6kBgAZkVDK
	9JBCig==
X-Received: by 2002:a53:ecd7:0:b0:667:6276:63b4 with SMTP id 956f58d0204a3-667d7c426damr5293391d50.60.1783981677773;
        Mon, 13 Jul 2026 15:27:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e472:ff2d:20b0:742d? ([2600:1700:6476:1430:e472:ff2d:20b0:742d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787a5a9b4sm14860155d50.17.2026.07.13.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:27:57 -0700 (PDT)
Message-ID: <1115c1f9c91381f2b6ceba9b62e28aa336776dbf.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: validate OSD extent maps before cursor advance
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Milind Changire <mchangir@redhat.com>, Xiubo Li <xiubli@redhat.com>, 
 Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 13 Jul 2026 15:27:55 -0700
In-Reply-To: <20260710022818.3737468-1-michael.bommarito@gmail.com>
References: <20260710022818.3737468-1-michael.bommarito@gmail.com>
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

On Thu, 2026-07-09 at 22:28 -0400, Michael Bommarito wrote:
> net/ceph/osd_client.c:osd_sparse_read() validates that the sparse-
> read
> data length matches the summed extent lengths, but it does not
> validate
> that each OSD-supplied extent is monotonic and lies inside the
> original
> request range. A malformed authenticated OSD reply can advertise a
> far-forward nonzero extent offset with a matching data length and
> make
> the client advance the message-data cursor beyond the request buffer.
> This reaches the BUG_ON(!*length) assertion in ceph_msg_data_next()
> from
> the client receive path.
>=20
> Impact: A malicious or compromised authenticated Ceph OSD peer can
> crash
> a kernel Ceph client via a malformed sparse-read reply.
>=20
> Reject sparse extent maps that overflow, move backwards, overlap, or
> extend outside the original sparse-read request before advancing the
> cursor.
>=20
> Fixes: f628d7999727 ("libceph: add sparse read support to OSD
> client")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>=20
> I reproduced this with a same-translation-unit KUnit test on
> f5459048c38a, x86_64 with panic_on_oops=3D1. Without the patch, the
> malformed extent triggers kernel BUG at net/ceph/messenger.c:1117
> after
> the benign in-range control passes. With the patch, the malformed map
> returns -EREMOTEIO and both KUnit cases pass; net/ceph/osd_client.o

Do you have KUnit test? Why do not send the patch with adding KUnit
test(s)?

> builds cleanly with W=3D1.
> =C2=A0net/ceph/osd_client.c | 30 ++++++++++++++++++++++++++++++
> =C2=A01 file changed, 30 insertions(+)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c1810..76ba3abdad9b1 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/highmem.h>
> =C2=A0#include <linux/mm.h>
> +#include <linux/overflow.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/uaccess.h>
> @@ -5799,6 +5800,31 @@ static inline void convert_extent_map(struct
> ceph_sparse_read *sr)
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +static bool sparse_extent_map_valid(struct ceph_sparse_read *sr)
> +{
> +	u64 req_end, pos;
> +	int i;
> +
> +	if (check_add_overflow(sr->sr_req_off, sr->sr_req_len,
> &req_end))
> +		return false;
> +
> +	pos =3D sr->sr_req_off;
> +	for (i =3D 0; i < sr->sr_count; i++) {
> +		struct ceph_sparse_extent *ext =3D &sr->sr_extent[i];
> +		u64 end;
> +
> +		if (ext->off < pos)
> +			return false;
> +		if (check_add_overflow(ext->off, ext->len, &end))
> +			return false;
> +		if (end > req_end)
> +			return false;
> +		pos =3D end;
> +	}
> +
> +	return true;
> +}
> +
> =C2=A0static int osd_sparse_read(struct ceph_connection *con,
> =C2=A0			=C2=A0=C2=A0 struct ceph_msg_data_cursor *cursor,
> =C2=A0			=C2=A0=C2=A0 char **pbuf)
> @@ -5856,6 +5882,10 @@ static int osd_sparse_read(struct
> ceph_connection *con,
> =C2=A0	case CEPH_SPARSE_READ_DATA_PRE:
> =C2=A0		/* Convert sr_datalen to host-endian */
> =C2=A0		sr->sr_datalen =3D le32_to_cpu((__force __le32)sr-
> >sr_datalen);
> +		if (!sparse_extent_map_valid(sr)) {
> +			pr_warn_ratelimited("invalid sparse extent
> map\n");
> +			return -EREMOTEIO;
> +		}
> =C2=A0		for (i =3D 0; i < count; i++)
> =C2=A0			len +=3D sr->sr_extent[i].len;
> =C2=A0		if (sr->sr_datalen !=3D len) {

Makes sense to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
