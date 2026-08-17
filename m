Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22173F8EDE
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964927; cv=none; b=ndqeVbeI7O384ZSTfaGlLwoNo4q3aW5w04aPz/HfSJVVAJdV8kwYGWPQYujuP4rskDTorIG3LwrlkteyeJSbyjWuk9YGMEFtfeW9ANg2xcNvlSickdMtJJqPVGX0KFBL2BsLH3ZMj25YMd1vpAyGGsUck19/9x4d67SM+r6MIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964927; c=relaxed/simple;
	bh=6px4QI8Kp+Jeo62TDshiNYAkMTrTvxN0LPNYRwfemXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzglV/NQgFOn5Gt4MJ8b9EhMe1IgmvzTIZAlWRxEnx/is5fwuK/ns3w+DLbMykWWYOeNuQaGJvz5eC40yeOEWLDYj0qx2rC17QBNnHd0rlo6zGJhzVSft3oP0nLzebW6j7piRHF1x8eixZZRgvugBlormqhu6Q8WvyutULTWctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaWRX7eO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lVR3nltH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaWRX7eO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lVR3nltH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786964924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6px4QI8Kp+Jeo62TDshiNYAkMTrTvxN0LPNYRwfemXQ=;
	b=PaWRX7eOk83gX2vKYpWEU7UoEm3jW5QGmMaNwW7dRkMOWPkv0+a5tAhU+EOq+nNE1fVxJ9
	nKcjz/xGCCZe9b92qVTLtOJUQvKRjMUtk6d/kkFe5eO7RbGiH3U17xT4fWbPnkBJRdnuFl
	fQ40APyd//V0wumtXlX1LcePtdVJOYE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-rjQ7ymODPSazvouc3zHqGA-1; Mon, 17 Aug 2026 07:08:43 -0400
X-MC-Unique: rjQ7ymODPSazvouc3zHqGA-1
X-Mimecast-MFC-AGG-ID: rjQ7ymODPSazvouc3zHqGA_1786964922
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a37252d1c8so3282673a12.2
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786964922; x=1787569722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6px4QI8Kp+Jeo62TDshiNYAkMTrTvxN0LPNYRwfemXQ=;
        b=lVR3nltHwXvU+vAj1vwMAt4bK5YrTPrDd/xI7iqSTbRxIHOjGfLKlF5DQ0sWWB2K0w
         FuTl0cJXScAqNIuADBdhOIYuAe34/GIoM9TJd8QgIpbb/yBUlzyHRGXM/Bid3s0BiRgk
         kkZFlvbnB06dA0ijYXONOzqdIWvrwOlMP1z9iIPRtvtl9Q3OdS8Hqrq5QqfjOX9IrV5M
         1t0rhZ/3REP6C4/ypZEf8nj6x2Wd8sP3btUV+ui8AIbQ0HMpLGOWwYebnqYQSdtTDlyb
         z8w83RklG4T7/ky1TseVqIt/Y2uqwE1cIBrAzmNV52Cd9PloUdQlFqRpBKYFC8XLYxHm
         qgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964922; x=1787569722;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6px4QI8Kp+Jeo62TDshiNYAkMTrTvxN0LPNYRwfemXQ=;
        b=ZDQ/sSiw4B48JcfTGLRG928iAhytPaa8mSx1aQBfc0EGaw/hPVVDLca+VVOx+w8u5s
         BfvP6BrEQfcwRBtsyebqhyn8xnSDXYWv/7t9I+HIKniKLfGhqUkIM7MKWWwYJaHWGXPX
         huw1ykkbQNWxDSxhLPfrHLGQJ0tngTswsXYg5cHZFt8mgQ18/plbM/w6hZBm+Ho+r6Ab
         vWM1L8oPlzMGII4lshnWOyg39GvKSwHbcf1oD9reFTqntjX08RKCUzyZsrF/VFqXqWCF
         NIiIhs2CkAjHvvIxqeL2ECZp+laUlPNeT9qd+OBnwJBhDY7pGX0E0bucQvLut0Xt+UKL
         /oWA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7QvakDEQoHqcxMYsTTRrvsFJnJ7uTH8C1cVSsMznTMWphfcCdsH+icHllluGnKHl+VqgvpfeDMgCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPKMLCw+hS915SqlfphZSjX+k6NYMpQrQ3K9hLgXYA7mBqU8I
	3wX7JwbfR+WBEQSihIFHo4MnhREDVEa2tH0IPiu4ZLyPuscS8wx9vxffeznntC6L+7UrVOM32rS
	84xSfhCZc1zkY9H0u/dLiWaNiaG0kmN5d8HMDV3dD4LbGv7wJOgIG2tjCzhsVH4E=
X-Gm-Gg: AR+sD10rCwcGH17zUfP+o9NR9Bfq1w5gc2dK6Q1lZVno1bjWIQyOKzpDDGvfisS8ggN
	gnMvBAczRWFCqymttVuQGlQu7ympWHwctW7byjyNKaHsoGnEgNWrtYCjlJUQkYxAuuIkRf9hWGc
	EX8yoQ3kiPQsYmhqlp+J0m7sL3FBwwK0ZDT53Qdl1cV85lVPMc3YxktJdTJSWCmSYGihtnA5vtO
	T2a5S2ykFPb0w1NEF+0AmZujEnAHZ3CQGHRLcEFu/BWI2RvKuHVsFZEHtcpscUl/uAeS1HX1sXN
	euuKM5VbupwXx+lEXG/LlAEgxJeKoyLQPh4Z2lPPa8kVGSlbuRRu2n+T2KJXjx3AfKgwc8KgLHy
	V2gW6Z7TdjSUE3CWWza8Hr41fZMsxN31TjQ==
X-Received: by 2002:a05:6402:4516:b0:6a0:9cb5:4f33 with SMTP id 4fb4d7f45d1cf-6a38a96b746mr11282359a12.13.1786964922306;
        Mon, 17 Aug 2026 04:08:42 -0700 (PDT)
X-Received: by 2002:a05:6402:4516:b0:6a0:9cb5:4f33 with SMTP id 4fb4d7f45d1cf-6a38a96b746mr11282335a12.13.1786964921916;
        Mon, 17 Aug 2026 04:08:41 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d851767dsm509936a12.5.2026.08.17.04.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:08:40 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: idryomod@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] fs/ceph: optimize struct layouts
Date: Mon, 17 Aug 2026 11:08:39 +0000
Message-Id: <20260817110839.742089-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <<20260812202950.1800340-2-max.kellermann@ionos.com>>
References: <<20260812202950.1800340-2-max.kellermann@ionos.com>>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

Most of the series is clean — the field removals, bool conversions and
padding reordering are all welcome. Three blockers:

Patch 10 replaces the CEPH_SNAPDIR check in ceph_d_prune() with
ceph_in_snap(), which also matches ordinary snapshot subdirectories.
Those lose their __ceph_dir_clear_complete() call on prune, so the
dcache completeness claim is wrong for them after VFS reclaim. Keep the
exact ceph_snap(...) == CEPH_SNAPDIR check there.

Patch 12 declares vino but only uses it inside #if BITS_PER_LONG >= 64.
The 32-bit path never references it, so -Wunused-variable breaks the
build with CONFIG_WERROR=y.

struct ceph_file_layout is shared with RBD which works with 64-bit OSD
pool IDs. Narrowing pool_id to u32 silently truncates any pool above
U32_MAX in the RBD path. The MDS wire format being __le32 is fine; the
in-memory field needs to stay 64-bit.

Could you respin?

--
Alex Markuze

