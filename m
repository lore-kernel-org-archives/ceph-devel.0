Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7181DDC07
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394668; cv=none; b=Hb8DkZ6KcOarryXjA5BXsuo5QQ1iVlc9lUYD1ydTWkRV1MRwgFq6xEchfHSj26C/WSApSLy7WxWZIDLUcoJxeR/Ky5TIo05cOoiGm90n/JcDF1s8CQTjwO3vnA+FJZwI9YG0mWEHmUr09y9oJTQAeCWSOQUsrH00LmQ8FUE8iZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394668; c=relaxed/simple;
	bh=2r3QgcjH7GZMruE67ZsjvUp6p/exK5sB1NKVz9e2BfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfmDfucZPgnJyHibtS5+MbwHi96aKCNSC17e+FWEeq9nthMysxi0VoMOxe+ZpsyBjug8HKglu4DG5+SXo2DHMATkqmWi788YXL5JSN/yLkHa+Q1+mlb8XTKLHUXjVXzcGDKpgtaSLnkEE7elyHcNQt4rdi+R1BhC/UVHDj5KbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAHZ408s; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAHZ408s"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12331482b8fso1216261c88.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394666; x=1769999466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m877IielwhZYxUtpH2DsnWNPP6T5OXQthZEWEyOygI=;
        b=PAHZ408sgWRqlfTkQMqroDt+XD+0tL/RZvpJPYvVjIgKYJJ29l/xASZO6X8WVHQ3Aq
         0lEdfQQdp/ti6HvGzKgLbEFKXGSA1+s35Xw//2Lv9zu5CW1fizPPwzmVtG08GMufBOZA
         Q8T0mp5xTCpN8THVp7Ej0y+W+WRzq2CXVcUtrqbxj7v5DyAMWcOgjx63fNh7oVfsNlGM
         Y4+yWkk/jMoxbb0CDLGEAxuEPSlVRp+sJ4gqE3553l4wdESAckyHDuIlab58NVXWRoqg
         cmYKvsk4sfbklu/760JBvlpU+PWJHgV3cm2d1aVfHyiCBoiMfgfd7Lh3oQMUOfQz3OIE
         cQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394666; x=1769999466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0m877IielwhZYxUtpH2DsnWNPP6T5OXQthZEWEyOygI=;
        b=XCSdNna5EFFrbKAi8pm7TIT+12Sd0ZW8iJxAplJzWKnIPcOxxFkA+xIf8q9F3yxFcU
         j9g5cQzx8G2w3tVsc4bbvAEWugTm4atx1lEaJ+G/Pp3sN97QYPV0uFu40vVL5LaJK39g
         g+0zcGXpH+FHSW1n/IVs2YSnRForDwuSSjaA9rAepp69a9QRh6tjC+u9H+X4zYY5rCH9
         MeOh6F0xQYgpydFhoKXzpP0ZASOdFly7RbwMRJFa/WQ/wlpG4zXQRINL8G//OyJHelSy
         DCvrWHwbtI+0ldB1fzMTS2x1Whr64VRfVzJo6rGYQnBb1/ZEwTP0O3Q+UI3piDe75YVO
         dMZA==
X-Forwarded-Encrypted: i=1; AJvYcCWBLInxK0+C+dgd6WdqN3ucpxx4RQ4Ey1F8qoKQPCGzDhPWIo+/+zCn+JSAv3hEE4+Xw/+eZUpoPwiw@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaTGNOmdQcTCOUvqMq7n+usWiX6kkBQeZx1h1osR7bGPW/WDE
	Jy8cbpCfdYHF/C/TlffnH+D7rKaMLqGxfb/0C1n7p3c2b9OGm1M66wr7
X-Gm-Gg: AZuq6aLoqS5fmxVJ+Pam4Y1hnMWmKwlMbYnY82RaT3XHMfW9iHd4xauJE0Hsu+ZwgbQ
	gMqtNJVMqEzFGNO9ha6r831TpoKFrsMBON+Tsfqte6Hugv+49yatGfMDmTHKpH/FE24RjWj1/Ng
	cbuX3gsymfzI+Bc3VDPcCXTfQs9V7XLdz1bo5Kz3H4ggY+NZixHm57sOP1zCO/1u/e3xyGJEwXa
	8dMaHkw6bqOyj7e/+i0eXW/kJl8Ux1ZrxWQS/wM9esXuqIXENMy+SYMQvfnkvZlOhZ+Kk1xeRw0
	pm9fQ3krQnxqNIMc+6LDXAjJBdxyXhHrT7pK20N2G9BjGHFS+KJgTziUxgRzpPWY1C9Q/B9JR/R
	Jiz937MQCncmnwvVNdjp0HKqxUC95GtCWsA4hwRFXM9UiPy7p/Gl2vMGjoKA3oIWAlPbVIBtBbf
	BNv96BdQWbOAYDqPg+yL25dCD6c2oMw6mkx7h7t0pzeYrlwAoqwxOn
X-Received: by 2002:a05:7022:6183:b0:123:3356:7abb with SMTP id a92af1059eb24-1248ec87252mr1826327c88.46.1769394666463;
        Sun, 25 Jan 2026 18:31:06 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm17212277c88.6.2026.01.25.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:31:06 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] ceph: do not propagate page array emplacement errors as batch errors
Date: Sun, 25 Jan 2026 18:30:52 -0800
Message-ID: <20260126023055.405401-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126023055.405401-1-CFSworks@gmail.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fscrypt is enabled, move_dirty_folio_in_page_array() may fail
because it needs to allocate bounce buffers to store the encrypted
versions of each folio. Each folio beyond the first allocates its bounce
buffer with GFP_NOWAIT. Failures are common (and expected) under this
allocation mode; they should flush (not abort) the batch.

However, ceph_process_folio_batch() uses the same `rc` variable for its
own return code and for capturing the return codes of its routine calls;
failing to reset `rc` back to 0 results in the error being propagated
out to the main writeback loop, which cannot actually tolerate any
errors here: once `ceph_wbc.pages` is allocated, it must be passed to
ceph_submit_write() to be freed. If it survives until the next iteration
(e.g. due to the goto being followed), ceph_allocate_page_array()'s
BUG_ON() will oops the worker.

Note that this failure mode is currently masked due to another bug
(addressed next in this series) that prevents multiple encrypted folios
from being selected for the same write.

For now, just reset `rc` when redirtying the folio to prevent errors in
move_dirty_folio_in_page_array() from propagating. Note that
move_dirty_folio_in_page_array() is careful never to return errors on
the first folio, so there is no need to check for that. After this
change, ceph_process_folio_batch() no longer returns errors; its only
remaining failure indicator is `locked_pages == 0`, which the caller
already handles correctly.

Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d214210..3462df35d245 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1369,6 +1369,7 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			rc = 0;
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.52.0

