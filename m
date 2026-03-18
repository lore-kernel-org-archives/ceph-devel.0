Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2C3321BF
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853755; cv=none; b=Zfbo0ZwFK6d7Br/MlywEaeWucLGOSQ/6r4VEjXVWk3W443QGP96JXZouAbr/Akq6lR0ocRh4tQ40yDoFGclSi0zIGHOoisTrrX4QAA3mlH9858z2Kyun5qA7baERxpjIalzzvLh+yt96lAoMc+I4p2yB9frigtmWEa7FzFv/6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853755; c=relaxed/simple;
	bh=Xapwjai4/bkZCIKxhcnHibSa6hjB9sSP/A76J1rJve4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkOGO1jPinth8x4lJ5NY20yosXp/6b8dKy4r+dmM2lmmN8cZYceSPL10Bn6Wjkthx6QSxh78IGzUEf9td+hekZmyXauthGzr0MHMWTUjxvzD4tHVqisTfyJYAYYrbY4r4zC7U7VpwFeKLK/CKLxrY33wQf1rH6on2Wxrh2SR3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=bB0cxDVz; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="bB0cxDVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1773853751; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=Xapwjai4/bkZCIKxhcnHibSa6hjB9sSP/A76J1rJve4=;
 b=bB0cxDVzgiZWI5CbelbHCxH7mGk2NtkUPgQVeSeXtlU5txYlTsD9O9eJkUWgq0WtTX/jn
 akpOoVqBSXLQJTOXRjsBnN+Jbpj0QXld7nR8jfXVYCTcJmfytVQf0hTiDnowNwPBa5f0r0d
 tge8bhiaPK4N2o7lU7hYGBS//2cpPJsl4UJ1O0svFWsTi9sm60XYXy3k4KykvwcrW98FFCy
 kbwJ8KOzKBf9n6tHRoUXcnhxvfxc9IaZOF1pHzjT2e1KmYSfkq1CfbBYeK2VMqTG7VVcyEs
 9C6FmQdd3Se/qSTZHRAJ9fhLMqlKJrv7+Wux+ZkgoI8MnZzyCJgTkPIz+/yg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B45B15FD3B;
	Wed, 18 Mar 2026 18:09:11 +0100 (CET)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 9CAEC5FC87;
	Wed, 18 Mar 2026 18:09:11 +0100 (CET)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
Date: Wed, 18 Mar 2026 18:09:03 +0100
Message-ID: <20260318170903.869491-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a message of type CEPH_MSG_AUTH_REPLY contains a zero value for both
protocol and result, this is currently not treated as an error. In case
of ac->negotiating == true and ac->protocol > 0, this leads to setting
ac->protocol = 0 and ac->ops = NULL. Thereafter, the check for
ac->protocol != protocol returns false, and init_protocol() is not
called. Subsequently, ac->ops->handle_reply() is called, which leads to
a null pointer dereference, because ac->ops is still NULL.

This patch changes the check for ac->protocol != protocol to
!ac->protocol, as this also includes the case when the protocol was set
to zero in the message. This causes the message to be treated as
containing a bad auth protocol.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index 901b93530b21..3314705e5914 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -245,7 +245,7 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
 			ac->protocol = 0;
 			ac->ops = NULL;
 		}
-		if (ac->protocol != protocol) {
+		if (!ac->protocol) {
 			ret = init_protocol(ac, protocol);
 			if (ret) {
 				pr_err("auth protocol '%s' init failed: %d\n",
-- 
2.47.3

