From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Mon, 19 Dec 2011 14:50:50 -0800
Message-ID: <CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54289 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab1LSWuv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 17:50:51 -0500
Received: by iaeh11 with SMTP id h11so9220217iae.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 14:50:50 -0800 (PST)
In-Reply-To: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Dec 18, 2011 at 11:26 AM, Karoly Horvath <rhswdev@gmail.com> wr=
ote:
> Hi Guys,
>
> two questions:
>
> first one is short:
> The documentation states for all the daemons that they have to be an
> odd number to work correctly.
> But what happens if one of the nodes is down? Then, by definition
> there will be an even number of daemons.
> Can the system tolerate this failure? If not, do I have to automate
> the process of quickly bringing up a new node to achieve HA?
>
> the second one:
> I have a simple configuration:
>
> ceph version 0.39 (commit:321ecdaba2ceeddb0789d8f4b7180a8ea5785d83)
> xxx.xxx.xxx.31 alpha (mds, mon, osd)
> xxx.xxx.xxx.33 beta =A0(mds, mon, osd)
> xxx.xxx.xxx.35 gamma ( =A0 =A0 mon, osd)
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
>
> There is hardly any data on the FS at the moment (400MB, lol..), and
> hardly any writes...
>
> I'm willing to sacrifice (a lot of) performance to achieve high avail=
ability.
> Let me know if there are configuration settings to achieve this.
TV's right. Specifically regarding the MDS:
As TV said, the MDS should time out and get replaced within 30 seconds
(this is controlled by the "mds beacon grace" setting). It is a
failover procedure, not shared masters or something, but from my
experience it takes on the order of 10 seconds to complete once
failure is detected. 20 minutes is completely wrong. If we're not
already talking elsewhere, then I'd like it if you could enable MDS
logging and reproduce this and post the logs somewhere so I can check
out what's going on.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
