Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF57E0FF;
	Thu, 28 May 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779940522; cv=none; b=EfDkI6z7TgNrQUijIUool1Zu0SOVPY/OVvGFiPcvVEY8XvOby01RGlPBGg2k3Kr+iIrTr9dvWuNXzba/jOz4KyEwDETbNYesIE9qKufSK4dygS+jysI8qGcAod+raz3t8D43nVVCeL/3WFdeK9pfDfgbGAiUx5tCKoSPmrqm0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779940522; c=relaxed/simple;
	bh=W4BxKN4nWyw/DEpE8xic+PrAgXVwQpdqyYOyk1oElag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i66tNX/iFzSP/0P/7L2NwzXZssNnkHcnNwJfMBFB3H0yhgSQBm18fxU9EIcJD5OcKSS4XsvD4tpkEiU38jTouxww09zerOzheOSTHlEKdTmghLEk2IhKpd/Xdr7oEMCDG1oBSQIafPTazIdEhUfhGlKt+d9h2xHBUUiKaYuCkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACX+NukvBdqqsSdEQ--.5982S2;
	Thu, 28 May 2026 11:55:16 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] ceph: fix writeback_count leak in write_folio_nounlock()
Date: Thu, 28 May 2026 03:54:58 +0000
Message-Id: <20260528035458.1146314-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX+NukvBdqqsSdEQ--.5982S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UXF4xKw4fKrWDtrW3Awb_yoW8WFWDpr
	Wjk34DtrW0qrn7Gr98GasYv3WUC3yjkrWSkF4UWF47X3Z8Xr1jgayjq34aqF15JryfJa9a
	qrWvkFWUua4qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe0PSUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsBA2oXfr3TtwAAsV

write_folio_nounlock() increments fsc->writeback_count to track
in-flight writeback operations. On several error paths where the
function returns early (folio lookup failure, snapshot context
allocation failure, and writepages submission failure), the function
returns without calling atomic_long_dec() to decrement the counter.

Each leaked increment keeps the counter above zero, which can prevent
the filesystem from cleanly unmounting or suspending writes.

Add atomic_long_dec() calls on all error paths that currently return
without decrementing the counter.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0a86f672cc09..a606378649c3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -790,6 +790,7 @@ static int write_folio_nounlock(struct folio *folio,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
 		folio_redirty_for_writepage(wbc, folio);
+		atomic_long_dec(&fsc->writeback_count);
 		return PTR_ERR(req);
 	}
 
@@ -809,6 +810,7 @@ static int write_folio_nounlock(struct folio *folio,
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
+			atomic_long_dec(&fsc->writeback_count);
 			return PTR_ERR(bounce_page);
 		}
 	}
@@ -847,6 +849,7 @@ static int write_folio_nounlock(struct folio *folio,
 			      ceph_vinop(inode), folio);
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
+			atomic_long_dec_return(&fsc->writeback_count);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
-- 
2.34.1

