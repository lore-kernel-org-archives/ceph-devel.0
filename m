From: Sage Weil <sweil@redhat.com>
Subject: wip-user status
Date: Tue, 4 Aug 2015 13:53:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508041335370.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbbHDUxj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 16:53:39 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id BD6815F
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2015 20:53:39 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: branto@redhat.com, mbroz@redhat.com

I rebased the wip-user patches from wip-selinux-policy onto 
wip-selinux-policy-no-user + merge to master so that it sits on top of the 
newly-merged systemd changes.

Notes/issues:

 - ceph-osd-prestart.sh verifies that the osd_data dir is owned by either 
'root' or 'ceph' or else it exits with an error.  (Presumably systemd will 
fail to start the unit in this case.)  It prints a helpful message 
pointing the user at 'ceph-disk chown ...'.

 - 'ceph-disk chown ...' is not implemented yet.  Should it take the base 
device, like activate and prepare?  Or a mounted path?  Or either?

 - Currently ceph-osd@.service unconditionally passes --setuser ceph to 
ceph-osd... even if the data directory is owned by root.  I don't think 
systemd is smart enough to do this conditionally unless we make an ugly 
wrapper script that starts ceph-osd.  Alternatively, we could make 
ceph-osd conditionally do the setuid based on the ownership of the 
directory, but... meh.  The idea was to do the setuid *very* early in the 
startup process so that logging and so on are opened as the ceph user.  
Ideas?

I think that's it right now...

	https://github.com/ceph/ceph/commits/wip-user

sage
