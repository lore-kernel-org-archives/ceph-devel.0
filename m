From: Sage Weil <sweil@redhat.com>
Subject: Re: wip-user status
Date: Thu, 6 Aug 2015 07:24:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508060722140.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1508041335370.22099@cobra.newdream.net> <55C1B98F.2020807@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39337 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbbHGCj0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Aug 2015 22:39:26 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id EC65391596
	for <ceph-devel@vger.kernel.org>; Fri,  7 Aug 2015 02:39:25 +0000 (UTC)
In-Reply-To: <55C1B98F.2020807@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milan Broz <mbroz@redhat.com>
Cc: ceph-devel@vger.kernel.org, branto@redhat.com

On Wed, 5 Aug 2015, Milan Broz wrote:
> On 08/04/2015 10:53 PM, Sage Weil wrote:
> > I rebased the wip-user patches from wip-selinux-policy onto 
> > wip-selinux-policy-no-user + merge to master so that it sits on top of the 
> > newly-merged systemd changes.
> 
> Great, so if it is build-ready state, I can try it with our virtual 
> cluster install.
> 
> > Notes/issues:
> > 
> >  - ceph-osd-prestart.sh verifies that the osd_data dir is owned by either 
> > 'root' or 'ceph' or else it exits with an error.  (Presumably systemd will 
> > fail to start the unit in this case.)  It prints a helpful message 
> > pointing the user at 'ceph-disk chown ...'.
> > 
> >  - 'ceph-disk chown ...' is not implemented yet.  Should it take the base 
> > device, like activate and prepare?  Or a mounted path?  Or either?
> 
> It should be easy to convert device/mountpoint by using findmnt so I would
> prefer what is more consistent with the user interface...
> 
> IIRC, if the parameter is a base device, what should happen if device is not mounted?
> If mount path - then what about other data/journal partitions?
> 
> It seems to me that parameter could be base OSD device and chown will 
> simply handle all its partitions. (So for encrypted OSD it needs to get 
> key to unlock it etc...)

This sounds like the cleanest approach to me too.

> >  - Currently ceph-osd@.service unconditionally passes --setuser ceph to 
> > ceph-osd... even if the data directory is owned by root.  I don't think 
> > systemd is smart enough to do this conditionally unless we make an ugly 
> > wrapper script that starts ceph-osd.  Alternatively, we could make 
> > ceph-osd conditionally do the setuid based on the ownership of the 
> > directory, but... meh.  The idea was to do the setuid *very* early in the 
> > startup process so that logging and so on are opened as the ceph user.  
> > Ideas?
> 
> Well, systemd could do that if the service is generated (like e.g. cryptsetup
> activation jobs are generated according to crypttab). But this adds complexity
> that we do not need...
> 
> Maybe another option is to use environment variable (CEPH_USER or so), set it
> in service Environment=/EnvironmentFile... and ceph-osd will use that...
> 
> But I think some systemd gurus will find something better here:)

Take a look at

	https://github.com/ceph/ceph/pull/5494

The idea is to just make the setuid in the daemon conditional on a path in 
the file system matching the uid/gid.  If they match, we drop privs.  If 
they don't, we print a warning and remain root.

This doesn't "handle" the case where the daemon data dir is owned by 
something other than ceph or root.  It will work just fine (the 
daemon will run as root), but perhaps we want fail in that case?  The 
OSD has an explicit check for this in ceph-osd-prestart.sh asking the 
admin to ceph-disk chown, but the other daemons don't have prestarts.  
They also generally won't have mismatche ownership because they generally 
won't get swapped around between hosts...

sage
