Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765E3EF0BE
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045769; cv=none; b=r76739gx+GvMBSqJlcRj37pcqO8aHGBL91IbEp7FQaMkpXvDmUqbe/VW4+DgwjaaV/QHDez0DfX9p6Wbw2prg7neH28kCyZ6NN82a2FYxPFpMq17iMuz/BTIoXBJ8gX/gx+ySwGYVzSXUHJhjvKoM3hPwnC0tWVQQ0+SbG90pI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045769; c=relaxed/simple;
	bh=kvNHJ2rUpnmteYQQxjHRaXxPjhN5i/KKouhe6P9fj4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aB0Zf0J1oOJhMo4g2RNBT27VJM+9qitBTyV3bqZpIANyNlPimeO/2OBcST641ea+z3QY0KoSril9e//oqlrFQDNlg/UBpzsDmaDY/ZX3kCD5bNQUcX3FO86394pisjSbiDbDcl1ULVy0qc4dE6B6IA7ABr5ghQ3d5XDJ/YJWj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BH98aWVX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fe1EG0r1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BH98aWVX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe1EG0r1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792045767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hG1JfUkIYqAIMMWt/5Z1FtCmjE4Z4GnquQ3c4ziXUsI=;
	b=BH98aWVXqrrGBfFL+4GzQyln9CYr+ztuGJoK3KzjUnVmpwPC2rmQd2FtclmtmG934YmADw
	HobqHhcJ1pjmCWCsv6CTVPVyf7FKl3gKsQBvY8GPnn4KMi77wEb9ROPeRyb4auOQbQ6fF3
	ASUg9Ij3yAEsAeIVbcM0RnCFsn/4ibA=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-D7lywJh0P8qLm_6ZJaLAMw-1; Thu, 15 Oct 2026 06:29:26 +0000
X-MC-Unique: D7lywJh0P8qLm_6ZJaLAMw-1
X-Mimecast-MFC-AGG-ID: D7lywJh0P8qLm_6ZJaLAMw_1792045765
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510d0baf63so5696912eec.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792045765; x=1792650565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hG1JfUkIYqAIMMWt/5Z1FtCmjE4Z4GnquQ3c4ziXUsI=;
        b=Fe1EG0r1yclmz/Aq3vHLqVwayeys4QL0mzZzwXXxxAXsuBbXIDYT7qO2dPIbLR435U
         Swe20IWmXs2bskOaTK2/aBFF/rlpdr7Ukj/T8OJMEb6RWPKIbIo2M6B+R1b32tSryh7l
         dhHHN83S7IGQW6TvBiZnsT2ZRO4vLs/z6xkqkcfjoA75tLkj9wLW+PFeGOlS2XVC2+7Y
         2RXWHfYekwN6CQhAfEVkIv235u9XiKt8/rBKZtJ2bVNibrB2GRgQgas84vKz12/1Dv0f
         DOSPZzDmj33XFdXoFvjNl0CkUodVHAmzrioI5nx9d/JBPtnc9vXRzShDLhwfC5rblpLf
         B0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792045765; x=1792650565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hG1JfUkIYqAIMMWt/5Z1FtCmjE4Z4GnquQ3c4ziXUsI=;
        b=XJRzcRiYCjRypVJ7lWiHTbw3QrFmzW94YU2JrmxHEPQs3O1qhI9XOgZvDfu+p0eubI
         /VARmfL5FPbpZFMicUzxhMo1YFauidCmCNCFhuRPsT2Xn4PwQjKnlSnf882rCmrK9UlR
         FrHzVe8JzzEdFsWQK7qIeelsVGeGMlmHuX/hlYCaP9RI/dshv63aX6M6htXojxAe68Lk
         mKs4YR1qs9p6lNHOWfg727gwdNkqoEV5YloAzOvChm3aDOv5MM/ghuESJBX5xdwoVISc
         brvhli5+X+N34L/9+bmvvpfxnbHhRy1ewkxu35uXMuUTXOOAmwjLXfX5kO78TlY6tvzn
         1u9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwMEpsWYk7gVOQKesoFArIq31ilRFaLp09qJEwssInUF+YZcAM7lq+pWlF+PNskQpLqfLh0WoCGotmr@vger.kernel.org
X-Gm-Message-State: AFq9FYLZybRWlov05G9lAVhK5HKFgs3xm9ggHEJaNyQHDxWSYZv1/Dyb
	kx8YeddQSoRrDrvg2gAm93clomvLhBKB4hdb9BMGbQlvN365UT/QJaYI9R7EjZbEHzlKdJyqG+M
	I8hVrO3iuKzfjwoM1QjtKs3umsFfW5O/2fcc92o18ZB51T6xCXnRVuN1gsu0ORvw=
X-Gm-Gg: AYBFou2jIgAgGAQnj1oA6Sw3/Z+X2/a3a/IVpqoOMRD4Cb5stZ4qEBmetZgK6tZ77zq
	ReHugDhsah8T77TYAHZJKmfCha4UCU5rplQ6+Huhel6pFXzhf6u80kuYrxE00ktnp++wSaULfoL
	5mcJG7/t8zqZej2L0p1ofS9bT2LphEpQvn8AaTWNfT8eUrFM05Kvp9oHznuTI2qFaK3uv1zzf2E
	r9oAb0cGtOgUfw7/gSlRFuHaJZaagWRrwnpF/nyTiLmfTcwW3QmqA63glGtOOQvRnukZ9q/LvAF
	pyQmij69G1w3GvzV/CA1kepzKkjUrulCfIgOImkSTSlhqxbnEjeKFf1/Aoz6VdhuenR+mHx3P1C
	TGDGp280PN0H0s0rEIIUPCJKtChzKL/h7Asc/zpZv
X-Received: by 2002:a05:7300:10c:b0:35d:e49e:74ec with SMTP id 5a478bee46e88-35de49e813bmr5384825eec.41.1792045764668;
        Wed, 14 Oct 2026 23:29:24 -0700 (PDT)
X-Received: by 2002:a05:7300:10c:b0:35d:e49e:74ec with SMTP id 5a478bee46e88-35de49e813bmr5384798eec.41.1792045764029;
        Wed, 14 Oct 2026 23:29:24 -0700 (PDT)
Received: from octo-node-1 ([106.51.46.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm69422337eec.14.2026.10.14.23.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:29:23 -0700 (PDT)
From: Venky Shankar <vshankar@redhat.com>
To: Xiubo Li <xiubli@redhat.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>,
	ceph-devel@vger.kernel.org,
	Vaishnavi Deshpande <vadeshpa@redhat.com>
Subject: [PATCH 0/1] ceph: fix orphaned MDS locks after an interrupted lock wait
Date: Thu, 15 Oct 2026 11:59:05 +0530
Message-ID: <20261015062907.62038-1-vshankar@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A process blocked in F_SETLKW or flock(LOCK_EX) on CephFS can leave a
lock held on the MDS that nobody will ever release. This happens when
the process is interrupted (typically SIGKILL) just after the MDS has
granted the lock, but before the client has processed the grant.

The kernel client marks the request aborted and sends a FCNTL_INTR or
FLOCK_INTR request. The MDS handles an interrupt by cancelling a
*waiting* lock only. It deliberately leaves granted locks alone,
because same-owner POSIX locks merge and dropping a held lock could
take away locks the owner had before the interrupted request. So the
MDS keeps the lock, and replies 0 to the original request. That reply
arrives for an aborted request and handle_reply() drops it ("reply
arrived after request N was aborted"). posix_lock_file() or
locks_lock_file_wait() never runs, so nothing is sent on close or
exit, and the lock isn't sent on reconnect either. Other clients block
on it, or get EAGAIN, until this client drops its last cap on the
inode or the MDS restarts.

The patch stops aborting a lock request once it has been sent. It
still sends the interrupt, then waits for the MDS's reply to the
original request. A reply of 0 means the lock was granted: it is
recorded locally, and the exiting process unlocks it as usual. A reply
of -EINTR means the wait was cancelled, and becomes -ERESTARTSYS as
before. The wait flag is cleared too, so a request resent to a new MDS
answers at once instead of blocking again; -EAGAIN from such a resend
also becomes -ERESTARTSYS.

The cost is an uninterruptible wait for that reply, which is normally
one round trip after the interrupt. If the MDS is down and there is no
standby, the task stays in D state until the MDS recovers. Other
options are a TASK_KILLABLE wait that sends an explicit unlock if a
grant turns up later, or doing that unlock from handle_reply() for
aborted lock requests. Both are more involved, and I'd welcome
opinions.

Tracker: https://tracker.ceph.com/issues/81697
ceph PR: https://github.com/ceph/ceph/pull/72723 (qa tests)
Reported-by: Vaishnavi Deshpande <vadeshpa@redhat.com>

Venky Shankar (1):
  ceph: don't drop a lock grant that races with an interrupt

 fs/ceph/locks.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

-- 
2.50.1 (Apple Git-155)

