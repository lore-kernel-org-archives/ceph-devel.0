From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/5] crush: allow crush rules to set (re)tries counts to 0
Date: Wed, 19 Mar 2014 18:09:06 +0200
Message-ID: <1395245349-4513-3-git-send-email-ilya.dryomov@inktank.com>
References: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39570 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965667AbaCSQJR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 12:09:17 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so6678442eei.5
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 09:09:16 -0700 (PDT)
Received: from localhost ([109.110.66.126])
        by mx.google.com with ESMTPSA id w6sm55563017eex.9.2014.03.19.09.09.15
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 09:09:16 -0700 (PDT)
In-Reply-To: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These two fields are misnomers; they are *retry* counts.

Reflects ceph.git commit f17caba8ae0cad7b6f8f35e53e5f73b444696835.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 074bb2a5e675..b3fb84903b30 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -684,12 +684,12 @@ int crush_do_rule(const struct crush_map *map,
 			break;
 
 		case CRUSH_RULE_SET_CHOOSE_LOCAL_TRIES:
-			if (curstep->arg1 > 0)
+			if (curstep->arg1 >= 0)
 				choose_local_retries = curstep->arg1;
 			break;
 
 		case CRUSH_RULE_SET_CHOOSE_LOCAL_FALLBACK_TRIES:
-			if (curstep->arg1 > 0)
+			if (curstep->arg1 >= 0)
 				choose_local_fallback_retries = curstep->arg1;
 			break;
 
-- 
1.7.10.4

