From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 2.6.36
Date: Fri, 8 Oct 2010 11:02:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010081058420.7972@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34177 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab0JHSA3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 14:00:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are a couple NFS filehandle encoding fixes, a list_add argument 
order fix, a null deref in an error path, and two MDS protocol fixes (a 
variable update that was missed and an extra flush to avoid unnecessary 
delay in certain cases).

Thanks!
sage


Aneesh Kumar K.V (2):
      ceph: Fix return value of encode_fh function
      ceph: Update max_len with minimum required size

Greg Farnum (1):
      ceph: send cap release message early on failed revoke.

Henry C Chang (1):
      ceph: fix list_add usage on unsafe_writes list

Sage Weil (2):
      ceph: avoid null deref in osd request error path
      ceph: update issue_seq on cap grant

 fs/ceph/caps.c       |   31 ++++++++++++++++++-------------
 fs/ceph/export.c     |   21 +++++++++++++--------
 fs/ceph/file.c       |    2 +-
 fs/ceph/osd_client.c |    2 +-
 4 files changed, 33 insertions(+), 23 deletions(-)
