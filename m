From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Final ceph bits for 3.6
Date: Thu, 2 Aug 2012 09:33:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208020917130.14099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38710 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab2HBQdS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 12:33:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull these last two patches from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

The first patch fixes up the old crufty open intent code to use the 
atomic_open stuff properly, and the second fixes a possible null deref and 
memory leak with the crypto keys.

Thanks!
sage

----------------------------------------------------------------
Sage Weil (1):
      ceph: simplify+fix atomic_open

Sylvain Munaut (1):
      libceph: fix crypto key null deref, memory leak

 fs/ceph/dir.c     |   38 --------------------------------
 fs/ceph/file.c    |   62 ++++++++++++++++++++++++++++++++---------------------
 fs/ceph/super.h   |    6 +++---
 net/ceph/crypto.c |    1 +
 net/ceph/crypto.h |    3 ++-
 5 files changed, 43 insertions(+), 67 deletions(-)
