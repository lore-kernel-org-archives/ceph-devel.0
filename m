From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph updates for 2.6.37-rc6
Date: Thu, 9 Dec 2010 09:55:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012011431410.6260@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58817 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab0LIRu6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Dec 2010 12:50:58 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is a readdir NULL dereference after llseeking to odd offsets, 
several fixes for flock/fcntl locks, and a fix for the ioctl magic value 
that crept into -rc1.

Thanks!
sage


Herb Shiu (3):
      ceph: Handle file locks in replies from the MDS.
      ceph: pass lock information by struct file_lock instead of as individual params.
      ceph: Behave better when handling file lock replies.

Sage Weil (2):
      ceph: avoid possible null deref in readdir after dir llseek
      ceph: fix ioctl magic

 fs/ceph/dir.c        |    4 +-
 fs/ceph/ioctl.h      |    2 +-
 fs/ceph/locks.c      |   94 ++++++++++++++++++++++++++-----------------------
 fs/ceph/mds_client.c |   41 +++++++++++++++++++--
 fs/ceph/mds_client.h |   31 +++++++++++-----
 5 files changed, 111 insertions(+), 61 deletions(-)
