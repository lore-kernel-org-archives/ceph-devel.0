Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB5484885
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938046; cv=none; b=pdNXnPv4+dpPtbVKoaxR0DvrHSHvKP0hTu6Sl9/DAiA1/b3ELzlXpdSGt837Jtsa44ANrRAvj2zocbB9M2JuKliFIJIjlougFz59KseiwgA0d3ozH9Gd3TzYrgfUcx7UuHRVzoJrgd49RWMGuKRyym7pAinTn/nqQhe/h8uaEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938046; c=relaxed/simple;
	bh=aETLr0NK64ELZhO8AGj5olYeb89O4c/DWwtsrFhmf7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB9R0bdLIxPXDmTVGW1B1Tq65zYvjCQZpgTIrAuwjthzJO2zQwdhOzFoKYMIxm4RCzATNv5YEAOql55fL6/BY/2KanZticpV+kaaToQfymOYDgkgklJBwhEJ784q3uOnNiBN7U4Ds6mnVm5kLmBGKU6dERtUJj9pQsERXcEHixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXfIpwdH; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXfIpwdH"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso3022163a91.2
        for <ceph-devel@vger.kernel.org>; Fri, 02 Oct 2026 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790938044; x=1791542844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqJvCRNBNKOlLgMiYii5aQHqN/poWkVgXO6J4+/aYqE=;
        b=oXfIpwdHc2bJh+C0V/588X1Y7slM4P0bjTOowp0TVv2fh7PEoJkaVhplttXEQr/wRr
         9bxJen1o5/pkIVi9fcPUQJonYlK+VoW2kTl0/rNiWp4jiB1MVhFiCsCiZ+MYHcWN8cF7
         MPzntUP7rnd/CAmy+G5EmqFY89Gz+uCxj7+4mlx7YIBs46i9vOAaE3aNoSHU8f4kzDqt
         B1+k7yJqIdcLOch1HKuNAhafc60r5eCAnZc7jSu8xSqRgF0WvwAlhNB4i8mxk1tyJuWj
         5TP1z0jb/JOG6qcjADX4lG0HDSpgRTsyPbaR8q9G6z6MuTXxkl9iGUVtvvv77lyMjX9M
         QvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938044; x=1791542844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqJvCRNBNKOlLgMiYii5aQHqN/poWkVgXO6J4+/aYqE=;
        b=XAom87Ri2rDKQXhh1PHBrdVipYjE4ErD+1UrMmCs16aSZcCEjv4McsdSqdGQZM2QoI
         KbUylLiHRwe8kwMoFCsBOh5V4Uz9kl8tJcXnWJrFWzjU+jgZFp2IN0RQsRwkDgfsEhXn
         nZNEilbnoTj5ZScGeh2ACplTyug6ZYWUDxpS7NZYA72fD17REEpvHgwJPF5BsSk9JXWV
         sYlA1jd+k27jRtakPTypnw3HI2IgXvtuXU8vZ2u1WzBQo2sf9WY6fe6NgMyW/TU8h3m5
         Sy7C4t+hahUBB91EoU/+N5FGpkyxuEl3/i7xEXuqEkYNjyurMoHPKcKzLQj1TycmPVFe
         1B+g==
X-Gm-Message-State: AFq9FYKRN16sGOnG0xbO78AdeiFRcDiaYxISz6g1NdvpxYpo9kaablDn
	2YyHFqM/dXnC7nEcI8iYU0aBo9J6yJOoMHGHqfxhOzdP233Fg0jAi/6M
X-Gm-Gg: AYBFou0ZVgo7duBVmUNqBoGb2GZO8WiY7o4JfdX4dCJGaJmlaQ1nGpqtQRT10TNT39D
	icJLzqjJhiKbAELo4xRgVzo67Pexdv6PSq46o9P15Yu9RbagNpkLcR6dnvcTfH03tIY7N+FXs1v
	68v1uZNpVnsGW7tNdkA8kr8ymmMrsD5vwSI5Mvw5WK1VOslGvpcDmdTs1zTlqXJcgSf0s2BA0Ku
	n4HZN2HUNTqwUG8AYa0Qnf3vXxnRqTo7xBGfoIriiOuADkmrGuNQ3UGCZjv1lXvxgOxSRmQu1MM
	6K50SObzDO1EG/bZCkF3Lu+Lqa/ua58lPFd6z1C+wpwUcqON3ozPNuctQ8JWTSdmhI29AHwI2FZ
	y0zsqRvrgvTxDMfRrAhik5i66W/bvrPVwAaJLdobF0JHtcXwKEqMtQ01KZB70A/l0F/zse3gddd
	lBkX9JI1sS+/UerogL4Jp4t3lLYaH/M+tYN6AxV8/d8Y8FPX3MSnNBDV4uGhuUQXuM
X-Received: by 2002:a17:90a:6c90:b0:3a6:d8e0:c359 with SMTP id 98e67ed59e1d1-3a6d8e0c383mr1221762a91.2.1790938043671;
        Fri, 02 Oct 2026 03:47:23 -0700 (PDT)
Received: from localhost ([8.219.156.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f43a12c9sm9268882a91.2.2026.10.02.03.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:47:23 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: Alex Markuze <amaruze@redhat.com>
Cc: ceph-devel@vger.kernel.org,
	security@kernel.org,
	idryomov@gmail.com,
	xiubli@redhat.com,
	vshankar@redhat.com,
	Dairui Zhang <zhangdairui@gmail.com>
Subject: [PATCH v2] libceph: bound sparse-read consumption to received data in secure mode
Date: Fri,  2 Oct 2026 18:47:20 +0800
Message-ID: <20261002104720.2041815-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920174525.1331992-1-zhangdairui@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

You're right - my v1 only covered the OOB page walk, and the
last-page slack could still be read into a successful reply.
Sorry for missing that and for the extra round of review.

v2 now caps against the decrypted data segment (spos +
data_len): any chunk that would pass it gets -EREMOTEIO before
the page is even dereferenced.

From f36217e35ce1a6f0f7c8c0f9e8f8f8f8f8f8f8f8f Mon Sep 17 00:00:00 2001
From: Dairui Zhang <zhangdairui@gmail.com>
Date: Thu, 02 Oct 2026 10:30:00 +0800
Subject: [PATCH v2] libceph: bound sparse-read consumption to received data in secure mode

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

sparse-read reply validation only requires the extents to be
ordered, non-overlapping, inside the *requested* range,
sum(len) == sr_datalen, and each len <= INT_MAX. So an OSD can
send a tiny tail with a perfectly valid extent map claiming data
that was never sent, and nothing notices. (The destination
cursor doesn't clamp this either: sparse_read_total is the sum
of the *request's* op lengths, and the map validation forces
sum(len) <= sr_req_len, so the destination can't run out before
the source overruns.)

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

Reject consumption beyond the decrypted data segment: the copy loop
now returns -EREMOTEIO as soon as a chunk would pass
spos + data_len, not just at the end of the page vector, so it
covers both the out-of-bounds page walk and the last-page slack.

Fixes: f36217e35ce1 ("libceph: support sparse reads on msgr2 secure codepath")
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
v1 -> v2:
- Cap against the decrypted data segment (spos + data_len) instead
  of the page count, per Alex Markuze's review: the page-count
  guard stopped the OOB page walk but still let a reply read
  last-page slack into a successful read.
- v1: https://lore.kernel.org/ceph-devel/20260920174525.1331992-1-zhangdairui@gmail.com/

This is from code reading, not a live cluster.
---
 net/ceph/messenger_v2.c | 7 +++++++
 1 file changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -1060,6 +1060,7 @@
 				  struct page **pages, int spos)
 {
 	struct ceph_msg_data_cursor cursor;
+	int data_end = spos + (int)data_len(con->in_msg);
 	int ret;
 
 	ceph_msg_data_cursor_init(&cursor, con->in_msg,
@@ -1077,9 +1078,13 @@
 		do {
 			int idx = spos >> PAGE_SHIFT;
 			int soff = offset_in_page(spos);
-			struct page *spage = con->v2.in_enc_pages[idx];
 			int len = min_t(int, ret, PAGE_SIZE - soff);
+			struct page *spage;
 
+			if (spos + len > data_end)
+				return -EREMOTEIO;
+
+			spage = con->v2.in_enc_pages[idx];
 			if (buf) {
 				memcpy_from_page(buf, spage, soff, len);
 				buf += len;
-- 
2.53.0
