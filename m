From: Sage Weil <sweil@redhat.com>
Subject: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 10:37:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42650 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966549AbbDXRiD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 13:38:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kdreyer@redhat.com, danny.al-gaaf@bisect.de
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

I started to put together patches to create a ceph user and group.  
You can see them here:

	https://github.com/ceph/ceph/pull/4456

For now I just did the debian bits.  Hopefully someone more familiar with 
rpms can do the spec file?

I put in the UID Ken mentioned for Debian.  Has that been allocated yet?

On package install it chowns /var/lib/ceph to the ceph user.  I don't want 
to do a recursive chown because there may be an unbounded amount of data 
there (and a running daemon).  Instead the packages make themselves 
responsible for chowning /var/lib/ceph and the first level of subdirs.  
The mode is 750; I'm not sure it really matters what the ceph 
group can do here.

-- Logs --

The /var/log/ceph directory is trickier.  We also chown it, but I set the 
mode with

 chmod u=rwx,g=rxs,o= /var/log/ceph

The idea is to allow members of the ceph group to log to this directory.  
For example, qemu could be added to group ceph so that when it links 
librbd the client logs will show up here.  (Same goes for /var/run/ceph 
and the admin socket.)  But it also means that daemon logs become 
writeable by that user.  Maybe the log file mode should be 700 so that 
everyone can create files here but not modify others' logs?  Or is the 
idea of letting librados users log here just a bad idea?

On test case is radosgw, which currently logs to /var/log/radosgw but I 
would like to change to log to /var/log/ceph if we can for simplicity.  
It will run as the ceph user, though, whereas something like qemu would 
not.  What about an 'rbd' or 'ceph' CLI user?  Should that log to 
/var/log/ceph?  Only if the user is in the ceph group?

-- systemd --

Most of the daemons can just get the User=ceph and Group=cpeh lines in the 
unit files.  The OSD is tricky, though, since we want the prestart script 
to run as root so that it can chown the disk contents if necessary.  We 
have two options, I think:

1) run prestart and ceph-osd as root, and add a ceph daemon arg to drop 
privileges and setuid.

2) add a sudo rule so that the ceph user can run the chown command from 
prestart.  (This seems more dangerous.)

Thoughts?

sage
