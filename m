Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E312E413
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841859; cv=none; b=eOu7wbttNkX81h+1DKFVQ9E3h83HtxSEyeMaAbpmML/SCMW36UVHSzzrPB9gkEscn4jxOg1TVYu+AM3T78MFTe6PiXpKNHr575xAXwhgfMp0BgoqloKsMSFOC9rUujFw1YctfYjpVHHv9y9X5RHblF8bsDNGx6pi2wnNT+Bq76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841859; c=relaxed/simple;
	bh=l64XqOfzLwV091r9xhP6edcYT4OkkKGlqDIgCIHEU90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVlcA0+t/3k2Wpv0VwtAEWbv8ZYPdd5q2YUfnHZHy4IqPeUawJSWMnnjHoWdb5J8f3wf+CzyxowPyTb4z2BeueXKxYKJhuNuWN+wlQJFQ3sOvqglvAKZ1gFnXv1fH6etXHsF8/yc6HKwtZzXgycIpwz7501/lXO00z9I/C2Gtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oy64D+nN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyCEAKeY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oy64D+nN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyCEAKeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782841856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANrBPzoaylcugYDR/BdhSrTqyukEBLAX2MMJa5SwjfE=;
	b=Oy64D+nNFFKsOs5SF8fZQuEbVDu/UwCkNBDy+ijxPHLIOes4tpqlX+Um1mJQUBy9hcQTPg
	wsqbdBAULV3tJfsvyu0dQaXCWRy68IlG2E4dkMRsbgSvP9Ox23b89GVBQF+3c7YxfcqggN
	lkayLi4Fvnm4Y6XWftifIUpPGnTm26w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-PQg3_b_nMQymLKaXyY6qPA-1; Tue, 30 Jun 2026 13:50:54 -0400
X-MC-Unique: PQg3_b_nMQymLKaXyY6qPA-1
X-Mimecast-MFC-AGG-ID: PQg3_b_nMQymLKaXyY6qPA_1782841853
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c126f7ef83cso193462966b.3
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782841853; x=1783446653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANrBPzoaylcugYDR/BdhSrTqyukEBLAX2MMJa5SwjfE=;
        b=OyCEAKeY+XD5owi80+WZnnGEzXSxrGl1q7om4lXepfnL3Mz5nk0672VMg33rcazy/g
         WpwP1Rysbn3RASXQwoFoEqH65Y+J7isFoIcO7tuISAf9TYAd7UX2EiqM+hPWMyaJAKeU
         fSyw1RC6YknKF8hbY2i5VZFCY6xskg4XSat7lpMfFejlzsyajrzA6Ji22Cjgc52kxW/x
         Dff5d6c5awM5mq20I7nKBcmgchggabecWStm7+qUbHw0ANGl8a9BUewA3odab414D81g
         xgizJkvlzvJ75jA0TV2Os/PHZtID3no3qtSyRKek+vzXRuur0ZDVXmqwU29LAYyPY1nk
         dbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841853; x=1783446653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ANrBPzoaylcugYDR/BdhSrTqyukEBLAX2MMJa5SwjfE=;
        b=NyyUWwUnzOili7EWQg0v/6MjNs2HBEaTrkEaSDVJjholZpnM/gBYaU8Nkcxou00yHw
         ITdV8IM+BXvIitiM2ihprDfrzmtALghrl/1ZsEWgpWtGHvboIn0+N3tit4U+X0gS5eEw
         y60WOiZVyrV99y3jR9VRxF0I8EtWjEqS8sf6L4cKvBSrUJnLrpmzm8Vgp9uGhgfwgXWa
         pE9gBd2XI4mpzhiOpZjuLDDGUCUFY/cgzJDT57CfwG42BzovkaL/7/Xuxm7nu4E1FOEq
         OA2pHCfG+FiQGPt4Lcnrs8AKGyNWqGV26dd7rpvO455TGEkbHbBrINzwUix/NqXdJCr6
         9T6A==
X-Gm-Message-State: AOJu0YyUFufMRjrRaKbL3gG8XjkSgSeDBlW5+bN3N88OABFfkeAjwdGb
	FHn4FXsV+jowcNSiidV5Tkj140QBHitiBIIgkkl2bD1+d3HU9NBe9AV9CMUZejdh5lglbL7zaSb
	sIZIUPs6NBGFOz3Rd3HccygdrotVLgMf+yNTBhtkn58m+McndB4lfeAqDTcrJ1wP51guZQyCgHg
	==
X-Gm-Gg: AfdE7ckPgGodAH0CQ0bA1ujR5a/GYvt/GKrQrD63Mqj6i0EVw1qZSjp2a2SFCQUX/ox
	CbYADtgS9eoMsYikqxK0GNoQHw2Nmfs5thPeIiMw3kbsyHoN9xFwSLlSRypBqMh51xzHenLuntP
	lu7Z5CHITVZa4nZ3HB89ddNxqbuzpwOr01lW2GXOFmttFyiA8Gv0ttnssfwJvnVU2tuBoFeA7xM
	PjI5iNhNmTDdiWXV5RjlyK4G/x5yZKJMgdKPKV81Si2Y0E/GZPf4crtPn42jBvjIytEOsGpnysD
	XTMgDgf4HnbgfskXBxRX5QhBeULSBc2eobXhyH+3G3ozHOPdiiIs5XABhOVrSBtLJ+JwjfZkl4m
	tB8lN2UTAU9Jx1RWjeQVqe90zlqz1M2ACVZpdfeK0mva8
X-Received: by 2002:a17:906:794c:b0:c12:70e8:6025 with SMTP id a640c23a62f3a-c12870d224fmr217194466b.21.1782841852879;
        Tue, 30 Jun 2026 10:50:52 -0700 (PDT)
X-Received: by 2002:a17:906:794c:b0:c12:70e8:6025 with SMTP id a640c23a62f3a-c12870d224fmr217193566b.21.1782841852426;
        Tue, 30 Jun 2026 10:50:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19df8sm162252766b.10.2026.06.30.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:50:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: fix denial of service issue in ceph_update_snap_trace()
Date: Tue, 30 Jun 2026 17:50:50 +0000
Message-Id: <20260630175050.446307-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520214700.1265095-2-slava@dubeyko.com>
References: <20260520214700.1265095-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

This looks like the right direction to me, but I have a couple of comments.

The Fixes tag seems to point at the later debug-log formatting change. The
WARN/remount path looks like it was introduced by:

  a68e564adcaa ("ceph: blocklist the kclient when receiving corrupted snap trace")

so I think that is the better Fixes target.

Also, since `cl` is already in scope here, could you use
`pr_warn_ratelimited_client()` instead of open-coding the `[client.%lld]`
prefix? That keeps the log format consistent with the adjacent
`pr_err_client()` and preserves the fsid in the message.

-- 
Alex Markuze

