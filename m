Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E740B6E9
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jul 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594145; cv=none; b=itnPXwLD5sfUJpJfeRJAjjNN5aCqz9BDT6xemovj/I1KC4udfQnbg22DmmNbrQJ2KUB4wY36lzX/0nx6UZwNFYQli8zsmQkvIIaXKmkLf/fWs7OcbRplu2vVl/YLD6IJmbUs+kmOqLmp+fsXu6TvgQGucv/5e7mccjg5+UvJGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594145; c=relaxed/simple;
	bh=2bapFKTI8KuLGPzadOh6PDSko5p/br/j9Mta7iuaqCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEoqeYw44nZdd0t6P4GAPjGUxYYQXrmaELWQl9fwlbZVLSb1hvWZ/ksZWJQebwQlhvMoY+bHQbcoqgSdPC8EgfyuxogxSlOYX8YiyHGJw4N3XVsNmTdeQ9aDx0Jzqe4i39elUe1zt8k9w3putv38lyWT04+5FRKNUMSE1qbTm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e8z+9XdO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e8z+9XdO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c733f15aso7603455e9.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2026 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783594141; x=1784198941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnCwMjjX6byF7x1aokdy0MnPmpqS+QrEx0Ph45vdvQw=;
        b=e8z+9XdOcDUzZPRQFSNvkvrVg3SFOHDTmDwWRNNVMSWhrk8W1lcDnB7FW3tdqzV9VZ
         pYV7F+/X4kW6CDoo7YSZ7bAN60+VZavX09V3qWBaKH7yi6+SfSdyzKPWfYT3y0eeMLSY
         8rS90LHlL2C+Y/xxtjcoa6blnucIrmoeaQwWrkZU0Mq66MpXUoFPsZsK6VlymikjrMUf
         mEvFZyPPTyLNoFGLPlco6qgaWA47rRFURVXcliZBH+URBj6IW9Lfd604905YzTrOEkHE
         3tgNGKK/RtFXGdqw68XLJ7j03aYgwYo02/eFw4Xz3Lob0CGEZOipFA48eZePmslpGelB
         MbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783594141; x=1784198941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnCwMjjX6byF7x1aokdy0MnPmpqS+QrEx0Ph45vdvQw=;
        b=PxFoNUBXzyjRqyKYnlLYPZV7pmhqR5F8l3g1pxMqY8ts1vyM+gtODCFPQmrF0xq25Q
         MBTKfDPrXv1uBQaJzv1KJLafdGCc2cf6Gvi09DslfQUk51M0azhUX8BSQvaeeyMJxXiG
         3yaJ7yMQnawcTev8hK9ust3+kJLr3B5X5P3nNInIVZ/1FGUcAZrY2aTyhtZ803mcAnZC
         D6BUOO6NUpik+NwW+jqCJ39wY3v6RDUKfiQe5y3BZm+1oPDZZlhynmTTQF8Lp8wgAayq
         O/ltQDEiIBIn1s1rI8821Aml485ODxp3JtUa53NsclMFR1TiU6VEqm+lNvIuIrvEdXbn
         RwrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHKtGtcw5ngAaOlzyMnvqrT/ycR0sQ2meupw2TBc3N1YOd90qAXe5Nesy8gxU9/QeRPoh/fYoSXMjM@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGgzorFPr404cqnyv/hEG/fKJvlu5SUtjPcAluUqpL9e+tToA
	5ye8tGcbGAzAF2137UeVdInKpl7Oc9L+HdDnnepKBXjoXdb2Uw7Njgq2Qm3YZGgmEY4=
X-Gm-Gg: AfdE7cl7ehQEQI43oeQ5CVMUlqxKpDYvj22V8f7weNi8BgHMaXzOiSqYL3JJ4OjkPKP
	6DB2PMsuIfUzAe4UQhftNiZfBOzrXtqYMTGZWN5ZNWKrXkZseCm3PfRFaDoeAJq+x1j7u5CYoWk
	4A5ZAvUgQTubA5YVgjbrOzPwucOuoCF+inVpAHnSQZVfsLhNYYp9vI4C2OQI5tc4ab8H/a5FFNz
	KvuZBdHeD97Q5cgqYuX7Cxa6Lr9cJ1ePwNYqXIUn83iHhk6o7Bq4wFkPA10PJ58NHG2LaSYmTBk
	kD0/E//BAJsrI1GDk5P0aDl0XE1teDoCC+aYEFglJodc++p9rnYKRAj4cYBXV1HMAcyEBXT2Nmd
	GE9OOniYUMVjGHN0jCqj8Hcno49LkPwY8DF9yynKfaMs+A6irDZmrJo/LIwcv6q/yG1Eoo7eccT
	NVOkM1jAgyabj5z25jdzx7oCMYKuqmqXsH2ImtuB2zu1+EiHN4uwoYGFBixhozlqDe+GDNUFxDo
	JiK42kS9+Eoci7U
X-Received: by 2002:a05:600c:a44:b0:493:bcba:3d5f with SMTP id 5b1f17b1804b1-493e68a566cmr66664435e9.13.1783594141505;
        Thu, 09 Jul 2026 03:49:01 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f34b400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f34:b400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm51397483f8f.15.2026.07.09.03.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:49:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/mds_client: use detach_cap_releases() in ceph_send_cap_releases()
Date: Thu,  9 Jul 2026 12:48:56 +0200
Message-ID: <20260709104856.900685-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate some redundant code.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 853bf698b356..578c1909e18f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1799,16 +1799,19 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
  * session caps
  */
 
-static void detach_cap_releases(struct ceph_mds_session *session,
-				struct list_head *target)
+static int detach_cap_releases(struct ceph_mds_session *session,
+			       struct list_head *target)
 {
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
+	const int num_cap_releases = session->s_num_cap_releases;
 
 	lockdep_assert_held(&session->s_cap_lock);
 
 	list_splice_init(&session->s_cap_releases, target);
 	session->s_num_cap_releases = 0;
 	doutc(cl, "mds%d\n", session->s_mds);
+
+	return num_cap_releases;
 }
 
 static void dispose_cap_releases(struct ceph_mds_client *mdsc,
@@ -2464,9 +2467,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 
 	spin_lock(&session->s_cap_lock);
 again:
-	list_splice_init(&session->s_cap_releases, &tmp_list);
-	num_cap_releases = session->s_num_cap_releases;
-	session->s_num_cap_releases = 0;
+	num_cap_releases = detach_cap_releases(session, &tmp_list);
 	spin_unlock(&session->s_cap_lock);
 
 	while (!list_empty(&tmp_list)) {
-- 
2.47.3

