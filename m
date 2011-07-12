From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] crushtool: Add call to global_init() to avoid dout
 segfault
Date: Tue, 12 Jul 2011 16:20:59 -0600
Message-ID: <1310509259-29635-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:44272 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990Ab1GLWVZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2011 18:21:25 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1E87B268524
	for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2011 16:21:23 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2011 16:21:14 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/crushtool.cc |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/crushtool.cc b/src/crushtool.cc
index f2a35f9..336d456 100644
--- a/src/crushtool.cc
+++ b/src/crushtool.cc
@@ -845,6 +845,10 @@ int main(int argc, const char **argv)
   map<int, int> device_weight;
   DEFINE_CONF_VARS(usage);
 
+  global_init(args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY,
+	      CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
+  common_init_finish(g_ceph_context);
+
   FOR_EACH_ARG(args) {
     if (CEPH_ARGPARSE_EQ("clobber", '\0')) {
       clobber = true;
-- 
1.7.1


