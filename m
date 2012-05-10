From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 0/2] Ceph tracepoints
Date: Thu, 10 May 2012 08:35:54 -0600
Message-ID: <1336660556-6943-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35957 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2EJOgd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 10:36:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@dreamhost.com
Cc: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

Hi Alex,

I ran across tracker #2374 today - I've been carrying these two
tracepoint patches for a while.  Perhaps you'll find them useful.

Jim Schutt (2):
  ceph: add tracepoints for message submission on read/write requests
  ceph: add tracepoints for message send queueing and completion, reply
    handling

 fs/ceph/addr.c              |    8 +++
 fs/ceph/file.c              |    6 ++
 include/trace/events/ceph.h |  144 +++++++++++++++++++++++++++++++++++++++++++
 net/ceph/messenger.c        |    9 +++-
 net/ceph/osd_client.c       |    8 +++
 5 files changed, 174 insertions(+), 1 deletions(-)
 create mode 100644 include/trace/events/ceph.h

-- 
1.7.8.2


