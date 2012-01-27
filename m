From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Bug #1047 reproduced
Date: Fri, 27 Jan 2012 10:54:27 -0800
Message-ID: <CAF3hT9AYJYHYNirRp+rOh4a=14RYiZfs-TzhtXutBduOTA__wQ@mail.gmail.com>
References: <201112010937.37642.a.ott@m-privacy.de>
	<CAF3hT9BrL8WJbG2cgDADfSZk02HWwi4Q2MgK_yu6fiDSyZrwRg@mail.gmail.com>
	<201112291230.59323.a.ott@m-privacy.de>
	<201201271523.54502.a.ott@m-privacy.de>
	<Pine.LNX.4.64.1201270648060.25956@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51960 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2A0Sy2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 13:54:28 -0500
Received: by iacb35 with SMTP id b35so2381290iac.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2012 10:54:28 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201270648060.25956@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org

On Fri, Jan 27, 2012 at 6:50 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 27 Jan 2012, Amon Ott wrote:
>> On Thursday 29 December 2011 wrote Amon Ott:
>> > I finally got the test cluster freed up for more Ceph testing.
>> >
>> > On Friday 23 December 2011 wrote Gregory Farnum:
>> > > Unfortunately there's not enough info in this log either. If you=
 can
>> > > reproduce it with "mds debug =3D 20" and put that log somewhere,=
 it
>> > > ought to be enough to work out what's going on, though. Sorry. :=
(
>> > > -Greg
>> >
>> > Here is what MDS logs with debug 20. No idea if it really helps. T=
he
>> > cluster is still in the broken state, should I try to reproduce wi=
th a
>> > recreated ceph fs and debug 20? This could be GBs of logs.
>>
>> Update: I recreated the Ceph FS with release 0.40. It broke only bec=
ause of a
>> btrfs bug hitting two of the four nodes (after ca. one day of heavy =
load) and
>> recovered without problems when the nodes were back. Then I recreate=
d with
>> ext4 as osd storage area and have not managed to break it within fou=
r days,
>> two of these under heavy load.
>>
>> This means that this bug is probably fixed. It might be related to t=
he
>> automatic reconnect of mds, which avoids meta data inconsistencies. =
:)
>
> Yeah, I suspect that the problem is related to the MDS journal replay=
 and
> the two-phase-commit stuff going on with the anchor table updates. =A0=
I
> think we should keep this open until we can do MDS restart thrashing
> against a heavy link workload.
>
> Unless there was something you found/fixed before, Greg?

Unfortunately not =97=A0like I reported in the bug, there are definitel=
y
multiple anchor destroy updates getting into the journal somehow, but
I was unable to figure out how it might have happened. I'm not sure I
considered synchronization bugs in MDS restart or client replay,
though...
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
