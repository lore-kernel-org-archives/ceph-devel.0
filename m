Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0AE3749F5
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570631; cv=none; b=dkVEg/3AApG1/tkBfUCmEAIcO5taWfpX2UPiW/GfcScyE+Sk0hYoc4eyJE0Qb6S0RjjSnZ6Tdw+DYCBd7SC42XxohHJS3IapJ132/z7Pe4oKZRX5s9qPrXcDc8NhfjhLyBylHmegMVfCl7vUHCE0Y4G36Z0wDVbaTJBQ7Iaugvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570631; c=relaxed/simple;
	bh=hzoNmIDfQISBOnwji5LpOn2aM4ATZSLJkOb/ZHhVi2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXz9XIriBYFl64BV6d+P/QyZttUEMwvJ7Co1Y5T+QQbxrhwaP7dqOZMGAkQwcmmGZqVT6rXA3LnkWlv4C88gjr0YTqpiyp5SvlkAlTxB/EdATi3eHk/rTxyOY3UnnSA5q4TXBriwH1D7uTUq0qn6OoSvdZiEsGh13A5rSr4+qHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FXZbQCC0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FXZbQCC0"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f703a9d05so992127f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786570626; x=1787175426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dlQ3euvJCzn2RRzFtvHCy6UsDOvRsY+/cw8Sam89HV8=;
        b=FXZbQCC0mZDbU/aw3F6SkeoNkKDCDElyGMV51vmc+OB63kiMFViocdgAAWLvaMwCHF
         T6uiluu3xlcDkFuDfFsUR4cn2FC0t/ZVxv2mzMmfCoeFSKWRWeeQJmPS5Nt6rIRUhQFk
         XacoxOM5dRBamhSMOzPh+INshKgtEw8FN0rNvI5ELD9IFhhKoL8RiLCzkBDfiP3D+tqb
         clN44a7lirdhROJLALAqvHXzaVhsmfr9h6Y4hhkbZHKRehMuJ7hHA4GCSii+BbLmB2nI
         EJQBTv8JDKh/Gc1sW6nIBVvG5em1+8n54RuqCrIaa4a2SQfrtJy1VZvUOW0lDPdVEc9V
         /5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570626; x=1787175426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlQ3euvJCzn2RRzFtvHCy6UsDOvRsY+/cw8Sam89HV8=;
        b=ALXBYKkfTgD22jrLi4nizJiiJcZlZ9KTdYDNEN8+dqdOGiDMyx+6t6rZnbHG55y2Q8
         1v2aYz++sKmSgLk42C/ZlHC4aaAlbYg8CIP6oqCNDS+Fagyc30MAWKQS4LSU7KSSDiqU
         W9neIKOv0EU0/PzJmzdQV7afyPdxZfsNUaEKwQo7ctolt5USH/nuCOj3QAGu2Wtbty21
         Yx2mP2AFwfVDhUe3qG2GprgKgtYcX949AV9M2ZhoB2+VP1yoKzPBAWJcc7jGHGLXwQkq
         oZQalS+56gOfobcJpOcwuUkYwcQEBB/YoAaga8H7rkQ8a2so+g/SVxQxMwY9wZ0zyNqz
         gvig==
X-Forwarded-Encrypted: i=1; AHgh+Ror3jpE0K+g2+Lj4XGAAMm6rg9W9BetIYrvJ6LThW6sEaty4FQVgeRhE/vfux++zNG0yLLAuJUmYHwt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ozUp84VmbPETCylvJiWtOI0QlIWXlBPFqdXbhaDYFJVl+q2N
	81KfVa36j3I6t/4gU8G2dHFTNkde4+OMz4cEljT7hpuuhqXshC9jNh6k61jTQ4Xi3lA=
X-Gm-Gg: AR+sD124QLdvUFVEmjzD5sJVwqFK2NKoUkYh595m7t6hJEPaqFnWeM5gB2WhU/S0fX/
	wRqabY30iEJcBh1m+QbFWm4cFxcUS6cjdkZm/cVEma0nMsSNE+XiP3pzYJLOuIp6QsYeTvvH76x
	0Ok08318v7tYQbiWyyR0MLpPWBUzzwsnVC/SeyN6Wt/iwTMvxwVVsnjxOSxcWbUpvowM9p/aa2C
	J1GbN1Ixive9HyYmjFGsbfUtqnfzZ9Qjh5N67bRfcHEFKRQBHFUOHJFp2jB/IxMiNIlYnnxosRP
	SmFykE8EPCbeZIN0kXSw9NXTm4lBzQZHMKpx+oa/ZITayfLRnpTBZe/aoK3pAQ6ftxqNUZmGxqM
	lgBgnz7Ws/YkNKElVkrsDo9CF5S6dYHVCHnlQkWCFcojp4+8+sd8AlzyxE3ZGCye4g+18LMJux9
	KSx1jItSdmWUrI2AAE0JpQl7ZjcPID+g2IuBCSXIBphjwQZALR5vIo/gkTnnoSRg0y4Y6tw9GCS
	4jwfukf6H9K32yKqYEVw25/Wc7c5aRoOEjTnDsWR3IbDVlgj4DtbtZa5We+y7XI
X-Received: by 2002:a05:6000:46c9:b0:481:4fe8:696b with SMTP id ffacd0b85a97d-4815a05274dmr890296f8f.29.1786570626366;
        Wed, 12 Aug 2026 14:37:06 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6e3asm594940f8f.28.2026.08.12.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:37:06 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4] net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Wed, 12 Aug 2026 23:36:57 +0200
Message-ID: <20260812213657.1821175-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ceph_pton() using inet_pton_with_scope().  This minimal
patch preserves the ceph_pton() API and thus requires copying the
parameter to a null-terminated string.

Since struct sockaddr_storage is part of the Ceph wire protocol and a
non-zero scope id can break the memcmp() checks in the banner
handlers, we need to clear all scope ids before using memcmp().
Therefore, this patch introduces the helper function
ceph_addr_equal_no_scope().

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2:
- check "ipend" before dereferencing it

v2->v3:
- fix indentation
- use the caller's network namespace instead of init_ns
- stop parsing at the port separator

v3->v4:
- fall back to DNS only on EINVAL
- use GFP_KERNEL instead of GFP_NOFS
- ignore the IPv6 scope id when checking the banner peer address

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/ceph/messenger.h |  6 ++++
 net/ceph/messenger.c           | 64 ++++++++++++++++++++++++++++------
 net/ceph/messenger_v1.c        |  3 +-
 net/ceph/messenger_v2.c        |  2 +-
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6aa4c6478c9f..ab56a04993d0 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -570,6 +570,12 @@ bool ceph_con_v2_opened(struct ceph_connection *con);
 void ceph_con_v2_reset_session(struct ceph_connection *con);
 void ceph_con_v2_reset_protocol(struct ceph_connection *con);
 
+/**
+ * Check whether the two addresses are equal, but ignore different
+ * IPv6 scope identifiers.
+ */
+bool ceph_addr_equal_no_scope(const struct ceph_entity_addr *lhs,
+			      const struct ceph_entity_addr *rhs);
 
 extern const char *ceph_pr_addr(const struct ceph_entity_addr *addr);
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..c2a18f50bc92 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -161,6 +161,23 @@ static atomic_t addr_str_seq = ATOMIC_INIT(0);
 
 struct page *ceph_zero_page;		/* used in certain error cases */
 
+static void ceph_addr_clear_scope(const struct ceph_entity_addr *addr)
+{
+	if (addr->in_addr.ss_family == AF_INET6) {
+		struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)&addr->in_addr;
+		in6->sin6_scope_id = 0;
+	}
+}
+
+bool ceph_addr_equal_no_scope(const struct ceph_entity_addr *lhs,
+			      const struct ceph_entity_addr *rhs)
+{
+	struct ceph_entity_addr lhs_copy = *lhs, rhs_copy = *rhs;
+	ceph_addr_clear_scope(&lhs_copy);
+	ceph_addr_clear_scope(&rhs_copy);
+	return memcmp(&lhs_copy, &rhs_copy, sizeof(lhs_copy)) == 0;
+}
+
 const char *ceph_pr_addr(const struct ceph_entity_addr *addr)
 {
 	int i;
@@ -1221,19 +1238,46 @@ void ceph_addr_set_port(struct ceph_entity_addr *addr, int p)
 static int ceph_pton(const char *str, size_t len, struct ceph_entity_addr *addr,
 		char delim, const char **ipend)
 {
-	memset(&addr->in_addr, 0, sizeof(addr->in_addr));
+	const char *delim_p;
+	char *copy;
+	struct sockaddr_storage stor = { 0 };
+	int ret;
 
-	if (in4_pton(str, len, (u8 *)&((struct sockaddr_in *)&addr->in_addr)->sin_addr.s_addr, delim, ipend)) {
-		put_unaligned(AF_INET, &addr->in_addr.ss_family);
-		return 0;
-	}
+	delim_p = memchr(str, delim, len);
+	if (delim_p)
+		/* delimiter was found - stop parsing there */
+		len = delim_p - str;
 
-	if (in6_pton(str, len, (u8 *)&((struct sockaddr_in6 *)&addr->in_addr)->sin6_addr.s6_addr, delim, ipend)) {
-		put_unaligned(AF_INET6, &addr->in_addr.ss_family);
-		return 0;
+	delim_p = memchr(str, ':', len);
+	if (delim_p != NULL && memchr(delim_p + 1, ':', str + len - delim_p - 1) == NULL)
+		/* a single colon was found - stop parsing there
+		 * because the caller wants to parse the port
+		 * number
+		 */
+		len = delim_p - str;
+
+	/* the input string might not be null terminated, so copy it
+	 * to a null-terminated string
+	 */
+	copy = kstrndup(str, len, GFP_KERNEL);
+	if (!copy)
+		return -ENOMEM;
+
+	ret = inet_pton_with_scope(current->nsproxy->net_ns, AF_UNSPEC, copy, NULL, &stor);
+	kfree(copy);
+
+	if (!ret) {
+		/* ceph_entity_addr might be misaligned, so we have to
+		 * parse to a stack variable first
+		 */
+		memcpy(&addr->in_addr, &stor, sizeof(stor));
+
+		/* return the end of the parsed portion to the caller on success */
+		if (ipend)
+			*ipend = str + len;
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 /*
@@ -1302,7 +1346,7 @@ static int ceph_parse_server_name(const char *name, size_t namelen,
 	int ret;
 
 	ret = ceph_pton(name, namelen, addr, delim, ipend);
-	if (ret)
+	if (ret == -EINVAL)
 		ret = ceph_dns_resolve_name(name, namelen, addr, delim, ipend);
 
 	return ret;
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index c9e002d96319..309bca24b82f 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -708,8 +708,7 @@ static int process_banner(struct ceph_connection *con)
 	 * end may not yet know their ip address, so if it's 0.0.0.0, give
 	 * them the benefit of the doubt.
 	 */
-	if (memcmp(&con->peer_addr, &con->v1.actual_peer_addr,
-		   sizeof(con->peer_addr)) != 0 &&
+	if (!ceph_addr_equal_no_scope(&con->peer_addr, &con->v1.actual_peer_addr) &&
 	    !(ceph_addr_is_blank(&con->v1.actual_peer_addr) &&
 	      con->v1.actual_peer_addr.nonce == con->peer_addr.nonce)) {
 		pr_warn("wrong peer, want %s/%u, got %s/%u\n",
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 05f6eea299fc..dbcf20d623a7 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2504,7 +2504,7 @@ static int process_server_ident(struct ceph_connection *con,
 	     global_id, global_seq, features, required_features, flags, cookie);
 
 	/* is this who we intended to talk to? */
-	if (memcmp(&addr, &con->peer_addr, sizeof(con->peer_addr))) {
+	if (!ceph_addr_equal_no_scope(&addr, &con->peer_addr)) {
 		pr_err("bad peer addr/nonce, want %s/%u, got %s/%u\n",
 		       ceph_pr_addr(&con->peer_addr),
 		       le32_to_cpu(con->peer_addr.nonce),
-- 
2.47.3

