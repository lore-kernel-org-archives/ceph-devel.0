From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Monitors fallen apart
Date: Thu, 4 Aug 2011 11:14:54 -0700
Message-ID: <CAC-hyiG0zsd1LZGnWhqAfbwgotz7p3SuU+j=doLyC035rq-V3g@mail.gmail.com>
References: <201108031116.37824.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60536 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab1HDSO4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2011 14:14:56 -0400
Received: by ewy4 with SMTP id 4so1049776ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 04 Aug 2011 11:14:55 -0700 (PDT)
In-Reply-To: <201108031116.37824.szekelyi@niif.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

2011/8/3 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> Hello,
>
> I'm running ceph 0.32, and since a while it looks like if a monitor f=
ails,
> then the cluster doesn't find a new one.
>
> I have three nodes, two with cmds+cosd+cmon, and one with cmds+cmon, =
which is
> also running the client. If I stop one of the cmds+cosd+cmon nodes, c=
eph -w
> run on the cmds+cmon node tells nothing but
>
> 2011-08-03 11:10:47.291875 7f4f043d5700 -- <client_ip>:0/14633 >>
> <killed_node_ip>:6789/0 pipe(0x1a7f9c0 sd=3D4 pgs=3D0 cs=3D0 l=3D0).f=
ault first fault
>
> infinitely and the filesystem stops working (processes using files in=
 it block
> forever). Looks like it rties to connect to the killed monitor instea=
d of
> failing over to a working one.
>
> The first message after killing the node was:
>
> 2011-08-03 10:57:40.687871 7f4f01563700 monclient: hunting for new mo=
n
>
> Do you have any idea what I'm doing wrong?
>

Do you have the mon logs, or any core files?


Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
