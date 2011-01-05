From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: osd memory usage with lots of objects
Date: Tue, 4 Jan 2011 16:20:20 -0800
Message-ID: <AANLkTik_GRZMYPd1KPHcDEgirspSVw9f53j4NupHnspb@mail.gmail.com>
References: <1294178282.2654.5.camel@dogen>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41875 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab1AEAUV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 19:20:21 -0500
Received: by fxm20 with SMTP id 20so14608878fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jan 2011 16:20:20 -0800 (PST)
In-Reply-To: <1294178282.2654.5.camel@dogen>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Leach <john@brightbox.co.uk>
Cc: ceph-devel@vger.kernel.org

A week or two back, I had some cases where cosd got killed by the OOM
killer on my test box.

Someone else was hogging memory with some other programs running on
the same computer, so I thought that was the cause. Also, it didn't
happen again after like the first two times, so I turned my attention
to other things.

Unfortunately SIGKILL, which the OOM killer sends, is impossible to
handle. However, it would be nice if we could dump out a memory usage
report when the usage rises above a certain (user-defined) point.

Colin


On Tue, Jan 4, 2011 at 1:58 PM, John Leach <john@brightbox.co.uk> wrote=
:
> Hi,
>
> I've got a 3 node test cluster (3 mons, 3 osds) with about 24,000,000
> very small objects across 2400 pools (written directly with librados,
> this isn't a ceph filesystem).
>
> The cosd processes have steadily grown in ram size and have finally
> exhausted ram and are getting killed by the oom killer (the nodes hav=
e
> 6gig RAM and no swap).
>
> When I start them back up they just very quickly increase in ram size
> again and get killed.
>
> Is this expected? Do the osds require a certain amount of resident
> memory relative to the data size (or perhaps number of objects)?
>
> Can you offer any guidance on planning for ram usage?
>
> I'm running ceph 0.24 on 64bit Ubuntu Lucid servers. =A0In case it's
> useful, I've just written these objects serially, no reading, no
> rewrites, updates or snapshots.
>
> I've got some further questions/observations about disk usage with th=
is
> scenario but I'll start a separate thread about that.
>
> Thanks,
>
> John.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
