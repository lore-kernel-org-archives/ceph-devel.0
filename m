From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [WRN] map e### wrongly marked me down or wrong addr
Date: Tue, 28 Feb 2012 08:16:34 -0800
Message-ID: <CAF3hT9DDKCV6uh3WPStrmnTOuWOBc1k_n-YUJMi9wzCT8GL5YA@mail.gmail.com>
References: <2230716.Iq9SpLVmvc@mranderson>
	<Pine.LNX.4.64.1202270901350.12283@cobra.newdream.net>
	<2227262.Lg19pAvyvB@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39397 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965331Ab2B1QQf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 11:16:35 -0500
Received: by iagj37 with SMTP id j37so1371468iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 08:16:34 -0800 (PST)
In-Reply-To: <2227262.Lg19pAvyvB@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, wido@widodh.nl

2012/2/28 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> On 2012. February 27. 09:03:11 Sage Weil wrote:
>> On Mon, 27 Feb 2012, Sz=E9kelyi Szabolcs wrote:
>> > whenever I restart osd.0 I see a pair of messages like
>> >
>> > 2012-02-27 17:26:00.132666 mon.0 <osd_1_ip>:6789/0 106 : [INF] osd=
=2E0
>> > <osd_0_ip>:6801/29931 failed (by osd.1 <osd_1_ip>:6806/20125)
>> > 2012-02-27 17:26:21.074926 osd.0 <osd_0_ip>:6801/29931 1 : [WRN] m=
ap
>> > e370
>> > wrongly marked me down or wrong addr
>> >
>> > a couple of times. The situation stabilizes in a normal state afte=
r
>> > about two minutes.
>> >
>> > Should I worry about this? Maybe the first message is about the ju=
st
>> > killed OSD, and the second comes from the new incarnation, and thi=
s is
>> > completely normal? This is Ceph 0.41.
>>
>> It's not normal. =A0Wido was seeing something similar, I think. =A0I=
 suspect
>> the problem is that during startup ceph-osd just busy, but the heart=
beat
>> code is such that it's not supposed to miss them.
>>
>> Can you reproduce this with 'debug ms =3D 1'?
>
> Yes, I managed to. Output of ceph -w attached (with IP addresses mang=
led). My
> setup is 3 nodes, node 1 and 2 running OSD, MDS and MON, node 3 runni=
ng MON
> only. I also have the logs from all nodes in case you need it.

Yes, please. Just the cluster state is not very helpful =97 we want to
see why the OSDs are marking each other down, not when. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
