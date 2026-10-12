Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72465368D52
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790137; cv=none; b=GEmeKYlxKM7szvSpzr8shchLj2p6Nvtx778N9ejNTfIHkx61apFCZVnMfac78DWlMhkhdSQePFfxfd5tIDF4l7GZ5a8sGaWu+pg85tdOd3fb70pLp4sWW+uRgqOfHYBRvNVDz6kA4wcbk1We6GURSabgqKSb4u428yRbSTKsEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790137; c=relaxed/simple;
	bh=6WdS+fro3N/vEPsMKIPJSJIM04PhkzsWmPwlNvCmle4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiAxXW7IIgIbZX011k8zRM80tTTD9/vhJp8i3asodPDxiUSu6h9/cBvtS4aD3fAIF0rE3PdC+DW+Tg9nHpuM7372vmE0Hvz4mJdnXtn7RSFCMRDTToT5IvOEO4Ch9Fh0hIlhMgZor5ZqisrW9r8mpBhtEXP7J03MZYF0YlusJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIr2vikM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eH4cxYuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIr2vikM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eH4cxYuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791790135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGUHN/4qcdcvwi8pMbbAbpz/l51ZZJoOqIrpXpZZj9s=;
	b=bIr2vikMCBXYfDdGZdNVj/Ga3lx/QsOrRJpfpIVdd+UQpkqFjOvykQNcgjh/4Hm6Jirz7p
	4TOJrvAGPTk8rpWgDz48XcOZECINuAhYTYM4pTleMo3BesFFLT5P/B2N/Mcaww42LajuuG
	iKHog5B71my3jx4RGUrSL+Xgi3CqZNc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Zy9XIlpsNV-Lh-jmXl5Bdg-1; Mon, 12 Oct 2026 07:28:54 +0000
X-MC-Unique: Zy9XIlpsNV-Lh-jmXl5Bdg-1
X-Mimecast-MFC-AGG-ID: Zy9XIlpsNV-Lh-jmXl5Bdg_1791790133
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2e6cbb6152so152178266b.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791790133; x=1792394933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VGUHN/4qcdcvwi8pMbbAbpz/l51ZZJoOqIrpXpZZj9s=;
        b=eH4cxYuDxBrycV/2x9IFpi11Pv8DRPH8qWGsZhwkcB7CY/1bWiX7NA9kv7J+lWd1+D
         mOFUBrGsBL3abtjY5K9Rw4pO8mwVKhTYkibigq4DG9HMOB4odW5MxeIzZEH/mPR9TV6F
         ceWNXwhV8MdeBf4RXwJf0bNEVptS9r1B1ays9YXErGVIGWPCspGyKshUkRhCVtXAQGuQ
         laWdHpCRzzTGBhq4R6IdG6rqBuNdjH2ccXhdRv8I+CocPHfW49bil0oUP4alvt7/1aPh
         RaPvVR32gk/KNuFzz/w8BdXBf5Lf0fm2CNSlDYf/s+N/fv9uhQj9MZtlb0btyIEaLJ0w
         Tz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790133; x=1792394933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VGUHN/4qcdcvwi8pMbbAbpz/l51ZZJoOqIrpXpZZj9s=;
        b=xliLOQ7EDx88gdby+zM2gGIEb1gAuefOho386wq4DjMiXFtm9DbRowuyzo64C85aLk
         tLdmLM1iWB+7X1II13mM/6Wavq8bCsR33/RPgvCm/UP9ahYcZ2xyyosr83Q9BbDGJylW
         YjPHb+b+88OsA+hVxLu67Pdt2Yt0Gu50hH9sE+bvAGYvt/HiDao2B4Yo75OwnWRHkWN5
         oVfx7Xu+EYvL/dU9PxJ0KGIVwteUMXNFnM3jaEeZLJihEF3WSEbXudyksPYZIFlOaQG6
         /WlVg2JDOsUXqnjr00wTcGrbB+JioMN49KXh0KPPDP3ltfiMPp4RvrKtmHLtV3ec9Iue
         nseg==
X-Gm-Message-State: AFq9FYLiX18jfRGTv6aDqP0qUyYXobhOvbxVgKzLbxLFJucttrfesRQu
	UgGG1gNyafAbyHEgYUvxrlSo/fKu5KENXO3rtEsFr7ToyfNJVU5UPJX6wor39i9NWdWBUv+DXtH
	ebO05YyAtA1/BJ3+qFVXCwhpRQDDj1Wpyy4/4A2L8j/MO6YQdXz5Z63ZNTISi6W4=
X-Gm-Gg: AYBFou18Im29hXMjnYFCi2xHzvIE65esC5JvMhczX6fhtqlw+l2oEWCoNsxm8C8mktL
	wOyCKrcJVhzBn9oWpdCwMq8R657AQsFA9cCezQ/e3yrNzqgUHJbGxjF+hrnew7+QD+umLb9UGwj
	T4QsDJDaog1L0zRa4TI99EBr7zpjtNkn9oyJ0m+peLeX+Tg+aSpm8MNshJFtCDRsxKzgi+CUkNy
	eTgUFQGL2Uvhy/ZRtH5inNQBXww4Rv36OATRL5YXgrsblW0suZSpxamXQt9Ta9Al4mHxi1oHPV8
	YwEP0hRjNaUAtDsdkfPs4A69qQdaeDIc7quTjXDq1DVAT8PTTVJnDd7n0DC+tGZmb2Y8m4v5ky5
	54D1LgNVe3eOB4FoHG/cyqv8yZ8MCMAnX4YIGX/UKagRwTOapt/iLo3Z+b+2HBWqu5PSK+PyWP/
	q/dT+lLnuRma4AdA==
X-Received: by 2002:a17:907:94c4:b0:c2e:7fe7:2898 with SMTP id a640c23a62f3a-c31a9d5db26mr824323866b.12.1791790132978;
        Mon, 12 Oct 2026 00:28:52 -0700 (PDT)
X-Received: by 2002:a17:907:94c4:b0:c2e:7fe7:2898 with SMTP id a640c23a62f3a-c31a9d5db26mr824322866b.12.1791790132647;
        Mon, 12 Oct 2026 00:28:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a74bcbsm432574466b.38.2026.10.12.00.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:28:52 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH] libceph: fix client panic on MDS message with data but no data items
Date: Mon, 12 Oct 2026 07:28:51 +0000
Message-Id: <20261012072851.3431644-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010073543.2912416-1-bsdhenrymartin@gmail.com>
References: <20261010073543.2912416-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Henry,

NACK. This is redundant.

ceph_msg_new() leaves data_length and num_data_items at 0.
mds_alloc_msg() skips a message whose data_len is greater than
data_length, and both messengers honor that skip before
ceph_msg_data_cursor_init(). mon_alloc_msg() and a non-sparse OSD
reply do the same. data_length grows only when a data item is added,
so the BUG_ON(!msg->num_data_items) is not reached.

-- 
Alex Markuze

