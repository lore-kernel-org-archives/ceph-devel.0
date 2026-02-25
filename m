Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403E392825;
	Wed, 25 Feb 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042111; cv=none; b=UBqFUozyen+j8eCxxW49h+exGWDeY/zMg3DsumlMEwuOL7YV6VEx3gircSGyS2FfpkbeaF5yei6PkiLMB8F/I1rEpcPDADLab5hlghMMrUwDps6zM4CLk/IPHRjYbn/lesgP6XveSICtSSA166VeNiw7goBs9EZdJ+s9stGANUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042111; c=relaxed/simple;
	bh=H+chkqwt59HWgZzCRKIAyTH02EYmsW7XaEQJO1obFZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEd/Rutl3Ld0Suf0gZ+hSHkvnyho6PP9ksUyF2T+AeelTd9jN1WKShUvsaURdnL3+j52GIpc5e3a62wS4UxNWsul51HjaUoLetdtw7FjUl7HwujtdBRui41zLDyadBdb5k86wgpPP6M/dDMWuEaTehnaz/+w7l929BT0QF3KYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=gAGFaymo; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="gAGFaymo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Message-ID:Date:Subject:To:From:
	Content-Type:Reply-To:Sender; bh=bI+u5Go5q3imugeHY6u14MsTL81HIvemx6U4FxXiSMk=
	; b=gAGFaymofxqt74bKtaytoYrt5qtGxevVqVS3umjP291ZGdNPeWcNlcMMIVkT8F6aDWIYeBYdx
	SWYBaoBOy01X8vDJE84Un9JLF1427K27zRldmt55NdFhco+M5WjQxi6a7LGOO1sCWNQiyA/+QYcEN
	ti6aHh+U3xrWp4DkyE+1qkl/2gVrB4OVw0b0KRjlA0skxuBxcgKSKBSjOAwPmVBcnpkVvyrSJjQYg
	/yZAxqPMnYISM5E1+xyzT+/ba5OgP0+XZPpy+axc07+2fzTzfGVfX1LWJi8ZarQWusLUOiEjgnTiI
	R3dyV1Cg2FUE4HkSWIcR9se7l/Sfs+OIViJicrGR2XP5CasFSQjiGngm+wPQ3ljL/o5HqNGFyJ6qk
	sipxak6tXb9GO8ZntD8Hv+d9HWsQVsDeWnz3o6xKiy/H1kZ0t/tG4sNwmX0KuyzfeX23ACFfw7cc3
	hOeGnt2o9m2KU4PdKfcxpiEQt7cK5rDtLEMUJDnhUgKLqgfGD2LZEn0+lA/yHOcNnbygffe8bKvNR
	kXzaJGcOsr+VG2zFOBRreuHLOsV5+/4WmfhY8iW+cTGR6b4dU2I9H2HA1INnSlC5yImZfXp/doecS
	1kQTcjq0O4sBCYlo1id2ZirjWrkZ18rg0XHi1/IJw2nPiFSPxbLlCwDgtFXKQgD4YrH1eOY=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1vvIQy-00000008SDW-2KUx
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Wed, 25 Feb 2026 17:12:24 +0000
Received: from venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id Dx3VDnctn2lzvx4AdB6GMg
	(envelope-from <hristo@venev.name>); Wed, 25 Feb 2026 17:12:24 +0000
From: Hristo Venev <hristo@venev.name>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org,
	stable@vger.kernel.org,
	Hristo Venev <hristo@venev.name>
Subject: [PATCH] ceph: Do not skip the first folio of the next object in writeback
Date: Wed, 25 Feb 2026 19:07:56 +0200
Message-ID: <20260225170758.2014172-1-hristo@venev.name>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `ceph_process_folio_batch` encounters a folio past the end of the
current object, it should leave it in the batch so that it is picked up
in the next iteration.

Removing the folio from the batch means that it does not get written
back and remains dirty instead. This makes `fsync()` silently skip some
of the data, delays capability release, and breaks coherence with
`O_DIRECT`.

The link below contains instructions for reproducing the bug.

Cc: stable@vger.kernel.org
Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Link: https://tracker.ceph.com/issues/75156
Signed-off-by: Hristo Venev <hristo@venev.name>
---
 fs/ceph/addr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee89..2090fc78529cb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1326,7 +1326,6 @@ void ceph_process_folio_batch(struct address_space *mapping,
 			continue;
 		} else if (rc == -E2BIG) {
 			folio_unlock(folio);
-			ceph_wbc->fbatch.folios[i] = NULL;
 			break;
 		}
 
-- 
2.53.0

