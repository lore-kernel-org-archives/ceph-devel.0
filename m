From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph on XFS
Date: Fri, 27 Jan 2012 13:23:40 -0800
Message-ID: <CAF3hT9D42NpPwTQnT=fm3OjzxSRW8ygCVSq6KRFUz4UD=-vYFQ@mail.gmail.com>
References: <CAO47_-8JzjxoGB_ZjVwWtdhYLJ3LoVZQyoQoSWuJ1v9W9ioSLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60246 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab2A0VXl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 16:23:41 -0500
Received: by iacb35 with SMTP id b35so2527847iac.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2012 13:23:40 -0800 (PST)
In-Reply-To: <CAO47_-8JzjxoGB_ZjVwWtdhYLJ3LoVZQyoQoSWuJ1v9W9ioSLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 27, 2012 at 12:48 PM, Christian Brunner <chb@muc.de> wrote:
> Hi,
>
> reading the list archives, I get the impression that XFS is the secon=
d
> best alternative to btrfs. But when I start an ceph-osd on an XFS
> volume, there is still a big warning:
>
> WARNING: not btrfs or ext3. =A0We don't currently support file system=
s other
> =A0 =A0 =A0 =A0 =A0 =A0 than btrfs and ext3 (data=3Djournal or data=3D=
ordered). =A0Data may be
> =A0 =A0 =A0 =A0 =A0 =A0 lost in the event of a crash.

Wow, that's an old warning.

> I know that I can't use btrfs snapshots, but is it really that bad?
No. Just ignore it; I made bug 1995 to do something with that warning.
xfs is perfectly data-safe (or at least Ceph uses data-safe semantics
with it :p), and how it performs under different workloads is
something we need to benchmark.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
