From: Sage Weil <sweil@redhat.com>
Subject: Re: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 13:52:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504241349570.5458@cobra.newdream.net>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AA491.6040409@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031356AbbDXUxC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 16:53:02 -0400
In-Reply-To: <553AA491.6040409@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: kdreyer@redhat.com, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Fri, 24 Apr 2015, Danny Al-Gaaf wrote:
> Am 24.04.2015 um 19:37 schrieb Sage Weil:
> [...]
> > -- systemd --
> > 
> > Most of the daemons can just get the User=ceph and Group=cpeh lines in the 
> > unit files.  The OSD is tricky, though, since we want the prestart script 
> > to run as root so that it can chown the disk contents if necessary.  We 
> > have two options, I think:
> > 
> > 1) run prestart and ceph-osd as root, and add a ceph daemon arg to drop 
> > privileges and setuid.
> > 
> > 2) add a sudo rule so that the ceph user can run the chown command from 
> > prestart.  (This seems more dangerous.)
> > 
> > Thoughts?
> 
> Do we need to change the start scripts for SysV init? Or is this
> something we should ignore because the most distros will use systemd in
> the future.

We could, but I wonder if not touching upstart or sysvinit will be an 
easy way to handle migration/compat issues.

One other thing Greg brought up today was that we should allow an admin to 
configure daemons to run as root if they want.  They can do that by 
editing the unit files; I'm not sure if we want to do something more 
friendly than that?  (FWIW I think this is basically what Leannart 
suggests.)

sage
