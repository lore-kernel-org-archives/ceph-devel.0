From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fix for 2.6.39-rc4
Date: Thu, 14 Apr 2011 10:03:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104060950440.18205@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46873 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab1DNRAX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 13:00:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This might be the first time I've only had a single bug fix to push!  
This fixes a null dereference on RBD when an osd daemon restarts.  The 
patch in the last pull didn't get it quite right.

Thanks-
sage


Sage Weil (1):
      libceph: fix linger request requeueing

 net/ceph/osd_client.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)
