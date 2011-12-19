From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Mon, 19 Dec 2011 09:40:12 -0800
Message-ID: <CAORUGqDThqW=1DeQWhBanmzj5RXVvL0Q3BNR1Q-d+=BzNz-Xww@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51230 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab1LSRke convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 12:40:34 -0500
Received: by werm1 with SMTP id m1so1428173wer.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 09:40:33 -0800 (PST)
In-Reply-To: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Dec 18, 2011 at 11:26, Karoly Horvath <rhswdev@gmail.com> wrote=
:
> The documentation states for all the daemons that they have to be an
> odd number to work correctly.
> But what happens if one of the nodes is down? Then, by definition
> there will be an even number of daemons.
> Can the system tolerate this failure? If not, do I have to automate
> the process of quickly bringing up a new node to achieve HA?

Not all, just the ceph-mon daemons should be an odd number. Monitors
know how many monitors there are, even when one of them is down. As
long as a majority of them is available, they can operate normally.
With 3, you can temporarily lose 1 and keep operating. With 5, you can
lose 2. With 7, you can lose 3.

If you permanently lose one of the machines running ceph-mon, see
http://ceph.newdream.net/docs/latest/ops/manage/grow/mon/ for how to
remove it, and add a new daemon elsewhere.

Everything else is able to deal with just the number that you want to
run; naturally, just 1 doesn't give you any HA.

With the mds, we currently recommend running only 1 in active mode,
rest in standby.

> ceph version 0.39 (commit:321ecdaba2ceeddb0789d8f4b7180a8ea5785d83)
> xxx.xxx.xxx.31 alpha (mds, mon, osd)
> xxx.xxx.xxx.33 beta =C2=A0(mds, mon, osd)
> xxx.xxx.xxx.35 gamma ( =C2=A0 =C2=A0 mon, osd)
> ceph FS is mounted with listing the two mds-es.
> I set 'data' and 'metadata' to 2, then tested with 3.
>
> I've read the documentation and it suggests this should be enough to
> achieve High Availability.
> The data is replicated on all the osd-s (3), there is at least 1 mds
> up all the time...yet:
>
> Each time I remove the power plug from the primary mds node's host,
> the system goes down and I cannot do a simple `ls`.
> I can replicate this problem and send you any logfiles or ceph -w
> outputs you need. Let me know what you need.
> Here is an example session: http://pastebin.com/R4MgdhUy
>
> I once saw the standby mds to wake up and then the FS worked but that
> was after 20 minutes, which is way too long for a HA scenario.

> I'm willing to sacrifice (a lot of) performance to achieve high avail=
ability.
> Let me know if there are configuration settings to achieve this.

The paste says the second mds is a standby, that's good.

There's a timeout before the standby becomes active. That timeout
might be too long to suit your needs. Hopefully someone else from the
team who's actually worked on the mds will confirm this, but it looks
like the relevant config setting is mds_beacon_grace (default 15, the
unit seems to be seconds). I'm not sure what's going on there.

See if you can speed up the standby becoming active with "ceph mds
fail beta" (or whatever node you took down). If that makes it happen
fast, then we can figure out the timers; if that doesn't make the
failover happen, then there's something wrong in the setup.

Most of the QA is currently focusing on rados, radosgw, and rbd, so
we're not actively running these kinds of tests on the mds component
right now.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
