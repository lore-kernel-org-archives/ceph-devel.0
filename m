From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: running daemons as user/group ceph
Date: Sat, 25 Apr 2015 09:35:14 +0200
Message-ID: <553B43B2.2070102@bisect.de>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AAFFB.4070808@redhat.com> <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net> <553AC41E.80100@redhat.com> <alpine.DEB.2.00.1504241630050.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:38124 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955AbbDYHfS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 25 Apr 2015 03:35:18 -0400
In-Reply-To: <alpine.DEB.2.00.1504241630050.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

Am 25.04.2015 um 01:34 schrieb Sage Weil:
> On Fri, 24 Apr 2015, Ken Dreyer wrote:
>> Oh, my bad, sorry I missed that part of the pull request! Looks good to me.
> 
> Still missing ceph.spec file changes, if you're up for it.  :)

I can change the spec files, but do we have finally some user/group IDs
for RHEL/Fedora and SLE/openSUSE?

> I'm working on the chown piece, but I'm not sure what to do about the 
> journal device (if it is a device).  We can either
> 
>  - add ceph to the 'disk' group.  This means it can scribble on any device 
> in the system, which seems less than ideal.

I wouldn't do that. Especially from the security perspective.

>  - chown the journal device to ceph when the daemon is started.  This 
> means the user can only scribble on other ceph devices, which seems about 
> right.  But I'm not sure what the implications of chowning random devices 
> like /dev/sdc2 to ceph are.

Not sure if this is what we want or that this is the "usual" way to
handle these issues.

>  - do something tricky where we open the block device on startup before 
> doing the setuid, and reuse that file handle later.  This likely screws up 
> all kinds layering because we want the privs to drop very eary (before we 
> start opening log files, for example) and only the journal code knows what 
> mode to open the file as.  Any solution here will be kind of kludgey, I 
> think.

The log files are not the issue here I guess since you can set the
correct permissions outside of the daemons. If an OSD need to open a
device it would be appropriate to open the device as root before
dropping the privileges. The code shouldn't be that complicated we did
such things e.g. in hald before.

Another issue: there is the --enable-root-make-check configure option. I
didn't take a look at the code yet, but does anybody know if these tests
refer to something that needs root privileges within the daemons or is
it due to testing something (like e.g. mount rbd's)?

Danny
