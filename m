Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC44379EE1
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348135; cv=none; b=OnyjY+bzZ09WkUOap0Beo2CNMCah2FsupUXS62Qlpo6R5Tb2N5sIP27WVP6dPSCTzJfuTLS8pwFMKcTOSBzrAfQ2jZ9o2iXxF7ctGWdHdCZZ76IPrqUdNSGJRi7ICVnXFSJPJHkdtwhZ7I1ICDAX+Ea+HOI6TeQdRW/eQJM7rvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348135; c=relaxed/simple;
	bh=5dVa6fVw8YbsW7azWfSPEccp5aCBtaxIes2anWreLEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a9J4fB6s7BONUk7Wti0UhlAWCENBOkM+689Vp8g5esCgTN1adVnfHxoQTLjMaQ5MG8iovLabVbD+iBQ3kDDOepdAAwZQN+bjS5qsmxjRwDfNqZA8/zx95XXOtJxoHYE+zoLnKEQ5d0pPEZeWiFu7oYDbtVDUZ/HV7rbrZhiT3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiiE1acp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=riAnt031; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiiE1acp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="riAnt031"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bKkAklAVg2K6bI/RZmLYsad8XQOiYwrC6TQVFTUT34=;
	b=QiiE1acpNLqqy+U9Zm+E7rAoORln+Wgae2Yw07EXdWuLv2RK0h9Xam5yXn/F0CUCzXyth5
	GN+2r1qS0GCt3QvsnqWD62E/sfH1hABuNkJhP8fPkpQSop+UvAVNg1gfsfWIseLEp63rMV
	42zVB5IcGOFf5NvKnMjBFojQyva4w0Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-VEL32cjnNOunIfjUojWJAg-1; Mon, 06 Jul 2026 10:28:51 -0400
X-MC-Unique: VEL32cjnNOunIfjUojWJAg-1
X-Mimecast-MFC-AGG-ID: VEL32cjnNOunIfjUojWJAg_1783348130
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1273e18eebso310321466b.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348130; x=1783952930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bKkAklAVg2K6bI/RZmLYsad8XQOiYwrC6TQVFTUT34=;
        b=riAnt031GtOR0KaayQ5cO/ZU6uweITmndyingVb1WSCTtXS0el+5dXY9XLfFBylqMg
         8FhaMpLurv75vN45l0In91rv/Rm+i4z95n3kRI4qr3ckHJWVWvRJSGace6/xUW3/xOeh
         dfJ/+VkWSzcRsSHZG/UgsaoJRAe0hxMetfQfkxfzOzIo6a2IVhvNsNe71na4UDeeAmcB
         W6lKNGiE+GCxn1bG6u+NIQnGuswpSx3u7VaDOEs7t4ZD1vqJF9ATg8EGLSg/+TvDp6gh
         PYwtjfl38797JaNRnIf9ZnzvgQWtCuUhbHLqtRyxtMtJP/pMnlndJcq11vg1DGcswesa
         I38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348130; x=1783952930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bKkAklAVg2K6bI/RZmLYsad8XQOiYwrC6TQVFTUT34=;
        b=TFx9CNa4i6qhQMZDa/LIJ2zeMv3wDlV/trxH3k0o7y/lNY7iQwDSf1RmVegjir8VQq
         Ft4IsTzcMF/D0f8mj6y/qsLSCBi63iF8dXXOxnFu6KNIXS94IwbvW8XxF2lzK8t+djKJ
         TmkIz93/lZDmlZCjx5r7tnC2NFphsyx1cfQqm15s0SvsU+RYc8lSw8E3JEXD7lojjbU6
         /TBS2k+LykRk3BzMJdUOFfM5pbwvvdJOwBV/Ud7G+xRcX5dZ/Ondosa/ZvYnUMdlMYgX
         Oi9wfbI69WXpIjuHOBJf8HH2+KD74Sxeho0S5ruHmFMH9LsGMu2nyqDZmOm3c9zVtpJm
         kTJg==
X-Gm-Message-State: AOJu0Yz5JRzdXoV747kwdBPTqW5/iw2sRb7bqGzk/fbelUtiIwrqczSy
	/gL84fBCa6A1nin3TcO6Srf48VJu0tP7zRMuruA8zc/zH8mMo6W1KAQ0nj+Qyyac2yQurjaBUGt
	kbm1gX7ikJBcUAKHwH0GESAbI2fs4xxAZ+ak4NE1NuAC0Xwp5cVm8mO9Mj29wi84=
X-Gm-Gg: AfdE7cmRFe0vxxIj+e7G4/DBv3uDTAES6w7ztkeDwSz50sC0rlnXLGpeTqrHwHN1RUs
	xgTA3oFKYDzoK0nCa9bPLi1sNIDhT39Jn+JpGH6A0ptoMao3V65vLhw4NhZQjCoaLaDWgLHwq+B
	BO3VOJIhrJ1R6Y4787eg7q2twbQTvHLkRp8xAC1Ruot3KngjpxUMgFdCTdtwGJBoFEOM/8nPai3
	sQCNwcBSqVC3YxA+i8dzyFgQWchk4K0gh7hW3+x5WNHc97HgvXJqoO2rIgYAqMZ9P+nBE7FlWbK
	tMR/cbsRNsmT17ke1xYaukYOM6htz8UQnItD20/HpMX5hMk8Aq7H7gq/nEBw5nd2+5Wz7K8FfgN
	Z2/yFnf3KTg0g0q49uEtJz8uBxpSI1fgwIuvaxn1kekL9
X-Received: by 2002:a17:907:a0e:b0:bef:db4:296e with SMTP id a640c23a62f3a-c15a676be9emr52372166b.10.1783348130260;
        Mon, 06 Jul 2026 07:28:50 -0700 (PDT)
X-Received: by 2002:a17:907:a0e:b0:bef:db4:296e with SMTP id a640c23a62f3a-c15a676be9emr52369966b.10.1783348129796;
        Mon, 06 Jul 2026 07:28:49 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6091785sm788932766b.16.2026.07.06.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:28:49 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
Date: Mon,  6 Jul 2026 14:28:48 +0000
Message-Id: <20260706142848.1978040-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKPOu+_O-j3KdUmfAPeQrUPhpehAGeAQbnZd6J+OwG+duBJbcQ@mail.gmail.com>
References: <20260427155813.2561935-1-max.kellermann@ionos.com> <CAKPOu+_O-j3KdUmfAPeQrUPhpehAGeAQbnZd6J+OwG+duBJbcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

> >   1. [minor] fs/ceph/caps.c:3093: Timeout constant should be a #define
>
> Why?

Because Slava explicitly asked for this in his review. A named constant like

#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)

keeps the arbitrary recovery timeout discoverable and documents the intent at
the callsite.

> >   3. [nit] commit message: Missing Fixes: tag
>
> What should it say?

I think the relevant commit is:

Fixes: 0a454bdd501a ("ceph: reorganize __send_cap for less spinlock abuse")

That is where __prep_cap() started updating mds_wanted before the cap message
is queued.

The split-out request for the CEPH_FILE_MODE_MASK change still stands, but you
already agreed to separate that in v2.

Thanks,
Alex

