Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20B38239A
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223692; cv=none; b=iGMK12JMDPm1q7J4Wnhd7poK+wdjLvEfo+SFcRVEkKLF3IdfXMQnGgJwPPmgqiTfYh4g88OGJbMbOJDVUaUpsSqZH4wWl5StKp2+APUGxVc1hOXutd2TH0rHNL7vOIeQCMQrWd9l2TMWcfbj1UoEo3hvcQ1jxp4rh3yU3oKono4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223692; c=relaxed/simple;
	bh=PbvKh6Wf38cq6+Th408bowM35wUIlFwKRcxkATo7I7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlaWfqFZAB/vzy4Pf//h2kNJobQ7RF4HwoAJ18D2ZdaLLga5b5IckgKjgZh02Jv0D7yA70ppqhJ+CC2LE+fReZNd6TXzO2VArGKNf/qJlNLVHfGLOIyCiU+FCTD09CSrlKsM3ED5feoLCjGVCQ78d6tl1yk0pG2Ll14pfrYCrN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=l3fbeyKE; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="l3fbeyKE"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664e3ed58bcso791473d50.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784223690; x=1784828490; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yiEKy87CA5aNgjktQWoDYIpiJ3ToUfP9M91vtDoLKS8=;
        b=l3fbeyKEay0KHu5AyJznMxKwLWIQOZBJu0lY5IAwKFFeFBcx8CG5vC7oq1Q5CaT3mP
         39AjKG5fWZi7JvOJ4E4VPVt0w4sZVEhtsuX/YkYhwVdzvxT9SClONwhpGJ2BGDYIEeyA
         hgMsXh2NCOgiGy1f4SYk6hhawrQtPEtwhkqi/DaLuAoonqkyiRFKLdp55H/vODxO1Z1v
         E0TV+86aiDdmbdiscAlUdofT2x5cF7QyOrMavxh36DNsdjaEjF0UUy7GSQpjlDd/CVOx
         iSLBUnWRm3TsrMG4r+dwzEwb/ZoFlnm3ibaJ06ioc8Tv9tJSQYtyQSoV1dl3Bf7CnRx+
         igrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223690; x=1784828490;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yiEKy87CA5aNgjktQWoDYIpiJ3ToUfP9M91vtDoLKS8=;
        b=Wr8LTuKxEjb3cILUTeXUUKpBnURxky2xrlQ/cX/MZhUEWgAqFQBkWIcbp3dQxh2omk
         EV98RRNnURv/vZ+90PVMdtkGQ1JBdftq5+CImQI7L93csvMJbzaScDxcfjp4EEgg/gpu
         KOedkBWtBrPlVYffiuNm55WA0HuUgxNB+oT4K7AsO6JzA6fjY6H0TEHRqc3tX5h2FT2B
         82GFg/HFpwVfbTv9YOmiuszdzayeE8D99XNmxKgjTX8XxqOEWlucDPpMgqQIdRm2PICf
         Qa0NTf9oItvFj8la2do7LsYR/q+TZnHStnJGd1gxHS6eKDTfH9beI6T1V4cX/dGYr85W
         Nz4g==
X-Gm-Message-State: AOJu0Yyh73wAblWBV8+/LUHsXhfCHMroK04BZvcCqmBgMNQV7m1GkZzS
	KwH7yW+FZKoXS9nRs3+iMoLwc4wQ5rfcWMQ1TnbQeCPC5NY2DZnRCUrFr/IicUzg3FA=
X-Gm-Gg: AfdE7ckV4SDUQMHLPrUq2s6+fJeHRmiJitCHsG5VYRyd0mavGpyogkkx7DC9wTM3TP+
	PrVwToudSx24Ak00sqKZloxVCAssGG9pPynuUWLGxtQxMESpRNkQEl48oecr5iC1PWNqGWEFpeV
	K+GQM+UHMnLvb/PwnzrzPCGqWHBb/WYOjHfA30Bg43oi0J0FjCwYDPr9scZ0EH107aqNPZm+qts
	HSn0PfqOIWpMSNmyO3v+stAfJm8q2/wc/Inu2t0vWPUVKXehIWN+Pxtn/kFjUDKym3/jMsriLcy
	ge4+KJeileE3R6BvW6oHeqRv0yH4R/PK7QxcbRaydvMWVRQeICdEvNjm4l/b8FbgxZxfBe9HIpT
	u6T1Io/a3jEpivKSwumDNsg0hBYFeg3lJp8w2xr2yr7V845k2q2odttA93TbppRLL+YgWFRg5dU
	bc3l21xFvacn3Q2XllBSJVlfQBI66n4tW/NX0u1XXYmA0T0grayn4qWs/pMpwqOGN1Wq/ehvZsa
	EJn7nMzyGh7vzSNbw7jP1GRRhFKfIhNTUlfXdn2lFYijxuItEnVUKa9fxXknS2HLMtMkdM=
X-Received: by 2002:a05:690c:4881:b0:81e:6b13:445f with SMTP id 00721157ae682-81ee28562d6mr22942577b3.23.1784223689978;
        Thu, 16 Jul 2026 10:41:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:1ec9:9caa:73bc:e646? ([2600:1700:6476:1430:1ec9:9caa:73bc:e646])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bf653desm202930077b3.17.2026.07.16.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:41:29 -0700 (PDT)
Message-ID: <466ff292547ad3907d7cec28ee1b04847701816f.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] ceph: fix UAF in __kick_flushing_caps() on cf entry
 freed during unlock
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 16 Jul 2026 10:41:24 -0700
In-Reply-To: <20260714-ceph-uaf-fixes-v1-1-5c7603c181d5@clyso.com>
References: <20260714-ceph-uaf-fixes-v1-0-5c7603c181d5@clyso.com>
	 <20260714-ceph-uaf-fixes-v1-1-5c7603c181d5@clyso.com>
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

On Tue, 2026-07-14 at 16:13 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> list_for_each_entry() iterates ci->i_cap_flush_list but drops
> i_ceph_lock to send cap messages.=C2=A0 During the unlock window,
> handle_cap_flush_ack() can acquire i_ceph_lock, detach cf entries
> with tid <=3D flush_tid from the list, release i_ceph_lock, and free
> them via ceph_free_cap_flush() outside any lock.=C2=A0 When the original
> thread reacquires i_ceph_lock and the for-loop macro advances via
> cf =3D list_next_entry(cf, i_list), it dereferences cf->i_list.next
> on freed memory.
>=20
> The race timeline:
>=20
> =C2=A0 __kick_flushing_caps()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle_cap_flush_ack()
> =C2=A0 -----------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -----------------------
> =C2=A0 holds i_ceph_lock=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <---
> =C2=A0 iterates to cf (tid=3D10)
> =C2=A0 prepares FLUSH message
> =C2=A0 drops i_ceph_lock=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <---
> =C2=A0 __send_cap() =E2=94=80=E2=94=80 FLUSH(tid=3D10)
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 MDS sends FLUSH_ACK(tid=3D10)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 --->=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acquires i_ceph_lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cf->tid(10) <=3D flush_tid(10),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 detaches cf from
> i_cap_flush_list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 drops i_ceph_lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ceph_free_cap_flush(cf) <-
> frees it!
> =C2=A0 acquires i_ceph_lock=C2=A0=C2=A0=C2=A0=C2=A0 <---
> =C2=A0 for-loop advances:
> =C2=A0=C2=A0=C2=A0 cf =3D list_next_entry(cf, i_list)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- UAF on freed cf->i_list.next
>=20
> The cf was just sent by __kick_flushing_caps itself via __send_cap().
> The MDS may respond with FLUSH_ACK quickly enough that
> handle_cap_flush_ack() frees cf before __kick_flushing_caps can
> finish the iteration.
>=20
> Fix by converting to a manual while loop: save the next pointer
> under i_ceph_lock before dropping it, then use the saved pointer
> after reacquiring, so the potentially-freed cf is never accessed
> again.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/caps.c | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index f8d898ad091e..358ee4f14524 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2626,9 +2626,14 @@ static void __kick_flushing_caps(struct
> ceph_mds_client *mdsc,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	list_for_each_entry(cf, &ci->i_cap_flush_list, i_list) {
> -		if (cf->tid < first_tid)
> +	cf =3D list_first_entry(&ci->i_cap_flush_list, struct
> ceph_cap_flush, i_list);
> +	while (&cf->i_list !=3D &ci->i_cap_flush_list) {
> +		struct ceph_cap_flush *next;
> +
> +		if (cf->tid < first_tid) {
> +			cf =3D list_next_entry(cf, i_list);
> =C2=A0			continue;
> +		}
> =C2=A0
> =C2=A0		cap =3D ci->i_auth_cap;
> =C2=A0		if (!(cap && cap->session =3D=3D session)) {
> @@ -2638,6 +2643,7 @@ static void __kick_flushing_caps(struct
> ceph_mds_client *mdsc,
> =C2=A0		}
> =C2=A0
> =C2=A0		first_tid =3D cf->tid + 1;
> +		next =3D list_next_entry(cf, i_list);
> =C2=A0
> =C2=A0		if (!cf->is_capsnap) {
> =C2=A0			struct cap_msg_args arg;
> @@ -2678,6 +2684,7 @@ static void __kick_flushing_caps(struct
> ceph_mds_client *mdsc,
> =C2=A0		}
> =C2=A0
> =C2=A0		spin_lock(&ci->i_ceph_lock);
> +		cf =3D next;
> =C2=A0	}
> =C2=A0}
> =C2=A0

I don't see any issues with the patch.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
