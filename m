From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 1/6] msgr: print message sequence number and tid
 when receiving message envelope
Date: Wed,  1 Feb 2012 08:54:23 -0700
Message-ID: <1328111668-10068-2-git-send-email-jaschut@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:39001 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597Ab2BAQMg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:12:36 -0500
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 18CA517A6B3
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 08:55:19 -0700 (MST)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 08:55:02 -0700
In-Reply-To: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

This simplifies post-processing logs to discover how long messages
are delayed waiting in the policy throttler.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/msg/SimpleMessenger.cc |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 246fa3e..952ed7c 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1873,6 +1873,8 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
 
   ldout(msgr->cct,20) << "reader got envelope type=" << header.type
            << " src " << entity_name_t(header.src)
+	   << " seq=" << header.seq
+	   << " tid=" << header.tid
            << " front=" << header.front_len
 	   << " data=" << header.data_len
 	   << " off " << header.data_off
-- 
1.7.1


