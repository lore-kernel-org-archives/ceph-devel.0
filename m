Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD6175A69
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833735; cv=none; b=ZV/93DVVMd+xUa9MWo6BSAF4RjarfYHIMliTNxW+8RkwfJRHpbOG9Wyz+Vcya6tPSWdy0P4z0BJ0KY/HjDZRXc9BDd6d2I0T9WbkcFx5O+XrHLXyKNf0BbZ6MfMZpP7hwqBQiySOKidCTqe6qV0he4FuczvzEq2tURsiAaEcB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833735; c=relaxed/simple;
	bh=OsX88HVi3+aWS7mjQjq0IVpeYv2aRyeQAP89kDTGMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEpcAqaEVRzZOivx9PvrJ5e8h2NOgSIi12snY8CADV+L8MtTNWez03gg99HCYuk0WjEc8XBYmE8gLS0LQDiXmWnPh8UfuLt7sL5v5lv6dRTeGJtGNHTyYHesNrtgTfD7ZZsc9BN2Cg/2VtiaIX0wB1dqvnx5mIaceDm9a3aVS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=L/MHgs1T; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="L/MHgs1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1773833632; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=OsX88HVi3+aWS7mjQjq0IVpeYv2aRyeQAP89kDTGMFQ=;
 b=L/MHgs1Tm6w0tVVyeaFp6e+WvXxG+DViMxEYV9PRR+uiylQGdIX8QZRCPgGVBoFz6Oa79
 70NfUo01UJ2CP5OJBWrwZ3SVN9GztpBr/eUJLaA1N1EwbwKhS0gsDP3yZNqxrpxsUBFKHNM
 fCYWpj5Ztz5hMxRttWvUnyjp3+vUNwWToEJPCx7va5glsp3j6jaORZiHEEuW7xhDSpXSNRX
 Ei+/emKCLIaUpX8BYlLWp0VGxrDA8nND/o/QowwHFwq53nrKl6JSeXHOIqQdgF7omUD9ECU
 Iog5FOm2CsAkgo3hViomAmGfr0G72t0oBdFnQv2sJ+f9O0ePN2U/w24IbKHQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 5F9615FD3D;
	Wed, 18 Mar 2026 12:33:52 +0100 (CET)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 6CA515FC9D;
	Wed, 18 Mar 2026 12:33:49 +0100 (CET)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
Date: Wed, 18 Mar 2026 12:32:56 +0100
Message-ID: <20260318113256.810478-1-raphael.zimmer@tu-ilmenau.de>
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

This patch adds an additional check to the logic for auth protocol
negotiation in ceph_handle_auth_reply(), that treats a
CEPH_MSG_AUTH_REPLY message with protocol set to zero as invalid if the
result code is >= 0.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/auth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index 901b93530b21..d97f50d38022 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -238,6 +238,9 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
 		if (!protocol && result < 0) {
 			ret = result;
 			goto out;
+		} else if (!protocol) {
+			/* protocol unknown, but no error given? */
+			goto bad;
 		}
 		/* set up (new) protocol handler? */
 		if (ac->protocol && ac->protocol != protocol) {
-- 
2.47.3

