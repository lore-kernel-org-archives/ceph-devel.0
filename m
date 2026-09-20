Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C429BD8C
	for <ceph-devel@vger.kernel.org>; Sun, 20 Sep 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926332; cv=none; b=AM1+AB9MKWsHy8sne3KznrMH4wMeIykPG0dKbfwGcTa3EFsrwzcjMr4fn+R2TXsqTxAwjQlMGjdQUrk2TZmJOXq79+tL7vdVhgV/XRQ5CvHr9q6QL4nE0Ny0R4VypgAX6cCb0fgj/Bzp8dokFLEyu1LRuWLfL6TRQy/24hFYWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926332; c=relaxed/simple;
	bh=xa5JVFmCgpmm8AxXEJdZYvRaWqCU068LCvGimhspZ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rdsq/1PzqFDkkOhoTuFY90lNrDRA7ULeuPbDQwQfiFl7jhaHinjUOxy7FYg8BAcp3+B37eGJo5YQdKkb2QynhOjWrInn8ZjcfhWHIe2tQo0X33UyZSDKcVqb8DKZGGo6hhrsqG4itXhZS2DJPQQw2DRdeUYzR/HhnEJ6ILYjkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5iO+Sof; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5iO+Sof"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso1613585b3a.2
        for <ceph-devel@vger.kernel.org>; Sun, 20 Sep 2026 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789926331; x=1790531131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOC2BUywJ2njLRlggT8sIgjJBl0URdU7ty3dAKYqawU=;
        b=N5iO+SofqSN3CE4fgwXrnqKwfbDTClGwwlJrKuJ5IdsqmyZ2wcn5LJi96F2uqbNmT7
         rLBdchWmpJsyAlOTHJmh5pS02qf7J6VjLdjYtgTcm/wGY2stqeNWn8BFdEVTXI3inyWz
         RMZOs/R0c6UWh8WMQ+hWI8gv2gwFOzL9t4pIa60hO2Dp5vBmTe4qqbDCB0Zj//P5ijlg
         fqJvBWrjOsomHWfmV1v6ZxMsIjsM/brOXvnzPlNVZGpPslhe04VYRdXZkQlSnTF2wqqe
         M04JDJAhFrBarG1V+qYkSIGLOzHt/0oc5Nlonk1knW5ptO2BKRibBjSnD2lDgtcMg7uJ
         EKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789926331; x=1790531131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOC2BUywJ2njLRlggT8sIgjJBl0URdU7ty3dAKYqawU=;
        b=Mab33puUEYrKNWbd/DGRVSCUBWnxDp9KSfzJznzWWZG7BoQsLYaJEXbF/5jsu5d6Sa
         UrstWEFZOEntPtjdM1Gd5xDkTdyxz2Ztno6qw9yjxT+UurDSXPWLKtaV7f6Auhtu63EK
         i2Md5uQZrNb8c/J494FBACWGkgUnXJmIOrdPbWgp9VCiKmsEeYWEviUrPM9utLuKNEjB
         HmcHuVcybkbyqRKCsEZRSov6OK9RF+8hOdd2LgEIeKlF1V9ZsfGi5OsQvT/XBk6lMHnj
         6ypTf8jsjlgNO4yXq/BpiLQ/a0cSkD7lPc1v4Whzb19ypyBmCHC9fVc0GPD4PfPmPYuZ
         DsCA==
X-Gm-Message-State: AFuF++lIKyHFW+B+aPdGq1MweZs6ErDJj5mZAbl32XtLinuACz6w/Z/T
	DLEOMnCBdckNAxMsD+Aa/e5sH49eArUo14oWYIDNTnE43oYQ5UdmU5Dvq8mxgvEXgFm7MQ==
X-Gm-Gg: AYBFou2W99UpQ7GfkE3w8HAe/bJYwdg1z9iT0CoERQFD4es/JF9XQSonFQ92WMT0LWf
	Oi33Cv/HoYlCIVi0yXw8jFL8exIo8dbFLwlcfNKvAN4SEvuje8C1WJixngLLBUVp9RWHxebkA59
	zTbLEEHejKuxpYbcUjK5vBTXsNtbaY9N663JGKM1DIbJqCEJqwS0Om/BBT5xq4h3zIq5UJ7F24N
	Hw2RUYUSRPGZ/lj14zh9JCJqSGllk3+q+o3I1Toh61vmvGH0A2nwRs3aeF7G2covf7GLR0/oC/e
	W5/LRWHZFc54a+LTcErR+yFohBsBrHGSo0bXyycDtSXwBapeLBOOtDyPeOCzE3cbr8nNNowBetw
	VHj9GW7Ge3YJTFsieoMPOryGuEIvY7IstAPiswN8n26D/EiiTxBZg+c5BgkfRkpqsFOyZk4rGgy
	jRZ6ls0UWyyrIiC5tq8KGV6kPVhK7wZIk3OTwQqqmD6DDSV76hhuM+RE/rMCL7mCCPnZKb7+UB
X-Received: by 2002:a05:6a00:3e22:b0:851:8394:1696 with SMTP id d2e1a72fcca58-874dbfee622mr12674545b3a.12.1789926330771;
        Sun, 20 Sep 2026 10:45:30 -0700 (PDT)
Received: from localhost ([101.126.86.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6be0d58sm2086524b3a.7.2026.09.20.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:45:30 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>,
	security@kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Venky Shankar <vshankar@redhat.com>
Subject: [PATCH] libceph: bound sparse-read consumption to received data in secure mode
Date: Mon, 21 Sep 2026 01:45:25 +0800
Message-ID: <20260920174525.1331992-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In msgr2 secure mode the whole reply tail is read into a page vector
sized by the preamble-declared tail_len:

        enc_page_cnt = calc_pages_for(0, tail_len);

tail_len comes from the peer: preamble parsing only enforces
fd_lens[3] <= CEPH_MSG_MAX_DATA_LEN, and for sparse replies the
data_len sanity check is skipped entirely (osd_client.c:5458, gated
on !srlen).

process_v2_sparse_read() then walks that vector by server-supplied
extent lengths with no bounds check:

        int idx = spos >> PAGE_SHIFT;
        struct page *spage = con->v2.in_enc_pages[idx];

sparse_extent_map_valid() only requires the extents to be ordered,
non-overlapping, inside the *requested* range, sum(len) ==
sr_datalen, and each len <= INT_MAX. So an OSD can send a tiny tail
with a perfectly valid extent map claiming data that was never sent,
and nothing notices. (The destination cursor doesn't clamp this
either: sparse_read_total is the sum of the *request's* op lengths,
and the map validation forces sum(len) <= sr_req_len, so the
destination can't run out before the source overruns.)

With a malicious or compromised OSD - the same model as
CVE-2026-89657 - the copy loop runs off the end of the page vector:

  - past in_enc_page_cnt, adjacent slab gets dereferenced as struct
    page * -> near-certain oops;
  - even before that, ceph_alloc_page_vector() doesn't zero its
    pages, so the tail-page slack is stale kernel memory that gets
    memcpy_page()d into the user's read() buffer every time;
  - if a wild page * happens to be dereferenceable, adjacent heap
    keeps flowing into read() too.

Plain (crc) mode doesn't have the problem - it pulls from the socket
on demand and bails with -EIO past cursor->total_resid.

Trigger: cephfs with ms_mode=secure, sparse path taken via the
sparseread mount option or fscrypt-encrypted inodes
(fs/ceph/file.c:1079,1541). I didn't check whether rbd issues
SPARSE_READ, so no claim there.

This isn't CVE-2026-89657: that one validated the map against the
request range to avoid the BUG_ON, it doesn't cover the secure-mode
supply/consumption mismatch. Unchanged in mainline as of today.

Reject consumption beyond the received data. Guarding idx covers
both the metadata and the data copies.

Fixes: f36217e35ce1 ("libceph: support sparse reads on msgr2 secure codepath")
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
First time posting to ceph-devel, and this is from code reading
rather than a live cluster - if I've misread the messenger flow or
the guard belongs somewhere else, please say so and I'll respin.

 net/ceph/messenger_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index b323b61..c677ff8 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -1077,6 +1077,10 @@ static int process_v2_sparse_read(struct ceph_connection *con,
 		do {
 			int idx = spos >> PAGE_SHIFT;
 			int soff = offset_in_page(spos);
+
+			if (idx >= con->v2.in_enc_page_cnt)
+				return -EREMOTEIO;
+
 			struct page *spage = con->v2.in_enc_pages[idx];
 			int len = min_t(int, ret, PAGE_SIZE - soff);

If there's interest I'll follow up with two small patches: zeroing
pages in ceph_alloc_page_vector() (closes the stale-page leak), and
a KUnit case that feeds a short tail plus a large extent map into
process_v2_sparse_read().
