From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH v2 0/1] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Mon, 16 May 2011 10:57:52 -0600
Message-ID: <1305565073-9976-1-git-send-email-jaschut@sandia.gov>
References: <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:48540 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab1EPQ6k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2011 12:58:40 -0400
In-Reply-To: <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

Changes since v1:

If try_write() needs to re-open a connection when there is
a message send in progress, just requeue it.  This is more
robust, since it handles all possible ways the connection
could have gotten to that state.


Jim Schutt (1):
  libceph: fix handle_timeout() racing with con_work()/try_write()

 net/ceph/messenger.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)


