From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 22:16:17 +0200
Message-ID: <553AA491.6040409@bisect.de>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:42677 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756096AbbDXUgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 16:36:07 -0400
In-Reply-To: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, kdreyer@redhat.com
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

Am 24.04.2015 um 19:37 schrieb Sage Weil:
[...]
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
> 
> Thoughts?

Do we need to change the start scripts for SysV init? Or is this
something we should ignore because the most distros will use systemd in
the future.

Danny

