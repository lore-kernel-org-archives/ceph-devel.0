From: huang jun <hjwsm1989@gmail.com>
Subject: Re: OSD questions
Date: Thu, 28 Jul 2011 21:25:05 +0800
Message-ID: <CABAwU-Y5B2Fmy0J=6q3vn9_O0WGMy0PEV-QiwWXp0o12_CD8dg@mail.gmail.com>
References: <CABAwU-YsTz8WjPLzVZrhwJs64fYTPdAHbA2J1S1pdzMULuBM_w@mail.gmail.com>
	<CAF3hT9DHLsmWpL0jrrC+bm=Dq4m4+ohu2u2nL_NGhAxWM1TC2A@mail.gmail.com>
	<CAF3hT9BSbO3o6vBy0E3XPVJQz6X=W9VFVuWqjvdeyNR5x+j-Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37658 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab1G1NZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 09:25:06 -0400
Received: by wyg8 with SMTP id 8so108639wyg.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 06:25:05 -0700 (PDT)
In-Reply-To: <CAF3hT9BSbO3o6vBy0E3XPVJQz6X=W9VFVuWqjvdeyNR5x+j-Ng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2011/7/28 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Wed, Jul 27, 2011 at 9:05 AM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> The doubled writes can be annoying, but it's really the only safe
>> thing to do. Perhaps we could do something with btrfs and snapshots to
>> avoid using a journal, but I'd have to look into it some more.
> Actually this already works -- you are data safe if you run btrfs
> without a journal. Apparently it's even slower, though -- you need to
> go through a lot more syncs to guarantee your data safety.
>
we use btrfs and without journal, it turns out that :
the performance of big write(10GB) is good, but the rm dir ops goes slow.
So we reset the value of "filestore max sync interval = 0.1", the rm
dirs rate increased.
Does this related to version of ceph kernel Client and kernel ? Can we
promote the DIR ops
performance on OSD end?
> So your best bet if it's a real problem is to add a fast disk to use
> as your journaling device.
>
