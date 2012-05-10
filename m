From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: "converting" btrfs osds to xfs?
Date: Thu, 10 May 2012 15:44:11 -0700
Message-ID: <CAPud5_5fsBXX-N-SM7P7Fouba+9P2Nt5aAPfq+nLkUcN4_d5OQ@mail.gmail.com>
References: <CAPud5_6MkeN-6n4rGX=Mew7nGfsmOOAiAtWVgdPArio6z2d_Fg@mail.gmail.com>
	<CADvuQRHDkpiDQSn84CvVccHf-pwPzyQZZQcpy34P0TcaWAk-FQ@mail.gmail.com>
	<Pine.LNX.4.64.1205081238010.14100@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47035 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761578Ab2EJWoM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 18:44:12 -0400
Received: by yenm10 with SMTP id m10so2055061yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 15:44:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205081238010.14100@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

After I run the 'ceph osd out 123' command, is there a specific ceph
command I can poll so I know when it's OK to kill the OSD daemon and
begin the reformat process?

On Tue, May 8, 2012 at 12:38 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 8 May 2012, Tommi Virtanen wrote:
>> On Tue, May 8, 2012 at 8:39 AM, Nick Bartos <nick@pistoncloud.com> w=
rote:
>> > I am considering converting some OSDs to xfs (currently running bt=
rfs)
>> > for stability reasons. =A0I have a couple of ideas for doing this,=
 and
>> > was hoping to get some comments:
>> >
>> > Method #1:
>> > 1. =A0Check cluster health and make sure data on a specific OSD is
>> > replicated elsewhere.
>> > 2. =A0Bring down the OSD
>> > 3. =A0Reformat it to xfs
>> > 4. =A0Restart OSD
>> > 5. =A0Repeat 1-4 until all btrfs OSDs have been converted.
>> ...
>> > Obviously #1 seems much more appetizing, but unfortunately I can't
>> > seem to find out how to verify that data on a specific OSD is
>> > replicated elsewhere. =A0I could go off general cluster health, bu=
t that
>> > seems more error prone.
>>
>> You can set the osd weight in crush to 0 and wait for the files insi=
de
>> the osd data dir to disappear. If you want to control how much
>
> You can also just mark the osd 'out' without touching the CRUSH map;
> that'll be easier and a bit more efficient wrt data movement:
>
> =A0 =A0 =A0 =A0ceph osd out 123
>
> When the one comes back, you'll need to
>
> =A0 =A0 =A0 =A0ceph osd in 123
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
