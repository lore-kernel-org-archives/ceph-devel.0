From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 10:05:06 -0800
Message-ID: <CAORUGqDnXH_UDyq_39wFhNUWbjS+YQJF4a71UPkKqR+5FNDq9w@mail.gmail.com>
References: <4ED10636.6070705@biodatomics.com> <4ED36701.3060107@widodh.nl> <4ED37271.8030504@biodatomics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52662 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab1K1SLD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 13:11:03 -0500
Received: by eaak14 with SMTP id k14so2080481eaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 10:11:00 -0800 (PST)
In-Reply-To: <4ED37271.8030504@biodatomics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: max@biodatomics.com
Cc: Wido den Hollander <wido@widodh.nl>, Maxim Mikheev <mikhmv@datintsol.com>, ceph-devel@vger.kernel.org

On Mon, Nov 28, 2011 at 03:37, Maxim Mikheev <mikhmv@datintsol.com> wrote:
> [ 2007.419285] fsck.btrfs[3727]: segfault at c9 ip 0000000000412f2d sp
> 00007fffafb96738 error 4 in btrfsck[400000+1f000]
> [ 2209.940609] end_request: I/O error, dev fd0, sector 0
...
> Looks likes some errors on btrfs under ceph. you can find results of fsck
> /dev/sda3 as an attachment.

Yup, that btrfs is pining for the fjords. And last I heard, the
recovery tools aren't very good.

As long as the underlying filesystem is that broken, it's hard to say
what the OSD will do.

You can try backup+restore of the data itself (it's just files and
extended attributes), but you're probably going to have to re-mkfs it.
Ceph should be able to recover the actual data, if you have the usual
replicated setup.
