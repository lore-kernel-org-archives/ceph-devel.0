Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA4263C8C
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801481; cv=none; b=K2HoYnsxGf9j/CM9kmG4xZegU8tiPTeME6SCrWiFh1R5mrsuZXsUcNe/zl8lwPqhb5j7776E6kwpR1Ks8UPUDmQCLoiSd1old2eF2UiCZZsUrOMmzdpHVrNzBI/sJDOknGjIY5e1s9OSrICIb/ss61hQGEKj6xZUOd1PgIO3kZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801481; c=relaxed/simple;
	bh=n0w6e/nOGgYAcidng5lDiAq12GtXKpGxxsbG7TpMjxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3nmIS3t1YqHSXMGUNaMk9Pa8WtgVAIzmXjjTGg8+tiUty1SrZ/JNWMn8hPCi31nXzSrHk/LG54NsabVmD2CGPELAt6KdbteZA1VsMRzjVygh2Eh+TbBdcUPVgp4oMXUhu5OZLvvMKQG5uDzTAK0D5Krk6Nd0wA4wFBue8n1Q4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uaw8Yzqb; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uaw8Yzqb"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7c5b8cb24so701544a34.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2026 19:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773801479; x=1774406279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHBZTmx3gpGoOcOvI5wr45XrMLqrJh4cbl+ScbRtWNE=;
        b=Uaw8YzqbmszcT7KbRQpAqaawKS3M3JDNRi5ZGai01YXZf8xpha/3Ugs84HZu7NJSI2
         KakJ6579ALRu2QoRmdeqkVh8QHqDWG2++ZZxr9vph7qOkVz3I2ysGw20F/qEgcYRK24T
         iS+oSZuW5IYr/CFd9LKEAxh+qHk8nu7dEA7X++MXEFNyeUZUJ0iASz/KyXicEwjaMOJs
         Lvtgmp/fAJq6JOMjTtgEHrOfYrB/P4nbuCzDfzzOZupVn9vYijtc20U1WuEjL0QEh4ph
         tvGu5Io/9HUb9ZlMcE3PxBnVwUefpY0+aKEBEwe9BkdfuwGheK3ZMBuxzAtAIQrUVfiD
         Wn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773801479; x=1774406279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHBZTmx3gpGoOcOvI5wr45XrMLqrJh4cbl+ScbRtWNE=;
        b=E9UN9QPTbmqqibgLvUKGYkct33kukZJVBfwoZxi4wdgT0O8Zvwn6u4/LCD3lnH5DVu
         XUfiJelB2RwfYBbfSkCCNhMJgPnRT57UE016xQQpV58/ABiHOwl7aq6kfWMwG5U2c3KR
         8AOWEPW4eg4rqwPxXQWEe7CL+MgGgYYXEHCJOAprjV0PQBa/bj9V99T1pQGUO+rXtakD
         17sTLIqV1GWxYnvPm34ma6be/vcCCjUjApa3U2cYeviKMya050kgQu7+HjQKOvxk1W7Q
         2wujGDylyRkpc9EFJhPWIwhjqAoqiOogXR38W6jHETYJDkzTiJchJxhhR+tMiNT3ei52
         QkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUCBVotvplmlmTjwTBd567i/Y/BM4y4VnXAPrgvshM2VHQjg6fSTyC9E3NpoLheFVYHbsAXhLZ8h1S@vger.kernel.org
X-Gm-Message-State: AOJu0YwOaWb2Itd2up4Wxip6Tp2DAgseHnmgqmTlCgBR670xK7xu1/Xq
	CtLNFzul2myccQbUQar4mfjdGvlY8m3248AATYxCPk9ZhL0oQuEjYj4k
X-Gm-Gg: ATEYQzwi9JyyifuMgl7V1CpfyZcpb29XUKdqPJ53cvZmGqNjujRnCFAn63XHJHNidG9
	9b+mfkZm5ilbKjwg9imUuGrc5X37YGcdEoIeRvftNqfE88ezyN4BWLRNovj5t8MAa9dA8m/ZfoX
	pJZZjXrUe8M2XCM6ZcwaQ01lKj07TEM/4FByG6dVz2NTTe8WDL/k4t/tCidH0SdhihmavtN+aqu
	3NNDMc8PsBSHRTVJyTln2sFpaZbUH8bwgWfqSGkA8NbQhiIahXwFFTBh3EOM6zDrcBJc1TEnbpU
	DUVEwMQUPfnxz4pTskciNUX+07giMpNn6Q3jvmPCWMsNZ3oeuuNSmgvz5EH0Kn20Ngm8S2TQY5j
	hhcfiR3H12NSXgNHV6MtnTtEaDPrY0G3ld90lYhiB9kPELQ/n2fSfHILc+5hGWO3Vp1dxQi8HyF
	dhqQ0/540NqD803IIH+IWErAYp40IU1qfkmRvZ7CD7fzlRPEe+kgDOH8dyrL78XSGu7M3t/oYS
X-Received: by 2002:a05:6820:2d43:b0:67b:c368:136b with SMTP id 006d021491bc7-67c0da8c338mr1059481eaf.29.1773801478708;
        Tue, 17 Mar 2026 19:37:58 -0700 (PDT)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d88c5bbsm880101eaf.10.2026.03.17.19.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 19:37:58 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Milind Changire <mchangir@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when crypto allocation fails
Date: Tue, 17 Mar 2026 19:37:33 -0700
Message-ID: <20260318023733.116789-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move_dirty_folio_in_page_array() may fail if the file is encrypted, the
dirty folio is not the first in the batch, and it fails to allocate a
bounce buffer to hold the ciphertext. When that happens,
ceph_process_folio_batch() simply redirties the folio and flushes the
current batch -- it can retry that folio in a future batch.

However, if this failed folio is not contiguous with the last folio that
did make it into the batch, then ceph_process_folio_batch() has already
incremented `ceph_wbc->num_ops`; because it doesn't follow through and
add the discontiguous folio to the array, ceph_submit_write() -- which
expects that `ceph_wbc->num_ops` accurately reflects the number of
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);

This issue can be reproduced on affected kernels by writing to
fscrypt-enabled CephFS file(s) with a 4KiB-written/4KiB-skipped/repeat
pattern (total filesize should not matter) and gradually increasing the
system's memory pressure until a bounce buffer allocation fails.

Fix this crash by decrementing `ceph_wbc->num_ops` back to the correct
value when move_dirty_folio_in_page_array() fails, but the folio already
started counting a new (i.e. still-empty) extent.

The defect corrected by this patch has existed since 2022 (see first
`Fixes:`), but another bug blocked multi-folio encrypted writeback until
recently (see second `Fixes:`). The second commit made it into 6.18.16,
6.19.6, and 7.0-rc1, unmasking the panic in those versions. This patch
therefore fixes a regression (panic) introduced by cac190c7674f.

Cc: stable@vger.kernel.org # v6.18+
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Fixes: cac190c7674f ("ceph: fix write storm on fscrypted files")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---

Changes v1->v2:
- Added a paragraph to the commit log briefly explaining the I/O pattern to
  reproduce the issue (thanks Slava)

- Additionally Cc'd regressions@lists.linux.dev as required when handling
  regressions

Feedback not addressed:
- "Commit message should link to the mentioned BUG_ON line in a source listing"
    (link would not really help anyone, and the line is a moving target anyway)

- "Commit message should indicate that ceph_wbc->num_ops is passed to
   ceph_osdc_new_request() to explain why ceph_wbc->num_ops == req->r_num_ops"
    (ceph_wbc->num_ops is easy enough to search; and the cause->effect of the
     BUG_ON() is secondary to the central point that ceph_process_folio_batch()
     is responsible for ensuring ceph_wbc->num_ops is correct before returning)

- "An issue should be filed in the Ceph Redmine, linked via Closes:"
    (thanks Ilya for clarifying this is unnecessary)

---
 fs/ceph/addr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee8..f366e159ffa6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1366,6 +1366,10 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			/* Did we just begin a new contiguous op? Nevermind! */
+			if (ceph_wbc->len == 0)
+				ceph_wbc->num_ops--;
+
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.52.0

