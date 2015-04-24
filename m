From: Sage Weil <sweil@redhat.com>
Subject: Re: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 16:34:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504241630050.5458@cobra.newdream.net>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AAFFB.4070808@redhat.com> <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net> <553AC41E.80100@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372AbbDXXe5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 19:34:57 -0400
In-Reply-To: <553AC41E.80100@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: danny.al-gaaf@bisect.de, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Fri, 24 Apr 2015, Ken Dreyer wrote:
> Oh, my bad, sorry I missed that part of the pull request! Looks good to me.

Still missing ceph.spec file changes, if you're up for it.  :)

I'm working on the chown piece, but I'm not sure what to do about the 
journal device (if it is a device).  We can either

 - add ceph to the 'disk' group.  This means it can scribble on any device 
in the system, which seems less than ideal.

 - chown the journal device to ceph when the daemon is started.  This 
means the user can only scribble on other ceph devices, which seems about 
right.  But I'm not sure what the implications of chowning random devices 
like /dev/sdc2 to ceph are.

 - do something tricky where we open the block device on startup before 
doing the setuid, and reuse that file handle later.  This likely screws up 
all kinds layering because we want the privs to drop very eary (before we 
start opening log files, for example) and only the journal code knows what 
mode to open the file as.  Any solution here will be kind of kludgey, I 
think.

?

sage
