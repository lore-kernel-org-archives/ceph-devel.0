From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 3.2 final
Date: Thu, 29 Dec 2011 20:50:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112281837400.18151@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48394 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab1L3Eu5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 23:50:57 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull this Ceph patch from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are a few lingering issues in Ceph's use of the dcache for readdir 
that we weren't able to nail down, so this patch disables it for now.  
There will be a series of patches for the next release that reenable this 
(via a mount option) and clean things up a bit.

Thanks!
sage


Sage Weil (1):
      ceph: disable use of dcache for readdir etc.

 fs/ceph/dir.c |   29 +++--------------------------
 1 files changed, 3 insertions(+), 26 deletions(-)
