From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 6/6] ceph.spec.in: fix file section for ceph-resource-agents
Date: Wed, 30 Jan 2013 19:00:45 +0100
Message-ID: <1359568845-7634-7-git-send-email-danny.al-gaaf@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51049 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756613Ab3A3SAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:00:48 -0500
In-Reply-To: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Create needed dirs (/usr/lib/ocf/resource.d/ceph) for the ceph-resource-agents
subpackage.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ceph.spec.in b/ceph.spec.in
index 0db7792..668edca 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -446,6 +446,9 @@ fi
 %if %{with ocf}
 %files resource-agents
 %defattr(0755,root,root,-)
+%dir /usr/lib/ocf
+%dir /usr/lib/ocf/resource.d
+%dir /usr/lib/ocf/resource.d/ceph
 /usr/lib/ocf/resource.d/%{name}/*
 %endif
 
-- 
1.8.1.1

