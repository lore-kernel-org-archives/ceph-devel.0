Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863144605B
	for <ceph-devel@vger.kernel.org>; Wed,  7 Oct 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363417; cv=none; b=nDXWScfGJ2QOJE2G0yRMg8dIVECn2s56Ma9mtVtKSCCCcjNc8bBatscDM1XxU41lHBwNbdpPGaEdOKz5Ul9zLPBrpHIjbjd7Jd7dxuf0tYzyVaeKKZ+Ei3QGqnu9HZ16098xg+si5guVd4v0Qp8/s8vE4IeiB/SSVpB/pfSH95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363417; c=relaxed/simple;
	bh=CNda2smNNNhYJPIoytC7arHWFFvehAxjoj27Zs6/nmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ameTBhVxgmTsZ/oEy5EaB+BvPrV9QnQxD+dSETVeOSkOeem7jJ1v3G2u9lzP+T5qzwI7jrS3+L8TqCVhCcLnjQyTEYaOl2Zj4KwGfvr8pUYmNPulkdyCt2WJXPR6nY/+HWQwCLkhjPMRZzOYxm4+6WHuummAdJtjJeRhEp7AnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMTyHOx1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQUm9zM5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMTyHOx1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQUm9zM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791363415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HDPGaf503ff1q7ctXjJ0Yc9Ce1qX7dCNQug+Ym7BZNs=;
	b=ZMTyHOx1BRpBo91uk/NiVsnOHqva15bs6qWcHx4VGRDLwhDKTmqJrUoqs6h3Kw0JtG30Pf
	QGqI5prVyjH7PuXofYtr3rZMW7CGwMMTF+P+56PnGqN8jr1FwoiWWmSVASTK5CIIciAkBD
	qLXdWVPAZWoWu781005/MlMEMLoGM/M=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-WtTYyaAqN1uDUrJ5UZQAJQ-1; Wed, 07 Oct 2026 04:56:53 -0400
X-MC-Unique: WtTYyaAqN1uDUrJ5UZQAJQ-1
X-Mimecast-MFC-AGG-ID: WtTYyaAqN1uDUrJ5UZQAJQ_1791363413
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so5071581eec.1
        for <ceph-devel@vger.kernel.org>; Wed, 07 Oct 2026 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791363413; x=1791968213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDPGaf503ff1q7ctXjJ0Yc9Ce1qX7dCNQug+Ym7BZNs=;
        b=dQUm9zM5kc/hi3r9rKw/cqv1BHodgpwIOqXOCnaq1Heb3bK5GRHVhEvRTE5jMHdLgw
         gpYehYNqByRZPK9QW8jb2QpBYDxG+1Nr28ukEWMcum6eG/ifwT8aufytWXkko3X2tcOH
         6KTR2UO5USmeDhJ/CAwgFDu4GY87HSMRTgN7U5/cYGoOsSuX8236R9zKlQ6aiRJbCZxb
         p6kVHuJnZWW4Z+kCwj9a00Zh59tfxkF06sLliK7gcaVaFinaa24ius8yutkHgN7uJnR5
         KQ8C5Yl61nupD6+rxKTqIgpxMCTIH9hSOjfrfsKKd0UUF0y4NRtJMHLmMluqiNiSM0Lz
         WKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363413; x=1791968213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDPGaf503ff1q7ctXjJ0Yc9Ce1qX7dCNQug+Ym7BZNs=;
        b=Dz3P5+Hj+Hj/6gOD2WVnygJOB/VS/Ww47GhqyHyXSEncEVMFqH5Ui1skQzcR3XI5XH
         VOARpaMzOtDa+GZ4m7FzQKBxtQ1FgsEypum7Ub5VuxrSWX2Okm4+4UFOXdbpGv0aHpTP
         kx23ThN1BKWzlommq5EUP1cJ/XTizsMit56i3drPU+CWzpIFZQo4bciDv9NCeL11Hvu9
         rFdeGw7nZc09qfICBIcULpVeN9pGy7t0fJWjMWs/H+oFgj5hQGf9B/LN+fkeKA29DVhr
         HQoG1bfnSg2j3YiJqlLL6HNyn9jzdYxawgObS60cLdvPYzjGHb0ldcSjAdwHUmOcoSLK
         IXNg==
X-Forwarded-Encrypted: i=1; AKwUvBwdp/YRZcChHpI0gjJuPxftxWKhQD8qhKqqR6VrP6jV01b5P2r77U4divqdeXUgGOhP2VMYZfLSzI3X@vger.kernel.org
X-Gm-Message-State: AFuF++kxwXCNZoLGQShxyc+pkUAEGaO1i5y7ybr7WH+aXQk8wMbIknMb
	YFdD3sDrTM/GB5Y6+pTtE5rqWLVWmdYJv3j97RrF0xoffg36Etq3g9PEM6G4zqFz83rZ7PGZ7Y9
	Cv4U6kdWbmrYRFKP9sg5cs+aWyei1gqZMoyQE0JDGfE3D0AHef/EqUdfh/Baa//0=
X-Gm-Gg: AYBFou1EyQZMsipTJB4BywM3Cs53lcvBSCx8cIC/43Jn5WHDZvIYm2UKkLY70Wf2415
	h3pk8HdAr49vKvwsqolf0zrhczaQeDXp6MyiSkjrksDnMM1cls6E2vZsQxVUPT9lE0L8e4p+c/h
	EVu9gTzgQbiGN4GYYNepECIh/PlFgPkx/aVkHEkz29Q8etV0ZY7NjpLxhoBfqnwVxP7WimY1m+7
	zF7vRm8o2jQBiYwbxU3dkAalRR4P4d5OLr6yF93/Ir86LOU3dArbv/nhwn/EUXTCW8kJAh6year
	2G8dTqnsGy+Sy0o6qHaeD645Y9FJxuGfBRoVH4tKTCc1CRufnV+YZMI/W0YpW22vt1iu3TletvJ
	E3G+S8lJ9Sg3ydZQEkQdmYuQTnDyi0AByTl7wnnT6
X-Received: by 2002:a05:701b:21ce:b0:14a:51c8:ea06 with SMTP id a92af1059eb24-1620693f045mr1475440c88.29.1791363412418;
        Wed, 07 Oct 2026 01:56:52 -0700 (PDT)
X-Received: by 2002:a05:701b:21ce:b0:14a:51c8:ea06 with SMTP id a92af1059eb24-1620693f045mr1475412c88.29.1791363411714;
        Wed, 07 Oct 2026 01:56:51 -0700 (PDT)
Received: from octo-node-1 ([106.51.46.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16352800ed6sm1990624c88.9.2026.10.07.01.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:56:50 -0700 (PDT)
From: Venky Shankar <vshankar@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Xiubo Li <xiubo.li@clyso.com>
Cc: Venky Shankar <vshankar@redhat.com>,
	David Howells <dhowells@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: [PATCH 0/1] ceph: fix -EAGAIN from buffered writes racing with snapshots
Date: Wed,  7 Oct 2026 14:25:58 +0530
Message-ID: <20261007085601.195793-1-vshankar@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffered writes on a CephFS kernel mount can fail with EAGAIN
("Resource temporarily unavailable") when they rewrite a page that is
still dirty in an older snap context which cannot be flushed yet. We
have been hitting this in CephFS QA (teuthology) runs that take
snapshots while the workload is writing:

- kernel untar/build workunit, failing in the final link
  (ceph-client testing kernel, 7.3.0-rc1-g7f77d684f595)
  https://pulpito.ceph.com/vshankar-2026-10-07_07:40:54-fs:workload-wip-77519-trial1-distro-default-trial/613906/

  2026-10-07T08:18:00.721 INFO:tasks.workunit.client.0.trial024.stderr:ld: final link failed: Resource temporarily unavailable

- dbench workunit (stock distro kernel)
  https://pulpito.ceph.com/vshankar-2026-10-02_21:48:19-fs-wip-vshankar-testing-20261002.175142-distro-default-trial/602723/

  2026-10-02T22:35:02.642 INFO:tasks.workunit.client.0.trial029.stdout:[483386] write failed on handle 10895 (Resource temporarily unavailable)

Tracker: https://tracker.ceph.com/issues/57656

When ceph_netfs_check_write_begin() finds the folio dirty in a snap
context that is neither the head nor the oldest one with dirty data,
it unlocks and puts the folio, kicks writeback, waits for the older
snap contexts to be flushed and then returns -EAGAIN so that the write
is retried.

Since commit fac47b43c760 ("netfs: do not unlock and put the folio
twice"), netfs_write_begin() retries only when ->check_write_begin()
returns 0 with *foliop cleared; -EAGAIN gets no special treatment.
That commit converted ceph to clear *foliop but left the -EAGAIN
return in place, so since v5.19 the error goes all the way up to
write(2) as soon as the wait succeeds. The patch returns the wait
result as is.

Reproducer (single kernel client, snapshots enabled), in a directory
on the mount:

  f=file
  w() { dd if=/dev/urandom of=$f bs=4096 count=1 seek=$1 \
           conv=notrunc status=none; }
  w 0; mkdir .snap/a   # block 0 dirty in snap a
  w 1; mkdir .snap/b   # block 1 dirty in snap b
  w 1                  # unpatched: EAGAIN

The last write finds block 1 dirty in snap b while snap a still has a
dirty page, so it waits for a to be flushed (~10ms here) and then
fails. The dirty pages are not written back on snapshot creation, so
the default 30s dirty expiry leaves plenty of time to hit this.

Results:
  - unpatched: EAGAIN on the first iteration
  - patched:   50 out of 50 iterations pass

With ceph dynamic debug enabled, the unpatched run shows
ceph_find_incompatible() reporting the folio as "not current or
oldest", writeback completing snap a's cap snap, and the writer
dropping its cap refs right after waking up instead of retrying.

Venky Shankar (1):
  ceph: don't fail write_begin with -EAGAIN after flushing old snapc

 fs/ceph/addr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.50.1 (Apple Git-155)

