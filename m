From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Journal Disk Cache - on or off
Date: Fri, 29 Jan 2016 19:02:09 +0100
Message-ID: <CAOi1vP9z9vSFT0q4DeRH+T6pYtid-yVt0JLA=d9SM6R7qnjN0g@mail.gmail.com>
References: <CAKtk8hceHCVqZpiA0cCu-17-oJmTgvUihHJujyTcggpzYc-75Q@mail.gmail.com>
	<alpine.DEB.2.11.1601291241130.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38026 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650AbcA2SCK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 13:02:10 -0500
Received: by mail-wm0-f42.google.com with SMTP id p63so78780742wmp.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jan 2016 10:02:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601291241130.28963@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Guang Yang <guangyy@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ric Wheeler <rwheeler@redhat.com>

On Fri, Jan 29, 2016 at 6:43 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 29 Jan 2016, Guang Yang wrote:
>> Hi Sage,
>> I found a thread discussing whether we could turn on disk cache with
>> new kernel or not -
>> http://www.spinics.net/lists/ceph-devel/msg06173.html
>>
>> From within that thread, you mentioned that since the fsync/fdatasync
>> would flush the disk cache as well, we could actually turn on the
>> cache without worrying about the data safety.
>
> Yeah, any vaguely modern kernel will do a proper flush to the device; no
> need to worry about the disk cache.
>
>> Is that true if journal_dio is being used (by default), in which case
>> O_DIRECT | O_DSYNC is being used to write journal rather than
>> fsync(2)?
>
> Right.  O_DSYNC triggers a flush at the SCSI (or virtio) level, so these
> journal [A]IOs are fully synchronous all the way to the platter.

The last time I looked, O_DSYNC was nothing but an implicit fdatasync
after each write, triggered at the VFS layer - not that much different
from the explicit fdatasync.

Thanks,

                Ilya
