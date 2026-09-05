Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C734E744
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788631218; cv=none; b=AKwflG3rIi/pRoxqW+YkCbj+oD1C5C+VrdEB96FuEOb3cJZTZQqYSE/gluyXo8say4wVsT8yBZboAYTArPqBoAxTdyacA/Qqowcs5XWNmqRVhK3j4J6EwnuoQUX+qwUQVbvKFOObiO9U5B0tYqMjn/zOltYFiyRbmz99LquzEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788631218; c=relaxed/simple;
	bh=BvSzOkMw8HjF2paKgvzN2UvG8P3U6UsaZFJU/XcjgVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEVoNc6JrXchgNnw/hLNL/tEsbRtPg8k5eQOo6bPiKh/e065U2w9fhmSrgfHhhXlqlV5TQ+gK1wx4tn2MEPuuei+w5G6gHg8iPSYuVZoYstU3pWL6Sat6lMLO2CdF/f58fUBLxWKGoRpg4R4EgxMvgDlPjYEFK16UuckeNH+CIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wri1jOrJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uD+FGBDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wri1jOrJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uD+FGBDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788631215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofXIzF7Qsg7Ru5c3RxIF3R8pPVKoZ5HuZ/8o74498CA=;
	b=Wri1jOrJ9GF56cDLUqLjn+bFgT/h2laaRPcVpWqPbFzVH1JzZEDv1HTcSeVfUwcCMM/0PI
	i1gGb8Mms49e/oUSwOXQLjsMkvNDRLTAHVo7MZdF3brLnlo6O9xzmLKsFspC5X9FVavFHz
	b/n3ghG4KntbZwIq02YZI22yMJgj3Fk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-E11sGSdRNWGEYrVvFMNpkw-1; Sat, 05 Sep 2026 14:00:14 -0400
X-MC-Unique: E11sGSdRNWGEYrVvFMNpkw-1
X-Mimecast-MFC-AGG-ID: E11sGSdRNWGEYrVvFMNpkw_1788631213
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53000c06184so53694351cf.3
        for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2026 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788631213; x=1789236013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ofXIzF7Qsg7Ru5c3RxIF3R8pPVKoZ5HuZ/8o74498CA=;
        b=uD+FGBDaVXVgeFIoM6oZSWdcpC3sfVc4iPFLXDEnsq62LtGwjfHIcoeruhXtf/DKbj
         smm1omrX80jAuceZRJyZnK1GxvI8s+HLpc3Qwufotdhelz05fGvVz1tFWyELvguyqYWr
         5IY5OPZdGr6c+pVvTFGzNEq8WsywF1uXnfmqgqXu0bmn1FmV3WQqwAE4emHSEqAQhdT/
         vRZjFYiIoFnbOKQ3U93czOj1G1v/Nc1mRQ5FKiqroFeTOP+S8Qamj0aCld5ZzP/jwp1E
         zCCw5qUIh3lp0LN2GGGECnZWOEGDupM2W5raAS+HD9Z8r9fczhZpQtuaykO4/TAlWSAh
         2YIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788631213; x=1789236013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ofXIzF7Qsg7Ru5c3RxIF3R8pPVKoZ5HuZ/8o74498CA=;
        b=WVV/s3MEnd89y3c7dpOhM1GlkznexShDcq6CKXz8zufLwg6Dh38+ScWkNYgQSsRnDR
         zRG8e7lnUzoJCdkEQXrtMdiO4FZcIFA5jZPvqrbrW5jCJx+mOj9NsogOnNcFzbprmq9q
         KCrDyHXALLH2OvRSgO79tzCKPA/7xLwjUSyj/T5Wwz1khyNW/I219NsygMlUpAniPKBK
         Agb5/SSduNoVKgTwjoDNipVoDLwpa23+Xmmw7lwiSYC//60aA1J5/OeiQt2BHv+oKxdw
         TcSUuMtxCNTTXYHxeDt+PBQ86PO4W5u9Rob1PYUpeNKcUqoMJInpw0H4d/GOx97PTVPO
         3MxA==
X-Gm-Message-State: AFuF++m70D0IlRcsGBcW3K6Zvkyvg3z8943R0ziDale7pAkWJG7m3qz5
	XWvsBTXc02c9TMHkBaE/jAry0YZNEm4f8AaadIlpDr0+U1eUGnncMm1Db405gfx63+6E1LGfAbg
	/GZrCC3cf8Kc0Cg907BfXd3zcSJ1b7a1UOT5hamPhXmWfTBQBWsQ9ndLMcKIdPbvJzG116aRoCQ
	==
X-Gm-Gg: AYBFou0iwmWTkMm5qd0dkOvmQug+dc2uav+VQGRSHBO7f1m8Tvvy+MUGNVC+/X+8Oc6
	/ZkR+7fgsTdmkNWKdtTARkOFa5a19TIVerPOez+xu36meze9/RkVkF0oFeZ2yJ+W+KH6cI5mQ/O
	jclIMMjS7KbEzUeJB6OzudfH6ru2+MXau3VY0lxqxOVYSAirP3m9NN9tcyf3t9nRyf+LlxZR+9S
	tQpU/D6Xqe9NQbsfT2gW7+I6LMku68Y2ZhMxlc9y9Z4RE+7pNs9CtGfOabskfSIkX3GcO46bjgL
	PEKSLNGwVDWGUvqENSlYMHr0Ro9bRLHdbSd5SPgSHSqezO+NpDqcX/2DunGdyWnZn0QIqNLWQLe
	Ukq7FNeagWFMM7jml9VlK0nCHibbXmo12ZQw3armojTwYqeHlYv93Iy1KE+RmvsfSN5M3PTOgs1
	vyYCPks4Q0F9B//Q==
X-Received: by 2002:a05:622a:138e:b0:530:42d4:4c99 with SMTP id d75a77b69052e-53054a341femr142527371cf.43.1788631213107;
        Sat, 05 Sep 2026 11:00:13 -0700 (PDT)
X-Received: by 2002:a05:622a:138e:b0:530:42d4:4c99 with SMTP id d75a77b69052e-53054a341femr142526561cf.43.1788631212502;
        Sat, 05 Sep 2026 11:00:12 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305402a8fcsm48543611cf.1.2026.09.05.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:00:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v4] ceph: parallelize object copy in ceph_do_objects_copy()
Date: Sat,  5 Sep 2026 18:00:09 +0000
Message-Id: <20260905180009.3453362-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831-b4-ceph-copyfrom-v4-1-3841c930bb31@clyso.com>
References: <20260831-b4-ceph-copyfrom-v4-1-3841c930bb31@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please respin.

  1. fs/ceph/file.c:3183: Drain loop waits on an empty ring slot after alloc failure
     After the inner submit loop, the outer loop always calls
     `ceph_osdc_wait_request(osdc, reqs[slot])`.
     After the submit loop, skip the wait when `inflight == 0` (or `head
     == tail`).
  2. fs/ceph/file.c:3250: Local truncate_seq bump does not hide speculative writes cluster-wide
     Parallel COPY_FROM2 can leave destination objects past the first
     failure.
     Delete or OSD-truncate the speculative objects past
     `first_fail_obj`, or go through MDS setattr so the seq is
     cluster-wide.

-- 
Alex Markuze

