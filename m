Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4940BCDF
	for <ceph-devel@vger.kernel.org>; Wed,  7 Oct 2026 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363425; cv=none; b=Ur4gDeAc7Y8hrQKZ4Ek7JuwkznzPbsXlAbxpe+R9+Rw9ePwGnB4mQu7P4Q1zPkHf+1rz+Gp4L7n9KflV9/BMnSkXMgmlMPTEhEidoJfBU5yU/0ag8XNBn2qNz/yWaZdx7ZIEWsYx2l/cH8fdretBpQMdfgxmo3uyIGW17cw8rZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363425; c=relaxed/simple;
	bh=DiWfcUay9/naEinEFQ0kzHZ7dChriVW9Sex6dn18Yjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C66qDmMBDvnhDBK6fM0hEjcJVVU0qaBs09YZyOaXtxq1XbGZ9c/LSfD/KkGbh3a6kq/FzL+2qoc5QpxpKytzdw86LDR3Y10MsUfISs1Osg3l8LEfIbzElN34kdKOSsX3x6LksfgDoHDcHtf1OGc1DTFua99yI0/MwEegSqdM12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3uTL03M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=khE03Yv+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3uTL03M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="khE03Yv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791363422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsjuyMNzz19I1jFJWi1hac0nH86YjbAGOc7cxxOV7XQ=;
	b=D3uTL03M5PetLxwkV9TF10qcUhA5zg4jpOpK1x+rD5L5nycEd7Vo3RLq2bnvHilYGda8kN
	vzSfMS8gtvo3eI5E/FJYIqsAKN5wDJEFU8JfQp6BKdBGoZd6dm36ciFD2LpICeoms0uDM8
	UtHNPRmhZSutQyC1dkGZsWgtkFrHZlc=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-zJ7oPV0BPr299-Pt7dzEHg-1; Wed, 07 Oct 2026 04:57:01 -0400
X-MC-Unique: zJ7oPV0BPr299-Pt7dzEHg-1
X-Mimecast-MFC-AGG-ID: zJ7oPV0BPr299-Pt7dzEHg_1791363420
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so14105570c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 07 Oct 2026 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791363420; x=1791968220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UsjuyMNzz19I1jFJWi1hac0nH86YjbAGOc7cxxOV7XQ=;
        b=khE03Yv+E9GE+U8qKtTTjVGA/kL/Wq1Q7rBFLcwv959PJ5ChvFTcI+faQWZGY/6TKa
         BXQ4lWjp9yybQ2E7pLtvZHGrWDC/KzKmkEFVtLQuSi4+K+HQ8BLQEX5Nva8zlTohjtJl
         BO1gNZ9gKXJgw9Hgf5O4PiCIku4NYqT9ACu1zxo2OPG7a89TEv2AisuzRUa79Wuc5Scm
         20COLxne2eeCSy2lTksRndgbfhA/u9IUVvNFPKXG2RUvGqsD3frQxUd3gobwbkZF6R1C
         KPufGmA4IxaJquVJLe9EHjih8uRBrHpNjEtO3mytgZ4eCDLFug/6mB8QHwC4zPH4oA6o
         SfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363420; x=1791968220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UsjuyMNzz19I1jFJWi1hac0nH86YjbAGOc7cxxOV7XQ=;
        b=Lh6ePrWocjjei6BdC5h6C6mLNFCdpN4wdu8u2XKBJydtwAumB5HwYrhDSK3JdXR3s0
         igLRLJmhd5MGq1M1Tfm2tLMPYLVAYAyfrsuBkxc/ip9brqWxBbVn/Cl03rgEQz1pTI+i
         213q0f6PRhbAGVMnI8tdvAlHP+lNIY02c2HaJAyQSXGTrMDYCrikifPRFzUozPam6Bo3
         +zqnNBTa4i4bB2ivBMi4jFTCESU8fzhjQbaJlCHCfHgFn2XxJ2ydzbqK1yYVjd6jYXmn
         3TrsxpNPxCWhy89I838LReUF+fZbTVBXRh2myIIADjttt4s3N3yWIAq9cdTq15P90TYA
         hg1w==
X-Forwarded-Encrypted: i=1; AKwUvBxRm69XWsqdqUr4dzhr9S1JvPWAES5gWatj43k21p9Dzp4KfGvmZk1Sk0Al7TlbSlOI09At8EK020go@vger.kernel.org
X-Gm-Message-State: AFuF++k8DNBeQOUbpJUlQnw5Qw7eryOMdNjHL7iEeiyt8xe2BfVBl/JF
	GMIBgMSSW5KzND4DH20WZOg+3lfYkLVUBGSkCh7OeWRqe8feP7o1S6ymSOVbf6zG2CBabi+4xVb
	qTy+X+j6hqDYqKHD5TLZw5kTj80MxIHqceLb47aV/wJ1XQBnLQJDqSOYCeJddqnw=
X-Gm-Gg: AYBFou3NTsq0w9Yu2x7bT7QZaj1Qf8cIaLW6k/JNghHMOyewDIQ1NRrrlmsaVDZl5CK
	IDUc3o9B5GauUHPwuOjig7fT2tNCTvX9Gy8V0rRkjDUBS9B95Tfj+stoqPFll9OlFPlEZ5M1PiN
	n4ke0nuJG9Cgy+Ydr2EwlsuuAkaAffJIgXQIxaXM8C0Aoh3nb2eVhfsFCj9Gq0RnhofzIeGUlH1
	5DdFh6HOyY+AjDm/cHU8pE3eOOLiRUbXMlEmENDPq2slxKK3itmM+wsh4jKh9KqN1obc/ZexwfU
	e9a1h0fLMT+hgQtW2ALC7usQ7LpwwCaiPisvWugqVhyMKp8P4Ih8BFistNKamv0jG6gibbjYc6s
	E4djoIXoCEJR1vuAjnEXwwam9NHcsR8RML+21ATcu
X-Received: by 2002:a05:701b:2706:b0:158:7ea9:4a76 with SMTP id a92af1059eb24-162047a190cmr1603266c88.16.1791363420106;
        Wed, 07 Oct 2026 01:57:00 -0700 (PDT)
X-Received: by 2002:a05:701b:2706:b0:158:7ea9:4a76 with SMTP id a92af1059eb24-162047a190cmr1603236c88.16.1791363419570;
        Wed, 07 Oct 2026 01:56:59 -0700 (PDT)
Received: from octo-node-1 ([106.51.46.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16352800ed6sm1990624c88.9.2026.10.07.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:56:58 -0700 (PDT)
From: Venky Shankar <vshankar@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Xiubo Li <xiubo.li@clyso.com>
Cc: Venky Shankar <vshankar@redhat.com>,
	David Howells <dhowells@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: [PATCH 1/1] ceph: don't fail write_begin with -EAGAIN after flushing old snapc
Date: Wed,  7 Oct 2026 14:25:59 +0530
Message-ID: <20261007085601.195793-2-vshankar@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261007085601.195793-1-vshankar@redhat.com>
References: <20261007085601.195793-1-vshankar@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ceph_netfs_check_write_begin() finds the folio dirty in an older
snap context, it drops the folio, waits for that snap context to be
flushed and then returns -EAGAIN so that the write is retried.

However, since commit fac47b43c760 ("netfs: do not unlock and put the
folio twice"), netfs_write_begin() retries only when ->check_write_begin()
returns 0 with *foliop cleared -- every error, -EAGAIN included, is
returned as is. The -EAGAIN thus propagates up to write(2), which fails
with "Resource temporarily unavailable" once the dirty data has been
flushed, rather than being retried.

This is easily hit by buffered writers rewriting dirty pages while
snapshots are being taken, e.g. a kernel build linking vmlinux into a
directory under a snapshot schedule:

  ld: final link failed: Resource temporarily unavailable

Return the wait_event_killable() result as is so that netfs re-gets the
folio and retries on success.

Fixes: fac47b43c760 ("netfs: do not unlock and put the folio twice")
Link: https://tracker.ceph.com/issues/57656
Signed-off-by: Venky Shankar <vshankar@redhat.com>
---
 fs/ceph/addr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b4ea5ed..dd2bd8e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1982,7 +1982,12 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 		r = wait_event_killable(ci->i_cap_wq,
 					context_is_writeable_or_written(inode, snapc));
 		ceph_put_snap_context(snapc);
-		return r == 0 ? -EAGAIN : r;
+		/*
+		 * *foliop is cleared, so a return of 0 makes
+		 * netfs_write_begin() grab the folio again and call us again
+		 * to recheck it. Any error (fatal signal) fails the write.
+		 */
+		return r;
 	}
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)

