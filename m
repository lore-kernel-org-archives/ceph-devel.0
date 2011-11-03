From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Thu, 3 Nov 2011 14:15:25 -0700
Message-ID: <CAORUGqC3ZG-7NG7xACFoHP0kY=gDDgMG=i+99MV1hmM1XpL9bw@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <CAORUGqB+oS5WupMZURbkenNop68u2jf2VrY3_tktBk4=b-jS8w@mail.gmail.com> <CA+jddaO2NqLTNbS2zBnQW4MCA7=BYDC-GHx_H01hqSq9RvOgBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37566 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1KCVPr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 17:15:47 -0400
Received: by wyh15 with SMTP id 15so1654862wyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 14:15:46 -0700 (PDT)
In-Reply-To: <CA+jddaO2NqLTNbS2zBnQW4MCA7=BYDC-GHx_H01hqSq9RvOgBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Nov 3, 2011 at 13:39, Mandell Degerness <mandell@pistoncloud.com> wrote:
> The osd data directories are on /mnt/osd$id which are btrfs.
>
> The mon data directory is /mnt/local/mon$id which is xfs. (/mnt/local
> is the mount point)

Then it really sounds like you found a bug in XFS, and ceph-mon didn't
even do anything really weird to trigger it.

If it's reproducible, I'm sure the XFS developers would appreciate if
you straced what ceph-mon does to get to the hang, tried to do similar
actions to reproduce it outside of ceph (e.g. "every time I write to
this file, it hangs"), and then give them a good bug report with a
dump of the filesystem, to figure out what really happened.

If it's not reproducible, just reboot the machine, fsck the
filesystem, and hope for the best.
