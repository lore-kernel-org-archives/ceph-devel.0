Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A1420477
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378936; cv=none; b=qtuYlygXPFWMjkxB2b95rBDF6hVCi1dWtyUWYMl633kwCbllDj8UR/fkNZo1/CPISqDR2YjnNWYoxDskzz7QK5weoEgcJ2M1zOgO7k0UMdx7LyKvtjr1OOsjSH6jIlUJlLxX1vvirqcoToY0rHLfS2zkYvboJhye8VA8e7zI0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378936; c=relaxed/simple;
	bh=O+xDupOCBqBYBh8CTWa4e922z+h+DZt56yy4VtxBwHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qF2AWCT6LxA3fYt0cr7A4uY8YP/mSJnff29nSBDOrddFpwb7gYuPj6sz9KQ2UnuiT1pGlQtx+MC5piPo0vytaexzW26C8csGhOV+ItJnB0lwqe+uEtFd2Mebt1TGzF0q6EMMiE+9OqmE9LW8ktCnbSfuUF0osuaz73TEqdSaNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9dfrwg2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGhOfp7U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9dfrwg2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGhOfp7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789378932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh7GypYfu7alWxHI6JvucQ18VIZ8n5w7ecbhKC06jyU=;
	b=V9dfrwg2RvIZnDIRPQYizx7MlxJV0GsWaJ37A/jMsNvdDCRHPl0kWtE2qq0t4x1aXOVCl9
	ki7+JjKcG1pMLcbPZYmrrBfGJVlsWtpkbN2p77nH0jXTWvhB6Rnzw+ztZgfumIP3E9UFFO
	dxO5kd2sNd5c/nCGSCzdJyaRsvC5kS4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-0AZkBQGAOp26lHG9lkVcYw-1; Mon, 14 Sep 2026 05:42:11 -0400
X-MC-Unique: 0AZkBQGAOp26lHG9lkVcYw-1
X-Mimecast-MFC-AGG-ID: 0AZkBQGAOp26lHG9lkVcYw_1789378930
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2939083cefso330101866b.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789378930; x=1789983730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kh7GypYfu7alWxHI6JvucQ18VIZ8n5w7ecbhKC06jyU=;
        b=MGhOfp7U4coLAX1yuFWS8IkWoA4EwgqEcRxw8bS1r0092MlJvsCK/uoCJIvX/x5TJZ
         26zqfLdQ9ACSuzXQ/Rea/lGvL/mpx1rmpYEONiIjidC29LYD61aFoyAp74xau6Y8eqGq
         zMuubNiiVfz6M/hb9l4TDG/MYwLNhklHlCqfucE6Ih6SPRq+NxsWBF84fuTyGT5rz57v
         jFtCnmp8IIkXBsyoZO6AsobnMrNybl0CSy4L3mwro/W2ayYQAOMQDNxMCyeGWZSl+zdY
         My6Puj36qA0Jq3jIdST/UG//4Jvy/dSBHz9IlrRRdO2TWlicfxTVmkY3y/HdfLfwZyQ0
         ppWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378930; x=1789983730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kh7GypYfu7alWxHI6JvucQ18VIZ8n5w7ecbhKC06jyU=;
        b=mPgzn6oWIu+7ilfSTC7RTacuDeQbtjebORn8aPHTv4p5Ka0sEhuKuUtgt+B0f3d2MN
         uD5Utt2zz3Y+xZx3Pho450Lb1TlVSwf0drVFQI59KwW6Cr58SlR66koKQpVuQ3zPooEW
         BdO3A8V3iwbnIVvilc+unAzIv5t3fYYYPn9wt0fZuZOvqwYW2Qe0jNhRrJ6xRixnkn8+
         ulVhqJ/4olnj9msnFOzsPu2mNvCaHXqjIKaUC9k7KaVmmQlzBlLDvNcB1vaVxUVcb5iw
         u4WM29GJdXeT5uugJJzbPzuXyITk6/ZJ8IUl+rSOdkjMBX2gVNXjMrZwYlAnJhmaQSc/
         zlCw==
X-Gm-Message-State: AFuF++lrE2OY/o6gnUq3vAAXc/edC8ab7O49MV2GGBhaT3ioZARgf44q
	u60fSNWhTC5egmjx2M18WNWozf/uNEHWABUsaPAwMSCW5nvgYbLKAWeOz30gurI9yOdGhKpI5mY
	L457CQ895yPE/p7tB/AdA9UyfR2v1WJBxBMXDy//UNJT60zqGADiRzybvfm3GHME=
X-Gm-Gg: AYBFou0b/w/h7NI8J7mEpRGghWtcDq93dRuMiLdcVNlrwaF/zpgEw5nEUis6uq1F4qM
	bAOhdobAkLpOfH66f4MnbUfKtJigeR+sGKWt216NI/B8rdmkpAplnzwjCEyYKnSaSlBjVDRub5c
	MxyFeIlpNOAl9kPVLxSx5TSbKQuq0fnUL51Ywp+zRVbM/mgMxAu5scGd7H3J4l02o6ezPlhPjSx
	wRyiixE/P8oWhlc4/gKNNUvMdCf964pURU+6+Ghi6QzTWeiLeWt+5lIv75IbdXBZN59rrsM4z/b
	h3+NqlkHOaCvfsqReMhtQSnvZiZGf6T+KTElzLPYhuA4YuWcHWhP4cMqlbhpIDkTDHlJywolH+e
	aowkJ0R4IfEFK2LHT50K5itV11HCqnCC2Gk5dNC/ltaUdr6u8/c458zDa+Wm3rxjjdJOghDSsdw
	td/NoAyl+3BeTUXw==
X-Received: by 2002:a17:907:3fa6:b0:c29:8d4:7c03 with SMTP id a640c23a62f3a-c29b87223e2mr120037866b.26.1789378929864;
        Mon, 14 Sep 2026 02:42:09 -0700 (PDT)
X-Received: by 2002:a17:907:3fa6:b0:c29:8d4:7c03 with SMTP id a640c23a62f3a-c29b87223e2mr120035666b.26.1789378929408;
        Mon, 14 Sep 2026 02:42:09 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966021ae8sm394382466b.22.2026.09.14.02.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:42:09 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2,2/2] ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()
Date: Mon, 14 Sep 2026 09:42:07 +0000
Message-Id: <20260914094207.145031-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910030036.1045515-2-zhugl3@xiaopeng.com>
References: <20260910030036.1045515-2-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Guanglei,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

