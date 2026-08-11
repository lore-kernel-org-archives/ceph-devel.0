Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A9414A09
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455893; cv=none; b=K6WJJY+mmaWm7YLLshMk6rZF2ReTuYTDK32L056cSdJB/X94qgu9OYNRki5Kyl2UfnEmCObCE33wNJ5VEIMmBH+eBgK+qXIxKioB/spkHtr3Tj1LRa9EiX9fcu6tjZmAUPdvxb0i5H1KkqGwGHJVSZui5Batf78E0n2XqYio6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455893; c=relaxed/simple;
	bh=GrWSK5wQF/H0iFfK2trp+UtmgncVqyweItfUnBpJr3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOGgs1k7jxtX6ih8crUEwkgzI+xVeLx2uAvJ7x4OBzSXH2MRIMdofrOoZu4I/XubCTihw2FeIfMeX/7BjBG/KpygB1v2goVAQJU3ARBnz/DoXPn/aAJVUDw88UlbGUU6T1bUKvWXluXEDB+sPIfizS67g64Bb/WT4VmKbXJJ0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNOveTH1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqDKkKxE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNOveTH1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqDKkKxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786455888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrWSK5wQF/H0iFfK2trp+UtmgncVqyweItfUnBpJr3A=;
	b=TNOveTH1GlPCmnK+dCpy+luUzClQxJaB5GhlwbUAGIk8mM6znxWLsZ+UD7fAbMdeEc7qFK
	tqekxX8kUvzquQPwheODvXEiTWzbruHnaFnLY2bwTqWlO7Xrpfq3kbz37OD1xcAIW8ds6B
	50OwdYWqGJkX/W5DEcgEdDIQ6agPQ/A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ASVPtmdLNjesuAuo1TTszA-1; Tue, 11 Aug 2026 09:44:35 -0400
X-MC-Unique: ASVPtmdLNjesuAuo1TTszA-1
X-Mimecast-MFC-AGG-ID: ASVPtmdLNjesuAuo1TTszA_1786455874
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c206d40018aso94875266b.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786455874; x=1787060674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GrWSK5wQF/H0iFfK2trp+UtmgncVqyweItfUnBpJr3A=;
        b=bqDKkKxEPNAjxL485Tyy3aO/klFsM0VUQF76lQIbPLPaMAcpB5gJXIRQlLr+mHx7pJ
         pZPztkl26DUiXh9piB1fiGWPnd8kCZ9FuE/+VPKVAx7PCCWTwX+uJp2ojzypefA83Gou
         6CVDYHUvIx98EtagpwNFlsmByuoFwCG+XHZ5KELWBWrnFK5fdNa2ZwJ3B6kAhSM8tF6O
         dvjG8U2QhhQ9mXIctHHKv6NK3JsIVG/Pl2f0fraqE39pm+grlfh5mZfJNw152cYBungh
         e3GIE+mS529boD5cIwb/3xNLuMKEFv080FYt/gCs+KEFfqjuQ0lWxppCCHfcevUFh3FT
         CJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455874; x=1787060674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GrWSK5wQF/H0iFfK2trp+UtmgncVqyweItfUnBpJr3A=;
        b=L+cyINff1yM1OZDDBMDFVKOWjVAAtu495OErS3kyDyDJI3vB7t+wWXeE/e/ZnELqQA
         fd9xKpEg43+h24jrhn2wDK6+YcbM1087VPsjwsCatGcVtukZTe2i4gbNYCNgDhqBSU+W
         kBvBwfiMA/Zw3ny/yIA4MqmUUfCYBrA8cBq08L37C3+4FY0/tOeXIJS9mCyejP5RHDED
         XkmlqUqbzbDwjcvTXCX3J+0un9PZIDAxE7DcdI+cF4HiQJB4exXyUFIiTJBqwJCKRKGW
         mi06Xsgy6bCpFDUpXjwSebJp+bSI0v9dkbbT1u5WQo3n2CD5L8nYTOTE9Sztzj20225R
         gp3g==
X-Forwarded-Encrypted: i=1; AHgh+RpxL8QNmrGDquhWjyIOdKD13RLoDAOS7en6cvsRTkctPy+LSltdDx84I9rthSRPmGRlWAC6BTAfzO05@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt85lw00KMMz4OTcqAX2bmHhu6qo1ljEKSQ+2qpFRCJcmHa7N+
	0b2gVRDRb7UkBngu/9lSGc120onJi8VUD2repUlWrMl6heCB9F7VbuTuSIrFPcIuWORb+g4NYUf
	LRAa4ar/eM/n+XD0UHbgECS4/ZOCsxfuewkUKsQetjUt43DoHxEUdFLxeMKSHhuo=
X-Gm-Gg: AR+sD13lT4wA6wNLTcg2E/e4tWJQo33NRtx3iOrHBZP3DZ+vEmzRcdG61ZvknSapsqU
	Gb7qrROlU2v2sW6tjXDMwraNWJJGagWxB3GsJwF9ApBDwoY3D1dlTp8c626EfuB2igTdcfOQ5x/
	o5Ypk7NFhEqd7q/SeoiUlo5J4PFkyBRG3lJI/rnLdEDrjgYn4E1/hPFFWVHSEqP0VhHXc5FrJJe
	ByG/mA3+2cGZI0Yj7S038YpU9whvJKrVca4RfH+qy+4RVfWw4qKkbFpw9w53iFX0d1gySVW4pq3
	irrgzbxAGWiHmrwQVY5NXJTsvCd565+Cbw0PvDQHYgRJMDlNbtEIVMC3mJ/UHSMsmH+kSZqr3vg
	hPnyM7kNcHh5PgNMiTz4v9VyuA+f0MymBHQ==
X-Received: by 2002:a17:907:728e:b0:c1c:4c72:e6df with SMTP id a640c23a62f3a-c20ece246f0mr21050866b.0.1786455874026;
        Tue, 11 Aug 2026 06:44:34 -0700 (PDT)
X-Received: by 2002:a17:907:728e:b0:c1c:4c72:e6df with SMTP id a640c23a62f3a-c20ece246f0mr21048166b.0.1786455873616;
        Tue, 11 Aug 2026 06:44:33 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e41010f9sm55638766b.18.2026.08.11.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:44:33 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] ceph: narrow mdsc->mutex scope in replay_unsafe_requests
Date: Tue, 11 Aug 2026 13:44:32 +0000
Message-Id: <20260811134432.2689604-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811-ceph-mdsc-mutex-optimization-v3-5-d031114419f4@clyso.com>
References: <20260811-ceph-mdsc-mutex-optimization-v3-5-d031114419f4@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

The collect-then-replay pattern here has a list-node race.

list_move(&req->r_unsafe_item, &unsafe_list) takes requests off
session->s_unsafe onto a local list under the mutex. After the mutex is
dropped, the replay loop iterates unsafe_list via r_unsafe_item.
Meanwhile handle_reply() -> __unregister_request() can call
list_del_init(&req->r_unsafe_item) under the mutex from another thread,
mutating the local-list linkage while the replay loop is walking it.
The kref prevents use-after-free, but the list traversal itself is
unsynchronized. Same issue affects old_list.

One way to fix this would be to collect refcounted pointers into an
array (or use storage independent of r_unsafe_item) for the local
iteration, leaving the requests on their canonical lists.

--
Alex Markuze

