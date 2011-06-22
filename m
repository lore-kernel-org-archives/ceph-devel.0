From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 3/3] msgr: Send keepalive periodically when waiting in
 policy throttler
Date: Wed, 22 Jun 2011 12:26:27 -0600
Message-ID: <1308767187-10376-5-git-send-email-jaschut@sandia.gov>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53424 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758541Ab1FVS1F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2011 14:27:05 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 199D7173225
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:27:03 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:26:53 -0600
In-Reply-To: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Cause read_message() to periodically send a keepalive while waiting
in the policy throttler.  Clients can then notice that a connection
is still active, and avoid resetting it when a message times out.

Without this patch, when clients are offering a sustained write
load that is higher than the sustained bandwidth available from the
OSDs, messages time out continuously due to the OSDs being busy.

That has at least two types of impact:

- the reset frequently happens while data is being sent, so data
  that was successfully received must be discarded and resent.

- after several such connection resets, many sockets can remain open,
  waiting for readers to be granted space by the policy throttler,
  so that they can notice that the pipe has been shut down, and the
  socket can be closed.

This patch, combined with the companion kernel client patch, also has
the operational impact of eliminating client log messages about
resetting OSDs under normal operation with a heavy write load, which
makes it easier to notice other issues in the client logs.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/config.cc       |    1 +
 src/common/config.h        |    1 +
 src/msg/SimpleMessenger.cc |    6 +++++-
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/common/config.cc b/src/common/config.cc
index ca359a3..86b1917 100644
--- a/src/common/config.cc
+++ b/src/common/config.cc
@@ -183,6 +183,7 @@ struct config_option config_optionsp[] = {
   OPTION(ms_tcp_nodelay, OPT_BOOL, true),
   OPTION(ms_initial_backoff, OPT_DOUBLE, .2),
   OPTION(ms_max_backoff, OPT_DOUBLE, 15.0),
+  OPTION(ms_reader_keepalive, OPT_INT, 30),  // seconds, readers blocked in throttler send keepalive this often
   OPTION(ms_nocrc, OPT_BOOL, false),
   OPTION(ms_die_on_bad_msg, OPT_BOOL, false),
   OPTION(ms_dispatch_throttle_bytes, OPT_U64, 100 << 20),
diff --git a/src/common/config.h b/src/common/config.h
index 1a389d9..5ea0f69 100644
--- a/src/common/config.h
+++ b/src/common/config.h
@@ -211,6 +211,7 @@ public:
   bool ms_tcp_nodelay;
   double ms_initial_backoff;
   double ms_max_backoff;
+  int ms_reader_keepalive;
   bool ms_nocrc;
   bool ms_die_on_bad_msg;
   uint64_t ms_dispatch_throttle_bytes;
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 321c55a..2a533be 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1876,10 +1876,14 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
   uint64_t message_size = header.front_len + header.middle_len + header.data_len;
   if (message_size) {
     if (policy.throttler) {
+      utime_t kato = utime_t(g_conf.ms_reader_keepalive, 0);
       dout(10) << "reader wants " << message_size << " from policy throttler "
 	       << policy.throttler->get_current() << "/"
 	       << policy.throttler->get_max() << dendl;
-      policy.throttler->get(message_size);
+      while (!policy.throttler->timed_get(kato, message_size)) {
+	dout(20) << "sending keepalive while waiting for policy throttler" << dendl;
+	send_keepalive();
+      }
     }
 
     // throttle total bytes waiting for dispatch.  do this _after_ the
-- 
1.7.1


