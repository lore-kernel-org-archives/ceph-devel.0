Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E134041B
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046535; cv=none; b=UYynb/7uWf87Y2nQATJWJYRh738FDw9EWSwT9aYRXPUthT7PRnkBoxrT2/lQBLq0cZ/S7sdC2bsBnJAvF8eqVwZNki3hMnEx2PRIbS1fQLBTZ/n33dqbNhfSJSb/xUbjFGFUb3+Hob+mI/GLNYgDStiN9zKGg2a7c13jd8GFkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046535; c=relaxed/simple;
	bh=pX+m5y4ZEcCljurq/zyNGViSEX11kT9pfSrE6YzOMTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irkzOcS42hoVUB48VmAPOtPaMckOr6N0V0I/ruJoxX/BqZPKwaGNu5MtJ+LcpR50HlUv8qvJ7s+gr0LPMpHcRiodOtoNk7JivZict6i33f//S5z1hWIr9nqYkXDDKFjn7h2luKU/WgJ0cQ0YV9wdEAolxeNcfSXv0K7A2Z1w0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdJ7FqXw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaL5RwTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdJ7FqXw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaL5RwTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792046533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jkpLVpi3m0Sz81GvCVrI49r4+YYcHSPBMxA5YIfFNZ8=;
	b=GdJ7FqXwMVDDeGCgnz6kU0O3T22ePcnuXBDdHH3OGnmAqgGx0+OlOODI9uYjfwBHQ5lKh/
	wojQVCDuj0y43TypqmT6VZs/kibrA2Nd4CTqM5KJrRI+MLpumhjbEkBNpEeWuUxZ44youn
	xT6YCfq9DP1D9LOC+nor9lyRT4GbK7E=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Bp69Kx5dPbqPjm38HFseKw-1; Thu, 15 Oct 2026 06:42:11 +0000
X-MC-Unique: Bp69Kx5dPbqPjm38HFseKw-1
X-Mimecast-MFC-AGG-ID: Bp69Kx5dPbqPjm38HFseKw_1792046531
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so13936309eec.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792046530; x=1792651330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkpLVpi3m0Sz81GvCVrI49r4+YYcHSPBMxA5YIfFNZ8=;
        b=DaL5RwTHyANlB8qLYSQFdRZ2rn/zo4KJe/5TzjAxU2++H4oQ29ecQsfS7VEtyQLCYn
         O3XPiQRH7RJLDCjXjFWHr+FRACHKKaEYgOJWOpIzF0O6SOClgqf1EyRfXtHPsyzR4BVP
         Q4ou0eaEz63PqXf+WKQIlwQBfQOdP8oEd87R2XtYzp8ZXdB+5z4senRjFWi9pSA4hzeg
         488CLBbz1dfjdKGaKmhurflMcrKz7tZDjHIPdFdcZ99YoqoKHfkcpnW3Q57/vt8vUzBO
         Q8uhF2ZvBOgGVf4TuZx4ZPz6XFpCPrao33rVg6sDFBYsJtGqI6RBa+PoL/PzYaSqIADS
         CrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046530; x=1792651330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkpLVpi3m0Sz81GvCVrI49r4+YYcHSPBMxA5YIfFNZ8=;
        b=XYiohiL79uH+vLOY63oo9mPm5aNtlY2Orlr+WP3qgXXcmu5uH5PJCTv2KJIdvwD3fD
         o+p+m7MOKYbSOB2e8OIBYQoc041kjzpKNN115zIVwyaVMdCX2wic/VTsamR1VNj1wVPw
         ZXh1RfnfTzHZwzFWGx5IsHL4AL1bbjLhaP+4/h8XQqpu7bbnIJfdE9o1yYDq36kSxSZw
         yph8hGLLEf10a7zD5avo3sa5f/5ePhsA2T9CarudPA+XBrf47b4/tLjy9NH6reUZHlra
         fmg0dbNulJTCRg+vyyWjYxQQW8b9nA8f66c9isFigjDJ6BlzY0EZmiWIhSGlOl83M8Kw
         bj0Q==
X-Forwarded-Encrypted: i=1; AKwUvBx/HfTFsb76IhGWjgLjTjnH9z3/pXwN61vq4BUEfJvp3fUvjwnACe88Y080rJ2Dli/EkY7DN9GXlflK@vger.kernel.org
X-Gm-Message-State: AFq9FYLPV+W7ltXmCuy+LFuxt/3bZm1JSdgl6z+Plaw6cSQBUB8rVBy4
	Cthh7GhcORuohyAuzvpBmjj/iWFmoFRDPj/aobhHlG2BDk86ZgNnMM6bMHfQChzU1ymL57NAm9V
	AAYe0j9IvMNM/j6zcl6AW29XCpekNad0WD2601JHM51ugxGMJaEnFKsNu23dMRjM=
X-Gm-Gg: AYBFou3aXKyerR7ARzqUD/ihWWLjBgJjjgw79p4EKDooGg6aXQ7uScolBW3sl4Cdk7o
	x/2FKKhfaehozkHGt6SusKXaD54hI7YymqiD87+dZzpXSkveuKmM3HrfO68to4cYOsIe39/rbA7
	ROlmMEa/Lqt9eyBxLJXEHOvAroP0RpS8eFa2nZ/3/5c7Xr00K5N4hiE89nSVx9CQw77os0yB/Ca
	mtj1NZEG/cK2grzOtaCu2mDIH2j6slFWrDuz+bI7ctKw4yD0NdXuAmMdPfJoDVN6MKMBEky7XXP
	9Kj5IwzAvjX1lANy7reGf7kAAFJrOwPzLvx0MyjnJvePpZ9fuCv5J1ccqhKTXAN4mNqy4QmnguU
	ymvEofRn2lPwuC0eStdX02QtNRonlpJLbf6ziNBVT
X-Received: by 2002:a05:7300:2699:b0:359:1b05:ed30 with SMTP id 5a478bee46e88-3591b05ee06mr17112633eec.4.1792046530281;
        Wed, 14 Oct 2026 23:42:10 -0700 (PDT)
X-Received: by 2002:a05:7300:2699:b0:359:1b05:ed30 with SMTP id 5a478bee46e88-3591b05ee06mr17112606eec.4.1792046529713;
        Wed, 14 Oct 2026 23:42:09 -0700 (PDT)
Received: from octo-node-1 ([106.51.46.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm59352811eec.16.2026.10.14.23.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:42:09 -0700 (PDT)
From: Venky Shankar <vshankar@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>,
	ceph-devel@vger.kernel.org,
	Vaishnavi Deshpande <vadeshpa@redhat.com>
Subject: [PATCH v2 0/1] ceph: fix orphaned MDS locks after an interrupted lock wait
Date: Thu, 15 Oct 2026 12:12:00 +0530
Message-ID: <20261015064202.62886-1-vshankar@redhat.com>
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

v2:
 - Use Xiubo's correct email address.

Venky Shankar (1):
  ceph: don't drop a lock grant that races with an interrupt

 fs/ceph/locks.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

-- 
2.50.1 (Apple Git-155)

