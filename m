From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 15:04:59 -0600
Message-ID: <553AAFFB.4070808@redhat.com>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50172 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756186AbbDXVFI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 17:05:08 -0400
In-Reply-To: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, danny.al-gaaf@bisect.de
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On 04/24/2015 11:37 AM, Sage Weil wrote:
> -- Logs --
> 

One other thing in addition to the log directory is the socket directory
permissions (/var/run/ceph). The ceph UID will need to write there, right?

In newer distros with systemd, /var/run is on tmpfs so we use this
tmpfiles.d snippet to be sure the directory is there in /var/tmpfs after
every boot:

https://github.com/ceph/ceph/blob/master/systemd/ceph.tmpfiles.d

The snippet currently creates the directory as root-owned, and I imagine
we'd want to change that to the ceph UID instead?

> -- systemd --
> 
> Most of the daemons can just get the User=ceph and Group=cpeh lines in the 
> unit files.  The OSD is tricky, though, since we want the prestart script 
> to run as root so that it can chown the disk contents if necessary.  We 
> have two options, I think:
> 
> 1) run prestart and ceph-osd as root, and add a ceph daemon arg to drop 
> privileges and setuid.
> 
> 2) add a sudo rule so that the ceph user can run the chown command from 
> prestart.  (This seems more dangerous.)

I agree sudo sounds more dangerous, and it'll also be more complex to
implement in the packaging.

Would it be possible to use Apache's model, where it does the bare
minimum set of things it needs as root (binding to port 80, etc), and
then drops privileges thereafter?

If the OSD had this ability built-in, then it could run in minimal
environments like containers where sudo is not present, etc.

- Ken
