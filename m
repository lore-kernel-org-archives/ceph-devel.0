From: Leander Yu <leander.yu@gmail.com>
Subject: Re: mds suicide
Date: Tue, 5 Oct 2010 13:09:19 +0800
Message-ID: <AANLkTi=DG74g=fTcQzRoRM-Zpd9=ttz71wHyiUEXoONV@mail.gmail.com>
References: <AANLkTikArjoBY7D6M5q3eKBH249hpd4BTVhgiVKE9RFn@mail.gmail.com>
	<Pine.LNX.4.64.1010042151480.21681@cobra.newdream.net>
	<Pine.LNX.4.64.1010042157100.21681@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38093 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab0JEFJU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 01:09:20 -0400
Received: by wyb28 with SMTP id 28so5674282wyb.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Oct 2010 22:09:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010042157100.21681@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Thanks a lot for your prompt answer.
So is the behavior normal? I mean if we assume there was a network issu=
e.
In this case will it be better to restart the mds instead of suicide?
or leave it there as standby?

Regards,
Leander Yu.

On Tue, Oct 5, 2010 at 1:00 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 4 Oct 2010, Sage Weil wrote:
>> On Tue, 5 Oct 2010, Leander Yu wrote:
>> > Hi,
>> > I have a 46 machines cluster(44 osd/mon + 2 mds) running ceph now.=
 MDS
>> > is running in active/standby mode.
>> > This morning one of the MDS suicide the log shows:
>> >
>> > -------------------------------------------
>> > 2010-10-04 22:24:19.450022 7f2e5a1ee710 mds0.cache.ino(10000002b87=
)
>> > pop_projected_snaprealm 0x7f2e50cd9f70 seq1
>> > 2010-10-04 22:26:12.180854 7f2debbfb710 -- 192.168.1.103:6800/2081=
 >>
>> > 192.168.1.106:0/2453428678 pipe(0x7f2e380013d0 sd=3D-1 pgs=3D2 cs=3D=
1
>> > l=3D0).fault with nothing to send, going to standby
>> > 2010-10-04 22:26:12.181019 7f2e481dc710 -- 192.168.1.103:6800/2081=
 >>
>> > 192.168.1.111:0/18905730 pipe(0x7f2e38002250 sd=3D-1 pgs=3D2 cs=3D=
1
>> > l=3D0).fault with nothing to send, going to standby
>> > 2010-10-04 22:26:12.181041 7f2dc3fff710 -- 192.168.1.103:6800/2081=
 >>
>> > 192.168.1.114:0/1945631186 pipe(0x7f2e38000f00 sd=3D-1 pgs=3D2 cs=3D=
1
>> > l=3D0).fault with nothing to send, going to standby
>> > 2010-10-04 22:26:12.181149 7f2deaef6710 -- 192.168.1.103:6800/2081=
 >>
>> > 192.168.1.113:0/521184914 pipe(0x7f2e38002f90 sd=3D-1 pgs=3D2 cs=3D=
1
>> > l=3D0).fault with nothing to send, going to standby
>> > 2010-10-04 22:26:12.181563 7f2deb5f5710 -- 192.168.1.103:6800/2081=
 >>
>> > 192.168.1.112:0/4272114728 pipe(0x7f2e38002ac0 sd=3D-1 pgs=3D2 cs=3D=
1
>> > l=3D0).fault with nothing to send, going to standby
>> > 2010-10-04 22:26:13.777624 7f2e5a1ee710 mds-1.3 handle_mds_map i
>> > (192.168.1.103:6800/2081) dne in the mdsmap, killing myself
>> > 2010-10-04 22:26:13.777649 7f2e5a1ee710 mds-1.3 suicide. =A0wanted
>> > up:active, now down:dne
>> > 2010-10-04 22:26:13.777769 7f2e489e4710 -- 192.168.1.103:6800/2081=
 >>
>> > 192.168.1.101:0/15702 pipe(0x7f2e380008c0 sd=3D-1 pgs=3D1847 cs=3D=
1
>> > l=3D0).fault with nothing to send, going to standby
>> > ------------------------------------------------------------------=
------------
>> > Would you suggest how do I trouble shooting this issue? or should =
I
>> > just restart the mds to recover it?
>>
>> The MDS killed itself because it was removed from the mdsmap. =A0The
>> monitor log will tell you why if you had logging turned up. =A0If no=
t, you
>> might find some clue by looking at each mdsmap iteration. =A0If you =
do
>>
>> =A0$ ceph mds stat
>>
>> it will tell you the map epoch (e###). =A0You can then dump any map
>> iteration with
>>
>> =A0$ ceph mds dump 123 -o -
>>
>> Work backward a few iterations until you find which epoch removed th=
at mds
>> instance. =A0The one prior to that might have some clue (maybe it wa=
s
>> laggy?)...
>
> Okay, looking at the maps on your cluster, it looks like there was a
> standby mds, and the live one was marked down. =A0Probably some inter=
mittent
> network issue preventing it from sending the monitor beacon on time, =
and
> the monitor decided it was dead/unresponsive. =A0The standby cmds too=
k over
> successfully. =A0The recovery looks like it took about 20 seconds.
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
