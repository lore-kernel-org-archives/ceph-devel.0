From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fix for -rc3
Date: Mon, 11 Mar 2013 16:31:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303111630130.26131@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This fixes a bug in the new message decoding that just went in during the 
last window.

Thanks!
sage


----------------------------------------------------------------
Sage Weil (1):
      libceph: fix decoding of pgids

 net/ceph/osdmap.c |   42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)
