From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] running daemons as user/group ceph
Date: Fri, 24 Apr 2015 15:29:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504241527540.5458@cobra.newdream.net>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AAFFB.4070808@redhat.com> <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967091AbbDXW3E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 18:29:04 -0400
In-Reply-To: <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Fri, 24 Apr 2015, Sage Weil wrote:
> > > -- systemd --
> > > 
> > > Most of the daemons can just get the User=ceph and Group=cpeh lines in the 
> > > unit files.  The OSD is tricky, though, since we want the prestart script 
> > > to run as root so that it can chown the disk contents if necessary.  We 
> > > have two options, I think:
> > > 
> > > 1) run prestart and ceph-osd as root, and add a ceph daemon arg to drop 
> > > privileges and setuid.
> > > 
> > > 2) add a sudo rule so that the ceph user can run the chown command from 
> > > prestart.  (This seems more dangerous.)
> > 
> > I agree sudo sounds more dangerous, and it'll also be more complex to
> > implement in the packaging.
> > 
> > Would it be possible to use Apache's model, where it does the bare
> > minimum set of things it needs as root (binding to port 80, etc), and
> > then drops privileges thereafter?
> > 
> > If the OSD had this ability built-in, then it could run in minimal
> > environments like containers where sudo is not present, etc.
> 
> Yeah. And in this case, it's only the ceph-osd-prestart.sh script (run by 
> systemd) that needs root; the ceph-osd can drop privileges immediately 
> upon starting.

Pushed a patch that lets daemons drop privs (setuid and setgid) and 
updated the ceph-osd unit file accordingly.

Also added a /etc/security/limits.d/ceph file so that we can set the 
nofile ulimit in one place where people expect it and not in our configs 
or the systemd/upstart configs.

sage
