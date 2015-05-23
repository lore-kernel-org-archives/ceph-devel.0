From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc5
Date: Fri, 22 May 2015 17:13:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505221711390.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git 

These fix an issue with the RBD notifications when there are topology 
changes in the cluster.

Thanks!
sage


----------------------------------------------------------------
Ilya Dryomov (2):
      libceph: request a new osdmap if lingering request maps to no osd
      Revert "libceph: clear r_req_lru_item in __unregister_linger_request()"

 net/ceph/osd_client.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)
