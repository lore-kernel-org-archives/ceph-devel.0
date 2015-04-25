From: Sage Weil <sweil@redhat.com>
Subject: Re: running daemons as user/group ceph
Date: Sat, 25 Apr 2015 10:26:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504251020410.28845@cobra.newdream.net>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AAFFB.4070808@redhat.com> <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net> <553AC41E.80100@redhat.com> <alpine.DEB.2.00.1504241630050.5458@cobra.newdream.net>
 <553B43B2.2070102@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42415 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031625AbbDYR0k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 25 Apr 2015 13:26:40 -0400
In-Reply-To: <553B43B2.2070102@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Sat, 25 Apr 2015, Danny Al-Gaaf wrote:
> Am 25.04.2015 um 01:34 schrieb Sage Weil:
> > On Fri, 24 Apr 2015, Ken Dreyer wrote:
> >> Oh, my bad, sorry I missed that part of the pull request! Looks good to me.
> > 
> > Still missing ceph.spec file changes, if you're up for it.  :)
> 
> I can change the spec files, but do we have finally some user/group IDs
> for RHEL/Fedora and SLE/openSUSE?

Not yet, but I think the specfile should have a generic adduser (or 
whatever) that just allocates a uid for distros where the uid isn't 
preallocated; using the fixed uid will be a conditional special case for 
those distros where it is fixed.

> > I'm working on the chown piece, but I'm not sure what to do about the 
> > journal device (if it is a device).  We can either
> > 
> >  - add ceph to the 'disk' group.  This means it can scribble on any device 
> > in the system, which seems less than ideal.
> 
> I wouldn't do that. Especially from the security perspective.

Yeah

> >  - chown the journal device to ceph when the daemon is started.  This 
> > means the user can only scribble on other ceph devices, which seems about 
> > right.  But I'm not sure what the implications of chowning random devices 
> > like /dev/sdc2 to ceph are.
> 
> Not sure if this is what we want or that this is the "usual" way to
> handle these issues.

It's certainly the simplest, it if passes muster...

> >  - do something tricky where we open the block device on startup before 
> > doing the setuid, and reuse that file handle later.  This likely screws up 
> > all kinds layering because we want the privs to drop very eary (before we 
> > start opening log files, for example) and only the journal code knows what 
> > mode to open the file as.  Any solution here will be kind of kludgey, I 
> > think.
> 
> The log files are not the issue here I guess since you can set the
> correct permissions outside of the daemons. If an OSD need to open a
> device it would be appropriate to open the device as root before
> dropping the privileges. The code shouldn't be that complicated we did
> such things e.g. in hald before.

I'm just worried that if we open(O_CREAT) the log files before dropping 
privs then they'll be owned by root instead of ceph.  And that any other 
random stuff that happens in the relatively long gap between start and 
opening the FileStore's journal will have elevated privs and create files 
(pid file, admin socket file in /var/run/ceph, etc.).  And special casing 
moving the journal open to the beginning will be tricky because the 
ObjectStore is pluggable, and because we have to do the FileStore init 
(including thread creation etc) after the fork.

> Another issue: there is the --enable-root-make-check configure option. I 
> didn't take a look at the code yet, but does anybody know if these tests 
> refer to something that needs root privileges within the daemons or is 
> it due to testing something (like e.g. mount rbd's)?

I suspect it's the ceph-disk tests?

sage

