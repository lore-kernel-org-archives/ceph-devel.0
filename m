Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CA431A38
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139398; cv=none; b=RHJAsJOG/PnlXFGdwq1LToom6GIqgm1MkOTcIILLvnwGDKOHQ+naL5KGy9Id4+1te9xEK9hQ4dcYfHt9XnZAtGRxBrDGA5nD4KImhOuu/MeA198xSDltB88NdJS/yBDS2wvNl1dr8gFAaUf4hzbhUODcFzXlctjGFidwqc4eeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139398; c=relaxed/simple;
	bh=IkLpGsIIgmZC7jOfAhc+19RODczag08De2HS3ix7I4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHtike79rExfwKpiVu3I+vNiK9XJGy0U2FRd9x8QBXULP854ahP8KImWc3+rx+98C5Kh15bHBRKPRYIka1IkO04JxBodTk1HUdPQ2spDBCNm/5hSQsTo3qGreNUZwL1wM38cEAX/RFpBsTDUEJIqbte/VHUM6lcE9iHYRtgmyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6ul5Lg1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6ul5Lg1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e347638adso585124a91.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139392; x=1784744192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IkLpGsIIgmZC7jOfAhc+19RODczag08De2HS3ix7I4c=;
        b=S6ul5Lg1MF4wTi5N3MR1kazXaYoZ/K7zozwIvTyvUmVc4neJTs+pJeyqUMvcdJhVUz
         iXusm8MKF9mf+9zQmEQYRGa9ye4yrzJsham/I39M1vAI587tj7KQS3w6+2MlLOv264jo
         f27LihmgbVb4dH/TUB8witAm3y1Oou1jeaG9z4BuJlVMMPoBSB4qPQlXz8zZ/eYtrnGA
         cpg/fUwqEyRhX+s/zUYFb+ubPffCkWvVPatDD6HZZEY4KqAtsBE5usPDnY1oGCZ7VVAS
         JGsNCSSx47riYWet0NbhkpWjzKvW91l74dec2PSMAj1ywsRtrXODm5MNSF8oXZsVNHig
         bESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139392; x=1784744192;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkLpGsIIgmZC7jOfAhc+19RODczag08De2HS3ix7I4c=;
        b=BlFRh0w8cype0eGPeoG/uED4NnKiTTj/AS3AJRF78POmezGdW1btpdRgJKTb3dPK/s
         K31mh9GsEpKj9BcxR6/vWToR4ymS95p9qVE2g300sFgMQYs/Y73EXhodIw20aanvaK9G
         wsIOS0BZLRDj5umqM8GtZPnmEdldTESDc+2ZGDbZd/+rHIAEsAf4TdBik/FygaxEOyAL
         G3WRQUnU3IcUwaM0hHP8ndbTRUfZE8vsK/z6XS98X8JAxr5y5jwLs16KlbKw2wMCkZa1
         s2AoZj9iKKDp84c32NNx7Fbs6wdccXcOf+Rvn+mk6svEBQWZPQFmmPAzwRyc+RVM8d7p
         X4Lg==
X-Gm-Message-State: AOJu0YyvpvHyhrYiJLZjCQqlkSporPDSBSFlA/fY9VchWsSqtLkIHiWE
	8DTn18w8k8HzOOtHWux3r12M73nXjsad3EkGjfG7o8f6E5w3YkSJy2XnDDrQvGze
X-Gm-Gg: AfdE7ckd8WYP5UUMih3hUhSZRLvu1IkHQw81ODRJENz2HNi6bSJFSGOQJnfewy10Hbr
	xToP9pdEmoUfroLEbMyd6f1y+x7v7T3RhRYhnHrdLR1MFXpgWI4NdbUkeN4PYSdHUNnUWCDJKUG
	4CfzSASowBQUc/WZF0ACbqnX1QQBUVxrJM+8QAWFON6bYjUcvGDr4ZQ6fVS03py7olIKnjSpnXy
	pY6mdyZdhAOKioLsT/j98VCY4jXz3FiI/utFwjPVb+ldIHaDpLhx0HldZSYgHdMzaLUg7+3cFM4
	/RiF69LBZ8mgJNDq4qb+W/FyMdZh23/sFMISnUi/37eBaJE/1AIkb71Qo9MhyPIsjFyuFDbOmj7
	0wcqr0wOtCrNizYyAxrqnnPGcPPiSZ3T8pBIg6DZoxkhM/oqDVZIh+Lu2P2gl0IAVjqsrl6rnOq
	UYmiOtVIJjUSXCBH8mvrHtQTUlk4RUCLGiyed1kubZIcRflPzaJsU=
X-Received: by 2002:a17:90b:3502:b0:387:df8f:1401 with SMTP id 98e67ed59e1d1-38e2a0c53femr3392449a91.34.1784139391852;
        Wed, 15 Jul 2026 11:16:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:3066:c473:74d2:497d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c08eesm4431182eec.21.2026.07.15.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:16:31 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakroag <gaikwad.dcg@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>
Subject: Re: [PATCH 4/4] fix: release unused ceph cap reservation on readdir error
Date: Wed, 15 Jul 2026 23:46:25 +0530
Message-ID: <20260715181625.18677-1-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <00fbda82bd63f3c7560898531b97a1b061fa6e2b.camel@dubeyko.com>
References: <20260715143646.15828-4-gaikwad.dcg@gmail.com> <00fbda82bd63f3c7560898531b97a1b061fa6e2b.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

Sorry for the confusing [PATCH 4/4] subject — that was my mistake, not an intentional ceph patch series.

What happened: I batched four unrelated commits into one git send-email range. format-patch numbered them 1/4 through 4/4, but get_maintainer.pl routed each patch only to its subsystem list. ceph-devel received only patch 4.

This is a standalone one-patch fix for ceph. I have resent it as [PATCH 1/1] to ceph-devel in a separate thread.

The bug: in ceph_readdir_prepopulate(), ceph_fill_inode() consumes caps from req->r_caps_reservation. On error paths, unused caps were not returned to the MDS client pool (there is a FIXME: "release caps/leases if error occurs"). On success, ceph_unreserve_caps() is called in mds_client.c; on error it was skipped. The fix calls ceph_unreserve_caps() at out: when err != 0.

How I found it: code review while reading fs/ceph/inode.c — not a live Ceph cluster repro. Compiled fs/ceph/inode.o locally.

Thanks,
Deepak Rao Gaikwad
