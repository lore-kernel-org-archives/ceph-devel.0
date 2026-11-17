Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794880484;
	b=eoraV84gn3QLBXLGnGEcBQkFxuHHRPLMyTMyy9ZOC1CEe5pRPTNHuqEX6dhnIBqueKKI
	 hpuG3mp9etb0V4x/5TI2zgqwTm7/B1A/sxP5f8mhr5dqzBW9gz3gi+l/RuS0rdgxotVRK
	 RiDDyHXUHFuh3nZf8lbb1iQOmMBQQQle5EqW+v7wvIMxePElA7bwjwd6vul9XcvLA5zAj
	 qTr/OR2SLKDSrtAL86Bu8RhgtmEUH4h6vCOq3l9ffD6z/LN4qsZWIZk4Ly5Nkk4o0Eo/4
	 Bo83Q2otfLFZa0l4X6JSI4DiwVEsGlhABfQfmYcs75dPV8YIfPYQCd2+fb21Ew5ydAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=RPwtZdnR9mXtKpuf0jTTik7wpZox9nAQyIfrUWj5D6Q=;
	b=C1g8uijfn9Lj1NElkRhjldRwkqfbgQLELHWTAUsIWMPVbhyP2Qmno4uY6iRXbOLyWp81
	 PhY7KTPAq0eIjvBCOWck0KO49NdAhiqSBneckH7piBXkJUB+SnjVmKsOvALRcJ1CmGGMy
	 yG8tsAYF4PtUDeOhjZMMYblWn1D0T0abtYMyFq3BQ5PLlv4hp6reV+e4N3QHcqA5Vnbr3
	 zvEfZG/C1mdKoLNEUyvA0DMl9uIJAJtw7bpa35gmJHLtK1OpuEDdtZhb0V5vh4FN/6Iie
	 TKxNnuhIZnk+HYLviLxT/PE47y4XR2GW0pHIx/DjDm/HqMnLABEEZzsIcV4E9IP7TjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=MEKdB9hU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE690606A323
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2026 01:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE690606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=MEKdB9hU
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50cc7540b7so301499466b.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2026 17:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794880482; cv=none;
        d=google.com; s=arc-20260327;
        b=QkIQ72E1mHM++P2RsBCgW6HlKqMIiQOPIY0+RZIQfOcLC452bmA7jp09bFb+V4EXFe
         8XMT68aOWPIwQ/dH/w3i3nK+HJ9/Ujt3UkV9QP97oRYKyS1K0cb0iU7Lb1dOb4YKa06w
         myZAwVwcqw+jbNHXUk2zbPPUY++oS5jycK051uaA0FtL4gOT8Hg35vLJc4nKUOTpzFMD
         ll23yUQC6IICcJrjarIlDfxGJhdKb+ErEM/XIeCJjyTujFnFsIjif0CxLb4bjUNnaV0W
         g4djvTnyf2Ydh2AheG9UPo302/b+wh2LS1KWtKDVPuCYCrUxpBYVCdhuDz6GPFGU3aPJ
         dr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RPwtZdnR9mXtKpuf0jTTik7wpZox9nAQyIfrUWj5D6Q=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=auWgvsaXMX+A5x4suX62qOzifTxmxWqZ1hkIHPkCu2tdz7jvrLgZDJ2V5Q4MQXET9b
         xQ74MTjN87WFML16C6PaD8GFhRxotz6NyZF1Of1jJUCSu79F3UBJBDXXHji140lB4jza
         oV3mO+SjnFMLp4C8yj/b3F4sX5J1jWY3c624tmGjweRN1AiNAQ3FN4gBGoaMf0F5yaEl
         gc+wr7BXrDVLMY2O+GOPJ0VakAiVUE7ArvrdscgV05BTUWDg3QUajHG+nM1tFNHiT62b
         dYkk9kq01g5JiZEDiacBLtV3v/xxkSnFkHxJZlPGn5+ggDkbapjZuCl+VmOZc/QTXoTb
         q6pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1794880482; x=1795485282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPwtZdnR9mXtKpuf0jTTik7wpZox9nAQyIfrUWj5D6Q=;
        b=MEKdB9hUtuFZJeerwmByCl+ZZdxDFmf0boRHRFZKXbNv+/1hrhcK2JF+kJ/hzhrg/f
         QqDJ9lLhtAM4VGyL2cpI6zOL3O0ElEhmOre2i9U+9jyADVIC6l7E0HrN1vdlrEj0uE8s
         Fdyn8mPSczNqEavUsS8xH6LUMK0zWnUO6fUKi+kw1YSVVAXzsiawOid9psaDxE6niT2u
         U1MfealI7fbotON729reRVsjyH6l1WOo+uxaEe1wqqoUoRSF8MtaUc4Z+lGMj2HOovAZ
         jP8JIgR9u1BbybEe7W/7H6Qg8g1ClGwFb/ESqbtKakb2BTLc2nyb6rZ9TFyAUOIH7BF7
         39tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794880482; x=1795485282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RPwtZdnR9mXtKpuf0jTTik7wpZox9nAQyIfrUWj5D6Q=;
        b=wERMCXg6e6j1xJ2QmknI8exCQMrW7wvdt1i2qWSLeUysyGzRHVHMiFNAltjknqPxoI
         uGtP9U7yAINW60LIvaA8fCcnzwFIXWlk7xFjtF4HSPVKmsOYtEypAkHA+7/u89M1AewL
         CtYHC4NpB+30kysXIY+OGz26VJYRMadc9U5d82LWSK1J+t1PFQZTtmfe6ApSjzQGWE7B
         U5/8zs2MUVgVwyC0rEnlYkrDkBHN6R8aSNMWRTw/puyeyCt2W5fkkggH/0nvvNOkh0Zb
         zHDKASwe/0THArnUWZ7ukjFCUQgbbh1qOtlJ8GpgfGrvNKJrCfJha1R/JWWc+ELOLxeN
         LhFg==
X-Gm-Message-State: APuU4Z+jJRGPcOSSBzBPPsJXaiaNXCe/uoEjOvmi7g3eDRNeoDlhUgY8
	NCf5HYb5X9FJXt/JMOATznfoIWuADNSVBTgkRGsUDF04PC/JdzfyldWWCkmyL+IiudC+YRZW7Wq
	vkGP10cUDlWcn+0rHlZzIsuIAle1Q9gKkZmBq3mozPw==
X-Gm-Gg: AYBFou0mTMWll188Ht8+I665zeyLkQfxstaN0axG21gVORxs4iibZS35zT1rSTIyy7Z
	MjP3raVFmirirfEhN1yJCwQ0+m96NJ1BErjUFztH/ETMwGxsR4LA20z5kWaY/fPR4hLk/0bt8ef
	MDE4ZrjpYjqsT2M8M+OttnGc0s0mfKDbkmi0kW0kFlkYn04Vc/G/wykTbL8u0CnWri7RwnzBrXi
	ciYHzqifm64QtCL6IVZFyQeroPFxcN5vFIn22DVOl9kt3PjHmw3PNHuRIs7LBt/B2SXBbnE+5XC
	me44/Us1OH3TeP53u3dntvsfHGRgAjB/JdZnbGfs5NjdlOjePe1zk0XrMySs74djH4e134w3cKd
	ep1VEoG5M8zh+NoCCz3dSooe6HnhVPB6crDLYo+o=
X-Received: by 2002:a17:906:12d7:b0:c50:ac4e:3770 with SMTP id
 a640c23a62f3a-c50ac4e5041mr705993766b.34.1794880481795; Mon, 16 Nov 2026
 17:54:41 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260829-ceph-mdsc-mutex-optimization-v6-0-466936ccbd9d@clyso.com>
 <20261112143635.3608632-1-amarkuze@redhat.com>
In-Reply-To: <20261112143635.3608632-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 17 Nov 2026 02:54:29 +0100
X-Gm-Features: AclHuK-Q_gWZzqm6rGlqBcSzFgOcqv-SRDnIebrIGC0npMeKtowT6aOZsg1fwQs
Message-ID: <CAOJNxRKwwbS7ovqtO-Hk24QV-Mz7ChUU5c-zxqqs8d0pdxQ3=Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] ceph: reduce mdsc->mutex contention in the cephfs kclient
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex

Thanks for the feedback, both bugs are real. I have reproduced them
and will send the V7 later.

BRs

- Xiubo

On Thu, 12 Nov 2026 at 15:36, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> The two problems from v4 are fixed. replay_unsafe_requests() leaves the
> request on s_unsafe, and ceph_mdsc_create_request() initializes
> r_aux_item.
>
> Patch 5 still loses a request across MDS reconnect. __do_request() holds
> CEPH_MDS_R_DISPATCHING across the unlocked section, including
> create_request_message() and the async-create wait_on_bit().
> send_mds_reconnect() holds s_mutex and calls replay_unsafe_requests()
> during that window. __do_request() does not take s_mutex, so the two
> overlap. Both loops in replay_unsafe_requests() continue when
> test_and_set_bit(CEPH_MDS_R_DISPATCHING) fails, and neither sets
> CEPH_MDS_R_RESEND. That request is omitted from the replay.
> CEPH_SESSION_OPEN only wakes s_waiting, and a request that already has
> r_attempts > 0 is not on that list, so nothing sends it again. The
> caller waits for a reply that does not arrive.
>
> replay_unsafe_requests() has to wait until that dispatch drops
> CEPH_MDS_R_DISPATCHING and then send the replay itself, before
> send_mds_reconnect() finishes the reconnect message. A later
> __do_request() sees CEPH_MDS_SESSION_RECONNECTING and only parks the
> request on s_waiting.
>
> In the same window, cleanup_session_requests() and handle_forward()
> store r_attempts, and handle_forward() stores r_num_fwd, while
> __prepare_send_request() reads them into num_retry and num_fwd. The
> legacy num_retry field is a u8 and ext_num_retry is a __le32, so a
> concurrent store of 0 becomes 255 and 0xffffffff on the message already
> being built.
>
> Thanks,
> Alex
>
