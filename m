From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fix for -rc8
Date: Tue, 7 Apr 2015 09:46:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504070943100.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following patch from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This corrects a recent misadventure with __GFP_MEMALLOC and PF_MEMALLOC; 
it turns out it's not a good fit for RBD and we're better off relying on 
dirty page throttling.

Thanks!
sage


----------------------------------------------------------------
Ilya Dryomov (1):
      Revert "libceph: use memalloc flags for net IO"

 net/ceph/messenger.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)
