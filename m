From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: osd crashed after adding new osd
Date: Wed, 11 Aug 2010 19:16:19 +0800
Message-ID: <AANLkTi=Z1C9WL0W=4ehxe4MX72wqKpiEZh42AvvUUm5F@mail.gmail.com>
References: <AANLkTi=bUW_twak9n_jwcp2VkrRN_pztEzkUMzW72z5=@mail.gmail.com>
	<1281454926.2812.3.camel@wido-laptop.pcextreme.nl>
	<AANLkTiksxQ6EGpgBq7jZfR2KQdV4G=9eoK7ASBfDNtcQ@mail.gmail.com>
	<Pine.LNX.4.64.1008101347500.9792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37312 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab0HKLQV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Aug 2010 07:16:21 -0400
Received: by wyb32 with SMTP id 32so1735078wyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Aug 2010 04:16:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1008101347500.9792@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi Sage,

After adding osd3, only osd2 is alive.
But the whole cluster can be recovered after restarting all dead osds.

I read the wiki and reversed the order of my procedure: starting osd
before setting crush map.
It seems to work ok now.

Thanks,
Henry


On Wed, Aug 11, 2010 at 4:56 AM, Sage Weil <sage@newdream.net> wrote:
> Hi Henry,
>
> Your osd add procedure looks correct. =C2=A0Did the osd start correct=
 after
> this point? =C2=A0Are you able to reproduce the problem with osd logg=
ing
> turned up (debug osd =3D 20 in [osd])?
>
> I just tried this with the latest unstable and wasn't able to reprodu=
ce
> the problem.
>
> sage
>
> On Wed, 11 Aug 2010, Henry C Chang wrote:
>
>> Hi Wido,
>>
>> I am running unstable branch (commit: b72c1bb6e9b77e1ab6c2) dated Ju=
ly 30.
>> I just uploaded the core dumps to
>>
>> http://home.anet.net.tw/cycbbb/coredumps/core.2580.gz
>> http://home.anet.net.tw/cycbbb/coredumps/core.2602.gz
>>
>>
>>
>> On Tue, Aug 10, 2010 at 11:42 PM, Wido den Hollander <wido@widodh.nl=
> wrote:
>> > Hi Henry,
>> >
>> > Is there a core-dump of these crashes in /? If so, these could hel=
p
>> > finding the cause of this.
>> >
>> > See: http://ceph.newdream.net/wiki/Troubleshooting
>> >
>> > And btw, which version of Ceph are you running?
>> >
>> > Wido
>> >
>> > On Tue, 2010-08-10 at 21:09 +0800, Henry C Chang wrote:
>> >> Hi,
>> >>
>> >> I have a ceph cluster: 3 (mon+osd) and 2 (mds).
>> >> When I tried to add the 4th osd to the cluster, osd0 and osd1 cra=
shed.
>> >> The error logs are attached.
>> >>
>> >> My procedure to add the 4th osd is:
>> >>
>> >> add [osd3] in the conf file: /etc/ceph/ceph.conf
>> >> ceph -c /etc/ceph/ceph.conf mon getmap -o /tmp/monmap
>> >> cosd -c /etc/ceph/ceph.conf -i 3 --mkfs --monmap /tmp/monmap
>> >> ceph -c /etc/ceph/ceph.conf osd setmaxosd 4
>> >> osdmaptool --createsimple 4 --clobber /tmp/osdmap.junk --export-c=
rush
>> >> /tmp/crush.new
>> >> ceph -c /etc/ceph.conf osd setcrushmap -i /tmp/crush.new
>> >> /etc/init.d/ceph -c
>> >> /etc/ceph/d2c5d946-b888-40b3-aac2-adda05477a81.conf start osd
>> >>
>> >> Is my procedure to add an osd incorrect?
>> >>
>> >> Thanks,
>> >> Henry
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
