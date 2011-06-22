From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 0/3] RFC: Enable clients to distinguish busy and
 unreachable OSDs
Date: Wed, 22 Jun 2011 12:26:23 -0600
Message-ID: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53392 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021Ab1FVS07 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2011 14:26:59 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 10FAF173225
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:26:57 -0600 (MDT)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:26:48 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Previously, when clients' sustained offered write load exceeded the
sustained throughput of the OSDs, normal operation was that client
messages timed out while waiting to be processed by the OSDs.  The
client response to this was to reset the connection to the OSD
handling a timed-out message.

That has at least two types of impact:
    
- the reset frequently happens while data is being sent, so data
  that was successfully received must be discarded and resent.

- after several such connection resets, many sockets can remain open,
  waiting for readers to be granted space by the policy throttler,
  so that they can notice that the pipe has been shut down, and the
  socket can be closed.

This patchset causes Ceph OSDs to send keepalives when waiting for 
sufficient buffer space to receive a message from a client. There is
also a companion kernel client patch that causes clients to notice
the keepalives, and not reset a connection serving a timed-out
message if anything, particularly a keepalive, has been received
recently.

This patchset also has the operational impact of eliminating client log
messages about resetting OSDs under normal operation with a heavy write
load, which makes it easier to notice other issues in the client logs.


Jim Schutt (3):
  common/Throttle: Remove unused return type on Throttle::get()
  common/Throttle: Add timed_wait().
  msgr: Send keepalive periodically when waiting in policy throttler

 src/common/Throttle.h      |   45 +++++++++++++++++++++++++++++++++++++++++--
 src/common/config.cc       |    1 +
 src/common/config.h        |    1 +
 src/msg/SimpleMessenger.cc |    6 ++++-
 4 files changed, 49 insertions(+), 4 deletions(-)


