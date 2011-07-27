From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: OSD questions
Date: Wed, 27 Jul 2011 10:30:55 -0700
Message-ID: <CAF3hT9BSbO3o6vBy0E3XPVJQz6X=W9VFVuWqjvdeyNR5x+j-Ng@mail.gmail.com>
References: <CABAwU-YsTz8WjPLzVZrhwJs64fYTPdAHbA2J1S1pdzMULuBM_w@mail.gmail.com>
	<CAF3hT9DHLsmWpL0jrrC+bm=Dq4m4+ohu2u2nL_NGhAxWM1TC2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50637 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab1G0Ra4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 13:30:56 -0400
Received: by gyh3 with SMTP id 3so1209978gyh.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 10:30:55 -0700 (PDT)
In-Reply-To: <CAF3hT9DHLsmWpL0jrrC+bm=Dq4m4+ohu2u2nL_NGhAxWM1TC2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 27, 2011 at 9:05 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> The doubled writes can be annoying, but it's really the only safe
> thing to do. Perhaps we could do something with btrfs and snapshots to
> avoid using a journal, but I'd have to look into it some more.
Actually this already works -- you are data safe if you run btrfs
without a journal. Apparently it's even slower, though -- you need to
go through a lot more syncs to guarantee your data safety.

So your best bet if it's a real problem is to add a fast disk to use
as your journaling device.
