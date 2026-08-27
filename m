Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA64457BD
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830874; cv=none; b=UDuLUBqFyWvjSZL1voKDZIjWb2x//peAHQsqkzw2tFDYQuAKhkEgcWU6X6CzxEhniXzXtaJ9bQDrsCq9I1GnhxON6ek+5Vwb7YuXoBUvgvYhDTa0oW/NaXaQRxjFzPdf1ouT1wWZSa5frn1O56Qo7QEbjdUB8x4PTCe4HUsDV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830874; c=relaxed/simple;
	bh=b13KtGev4+wig579K7ZcJDxQB+1zZou2dNn12sCyji0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKS9j4jt2+EaYTNyqmnTBM19qEh6AZHwiSfheO+x8z+98F9cXSHZgfj+Y9wcnHQrI638CQ9M7Y1hjLwSJ9jNpWt+eTYYf3EJDAqRCsupp34mAcWNOCXHBi/c/EQo0OswGjoHoWwv30bgpKGvbCtruM3PHjkaQk561o5ZPaZvEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJ0dMe4T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mB7izLKp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ0dMe4T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mB7izLKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787830871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wu5FgtZmyt12/HiCrKqah0/7jy+9+aNLplj2ocXAM/w=;
	b=fJ0dMe4T9E+YeaU7IfeLdGWS4BN4JNEJUZNzrXHY12UlbNYaTic1+Jceu6lWyMJNbg5fA/
	TAi2e3B1TucBuOkGfMhZtLXBrBMRAa12hTYXjxyZaEn1fpgtrBb3R0KCAv/EDkKwAaFZg0
	rjP/MDYc3wJJHs1H/cMb2ZouD3pVofw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-obx52GQ1OnW3jXl2bbUArg-1; Thu, 27 Aug 2026 07:41:09 -0400
X-MC-Unique: obx52GQ1OnW3jXl2bbUArg-1
X-Mimecast-MFC-AGG-ID: obx52GQ1OnW3jXl2bbUArg_1787830868
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2541129b02so51710166b.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787830868; x=1788435668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wu5FgtZmyt12/HiCrKqah0/7jy+9+aNLplj2ocXAM/w=;
        b=mB7izLKpbh58yg8b1pQePQSiA7MG+jsV9vrms5f3SQoeckU2+75Gy61xbQfIq2sXaN
         2TBTpMb7S4ta4ZdCd/gQu2lodkOvQQ6pKlweJYToa2cwzZR5BtmvVPiAw4i3p6d/dLnW
         WLRZktnNWuCqRdRMZGotzcc2CRTHlbEGXLUk8fYYK6X/1Q++BVSyvPMPVMFY2RRBU5vR
         4BnRTiSBFpo2I2QlQREOKElOCwOgwS7jAPVOn/78qx4tmqG2c7Z1j1NRTBGJnsDDTxwO
         Rn/Rdhxnv8Ig2ueqanZ3DGfNHuHE71WeYsRglrCWaJyvmBWeU1BmtNBaTlqA74W/vd6y
         bppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787830868; x=1788435668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wu5FgtZmyt12/HiCrKqah0/7jy+9+aNLplj2ocXAM/w=;
        b=SVX451FkPPufMt7OBZSp7ZvasZlUBtMb0PFMswZRWM+Covfs7bTgiNEcYrFhjO4F0q
         Rbnr9n/qlX3JG0nNtoTjcpN9SPV7jyoqf0XIdVAVHpPyoSQUtzTe2ga5VXagP4bvIirC
         9ItB4DcABXHFRT+jZgNL8KqD4SelbJnfuY5owe00DAcu5QtJY5Rb9wES/oErxs1lLlth
         GkdS12GgGn63XY4Ia7y6WMFkzEDajQhKIWUi4gonSHe/bfUmVZ05RyGIJcF2Nn4gqSl3
         /EBlbOkJDQObB7Tho6tsSxbFI2F7uDBKasb1hB6gjocooGL9iW4Wk/krs5slpUA9IrcP
         CR0w==
X-Gm-Message-State: AFuF++kYkuxg/1i4qd3OJUOwR9XuElfc19dX/M0j00XGXJKC5+tNIrHd
	5aCH4n47UjmVBCRj1867OuOqlmWY0CzM+CGjgRFb6r9ansjV72NBiGWhXXnkPfeGXRBfARB29Eh
	kbh71UMmYFWko69058uMLVDSkWZBqxU+QJGboQnwSwKzuh+AHFq40kPAajUL/g/c=
X-Gm-Gg: AR+sD12/cjUJDbJzhfJKkuVBFFDwLCHZ5tPlqDKcgxQXR/WBHxsjme1fn/vQJwVefCR
	+9/T+ovVAbPhDacnP3ytNGCcz3ltoG14tkZw/bk2dSYFeSp7ALhXlxV2h3eKrksWxB3nMjgIQEX
	EmPLxDdLlOYJULdu4t+siiaWTQrkkQ7X6TuIY6fKF09Oo+VaIbmoOJutUfwsI4zJLqf74uTxdN5
	HkphEgS+d5a3eyOTt+ZUSlxONPt8oRiTDGyMsCFIDBQEXJx/dpnV2e8l5ul+60nVFV03cHBBLz5
	fHMHv40Zqj3Bf+UwNWbfm+bb3WZScLv0jfoE7tiWTdDmmkuXL80KY7/aNv0BW1/7egDhCQ==
X-Received: by 2002:a17:907:9701:b0:c24:b11a:46fc with SMTP id a640c23a62f3a-c250c35b4ffmr1399785566b.22.1787830868176;
        Thu, 27 Aug 2026 04:41:08 -0700 (PDT)
X-Received: by 2002:a17:907:9701:b0:c24:b11a:46fc with SMTP id a640c23a62f3a-c250c35b4ffmr1399782366b.22.1787830867816;
        Thu, 27 Aug 2026 04:41:07 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b43absm729352766b.51.2026.08.27.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 04:41:06 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v3] ceph: parallelize object copy in ceph_do_objects_copy()
Date: Thu, 27 Aug 2026 11:41:02 +0000
Message-Id: <20260827114102.2750347-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826-b4-ceph-copyfrom-v3-1-9bbeb82a9a80@clyso.com>
References: <20260826-b4-ceph-copyfrom-v3-1-9bbeb82a9a80@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please send a v4.

  1. fs/ceph/file.c:3078: Parallel COPY_FROM2 leaves dest objects past the reported result
     Xiubo, `orig_dst_off >= i_size` does not keep speculative copies
     hidden.
     On first failure, drop dest objects after `first_fail_obj` (or bump
     truncate_seq/truncate_size to the published EOF before returning).

-- 
Alex Markuze

