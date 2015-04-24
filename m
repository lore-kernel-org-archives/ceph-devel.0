From: Sage Weil <sweil@redhat.com>
Subject: Re: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 14:13:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AAFFB.4070808@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52486 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932462AbbDXVNJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 17:13:09 -0400
In-Reply-To: <553AAFFB.4070808@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: danny.al-gaaf@bisect.de, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Fri, 24 Apr 2015, Ken Dreyer wrote:
> On 04/24/2015 11:37 AM, Sage Weil wrote:
> > -- Logs --
> > 
> 
> One other thing in addition to the log directory is the socket directory
> permissions (/var/run/ceph). The ceph UID will need to write there, right?
> 
> In newer distros with systemd, /var/run is on tmpfs so we use this
> tmpfiles.d snippet to be sure the directory is there in /var/tmpfs after
> every boot:
> 
> https://github.com/ceph/ceph/blob/master/systemd/ceph.tmpfiles.d
> 
> The snippet currently creates the directory as root-owned, and I imagine
> we'd want to change that to the ceph UID instead?

Yeah, I changed that file.  Again, not certain about the group permissions 
bit, though.

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
> 
> I agree sudo sounds more dangerous, and it'll also be more complex to
> implement in the packaging.
> 
> Would it be possible to use Apache's model, where it does the bare
> minimum set of things it needs as root (binding to port 80, etc), and
> then drops privileges thereafter?
> 
> If the OSD had this ability built-in, then it could run in minimal
> environments like containers where sudo is not present, etc.

Yeah. And in this case, it's only the ceph-osd-prestart.sh script (run by 
systemd) that needs root; the ceph-osd can drop privileges immediately 
upon starting.

sage
