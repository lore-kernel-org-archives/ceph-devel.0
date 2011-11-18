From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Cluster sync doesn't finsh
Date: Fri, 18 Nov 2011 10:13:57 -0800
Message-ID: <CAF3hT9A2O4xLByS=-sNkgvgV8MsvqgzYvcZf4+J1dXpV97jYVw@mail.gmail.com>
References: <4EC57338.9040004@tuxadero.com>
	<CAORUGqA888s9u23r6EfHCbMQ5t5QjGW8iNajdAZqK8pp7GqcXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45265 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab1KRSN6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2011 13:13:58 -0500
Received: by ghbz2 with SMTP id z2so859838ghb.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Nov 2011 10:13:58 -0800 (PST)
In-Reply-To: <CAORUGqA888s9u23r6EfHCbMQ5t5QjGW8iNajdAZqK8pp7GqcXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: martin@tuxadero.com, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Fri, Nov 18, 2011 at 10:05 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Nov 17, 2011 at 12:48, Martin Mailand <martin@tuxadero.com> w=
rote:
>> Hi,
>> I am doing cluster failure test, where I shut down one OSD an wait f=
or the
>> cluster to sync. But the sync never finshed, at around 4-5% it stops=
=2E I
>> stoped osd2.
> ...
>> 2011-11-17 16:42:45.520740 =A0 =A0pg v1337: 600 pgs: 547 active+clea=
n, 53
>> active+clean+degraded; 113 GB data, 184 GB used, 1141 GB / 1395 GB a=
vail;
>> 4025/82404 degraded (4.884%)
> ...
>> The osd log, the ceph.conf, pg dump, osd dump could be found here.
>>
>> http://85.214.49.87/ceph/
>
> This looks a bit worrying:
>
> 2011-11-17 17:56:35.771574 7f704c834700 -- 192.168.42.113:0/2424 >>
> 192.168.42.114:6802/21115 pipe(0x2596c80 sd=3D17 pgs=3D0 cs=3D0 l=3D0=
).connect
> claims to be 192.168.42.114:6802/21507 not 192.168.42.114:6802/21115 =
-
> wrong node!
>
> So osd.0 is basically refusing to talk to one of the other OSDs. I
> don't understand the messenger well enough to know why this would be,
> but it wouldn't surprise me if this problem kept the objects degraded
> -- it looks like a breakage in the osd<->osd communication.
>
> Now if this was the reason, I'd expect a restart of all the OSDs to
> get it back in shape; messenger state is ephemeral. Can you confirm
> that?

Probably not =97=A0that wrong node thing can occur for a lot of differe=
nt
reasons, some of which matter and most of which don't. Sam's looking
into the problem; there's something going wrong with the CRUSH
calculations or the monitor PG placement overrides or something...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
