From: Sage Weil <sweil@redhat.com>
Subject: running as non-root
Date: Sat, 6 Dec 2014 10:43:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412061039550.18213@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54109 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbaLFSnd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 6 Dec 2014 13:43:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

While we are on the subject of init systems and packaging, I would *love* 
to fix things up for hammer to

 - create a ceph user and group
 - add various users to ceph group (like qemu or kvm user and 
apache/www-data?)
 - fix permissions on /var/log/ceph and /var/run/ceph (770?) so that qemu 
and rgw can write logs and asok files there
 - make daemons run as ceph user instead of root

The main hangup is with that last one.  As I understand it, when packages 
create users, they get a semi-random UID assigned.  That means that all 
the data on a ceph-osd disk would have a semi-random UID.  If it were 
hot-swapped into another host, the uid would be wrong.  Is there a way 
use a fixed uid?

Also on the roadmap is defining proper selinux policies so that these 
dameons are confined into the appropriate directories etc., but I imagine 
running as non-root is a big help (or even prerequisite?) to making that 
happen?

Suggestions or comments?  Or volunteers?  We haven't had time to look at 
this yet but I think it's important!

sage

