Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F63E1CE5
	for <ceph-devel@vger.kernel.org>; Mon,  4 May 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913710; cv=none; b=soa9g+yyaMk+RW/5KhL+5R7IYe7V2pC9JQZkB/4Kk6Ig2PaOS099N/+l2d3uXa5BLZpCRIJV5Dc6MiGlak7mWr5CmqCIe0oqIi4jKE43BbZMCMQPqcSqKkT++Z4b4Ws2v/fBdONzZjSyaXov7oKHknTqqkTGfWCl3ex2WBU2KRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913710; c=relaxed/simple;
	bh=hr6dyPeJhPjx8lhsSe6EXUYh3+Uu2Qq3IZt53Huk+4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1GXeaRU0cpoEBQJgnGqWdlD9kYa61YOCVbw8JB7pjyAJ6mWWjGNwafvH0nVNr+IsehrHpOzD0oQi2BIU2rBMSrrrpD2NJTXUW5XNOsDIhC9/ZxqdE9FhJ9C4bLogPoMTPzmDcEwkNwTxV2STF6sowszdac33BKvTbhr7DQqGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=em40ZXuO; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="em40ZXuO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Message-ID:Date:Subject:To:From:
	Content-Type:Reply-To:Sender; bh=VgDjbsjBR33jiccEW7OlvFDeOgOtO4REdws9wLY9dzk=
	; b=em40ZXuOkcmmytrPRXJ/Hi3IDqIINqwpAl6LrLiv4ETekiakx5zN9mnhyca1GXMhxKS90SdL/
	kK+4QKypmw9xnpZtzqAlrYzpaZWbBYgdGQo6UBzfTm3HBeoe1D2MNRRqkM/iiHc8aAPuNOUPp2jtF
	of1cAW73sqnF9AWxAaSLq0zA+fm2DkYvdIcSZl9E791iQQVAu2cPTFXn9BwTQBDqHIVv82wLJL8ya
	V2MVvPhzKdWHes4F2xwMDu3I0ANZi+ZOKz3HpbCs57ovvsgk6yeMy+EYyFp/7dP99tOU52trhpKB7
	nT+Sfjbsrau1ZBpLsFxbA2X28a8rp0zRl8if7HNnwSudkXjmfAQOMTt4zTe6EBsCbPUQsS//o8Z9u
	1b0qvUDBOk8octLNazvFxqqf8U+Jy6TNp+qrIxGTASJJ5N60+JsSghUS+Vb9HASIvaPGtpbf3jec8
	f14g66mwpKG1+DtLg+YsXHQuXJWYL1bGccOko7YvwH0EM4yZhbXkVEKwGdT2UahrV9RAgZZxXVC/U
	xmdsmBtvE8kocuDd0MI55TeiCOido3hZ7dJliIvrIrDleIbLD3r04TbflOpOevw9cY3qjXKqk3kw4
	4J2vTscnnsqm+VAyR7y+lQQn+bMeri6O3eDyMnkgKrkhOMDny4GPVBh8lCHcQaEXr8i4bg0=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1wJvdW-00000007wPv-0kor
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Mon, 04 May 2026 15:55:10 +0000
Received: from venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id +UVRD13B+Gn04RwAT9YxdQ
	(envelope-from <hristo@venev.name>); Mon, 04 May 2026 15:55:10 +0000
From: Hristo Venev <hristo@venev.name>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org,
	Hristo Venev <hristo@venev.name>
Subject: [PATCH] ceph: put folios not suitable for writeback
Date: Mon,  4 May 2026 18:54:45 +0300
Message-ID: <20260504155450.1892761-1-hristo@venev.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The batch holds references to the folios (see `filemap_get_folios`,
`folio_batch_release`), so we need to `folio_put` the folios we remove.

Tested on v6.18.

Link: https://tracker.ceph.com/issues/74156
Signed-off-by: Hristo Venev <hristo@venev.name>
---
 fs/ceph/addr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1454760332ff..0a86f672cc09 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1336,6 +1336,7 @@ void ceph_process_folio_batch(struct address_space *mapping,
 						  ceph_wbc, folio);
 		if (rc == -ENODATA) {
 			folio_unlock(folio);
+			folio_put(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			continue;
 		} else if (rc == -E2BIG) {
@@ -1346,6 +1347,7 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		if (!folio_clear_dirty_for_io(folio)) {
 			doutc(cl, "%p !folio_clear_dirty_for_io\n", folio);
 			folio_unlock(folio);
+			folio_put(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			continue;
 		}
-- 
2.54.0

