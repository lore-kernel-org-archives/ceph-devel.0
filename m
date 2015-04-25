From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: running daemons as user/group ceph
Date: Sat, 25 Apr 2015 09:22:30 +0200
Message-ID: <553B40B6.9010700@bisect.de>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AA491.6040409@bisect.de> <alpine.DEB.2.00.1504241349570.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34500 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755305AbbDYHWe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 25 Apr 2015 03:22:34 -0400
In-Reply-To: <alpine.DEB.2.00.1504241349570.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: kdreyer@redhat.com, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

Am 24.04.2015 um 22:52 schrieb Sage Weil:
> On Fri, 24 Apr 2015, Danny Al-Gaaf wrote:
>> Am 24.04.2015 um 19:37 schrieb Sage Weil:
>> [...]
>>> -- systemd --
>>>
>>> Most of the daemons can just get the User=ceph and Group=cpeh lines in the 
>>> unit files.  The OSD is tricky, though, since we want the prestart script 
>>> to run as root so that it can chown the disk contents if necessary.  We 
>>> have two options, I think:
>>>
>>> 1) run prestart and ceph-osd as root, and add a ceph daemon arg to drop 
>>> privileges and setuid.
>>>
>>> 2) add a sudo rule so that the ceph user can run the chown command from 
>>> prestart.  (This seems more dangerous.)
>>>
>>> Thoughts?
>>
>> Do we need to change the start scripts for SysV init? Or is this
>> something we should ignore because the most distros will use systemd in
>> the future.
> 
> We could, but I wonder if not touching upstart or sysvinit will be an 
> easy way to handle migration/compat issues.
> 
> One other thing Greg brought up today was that we should allow an admin to 
> configure daemons to run as root if they want.  They can do that by 
> editing the unit files; I'm not sure if we want to do something more 
> friendly than that?  (FWIW I think this is basically what Leannart 
> suggests.)

The alternative would be to drop the privileges within the code of the
daemons (as soon as possible) and use a config/cmdline option to check
if we want to start the daemons as root or under the ceph user.

Danny

