From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: problem with ceph init scripts
Date: Thu, 17 Feb 2011 23:05:13 -0800
Message-ID: <AANLkTi=yoPPo0HGn8tQgqRxuHNVfsoEYXGcuNpkc6G7Q@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
	<AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
	<AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
	<AANLkTik4GFBFLWsq_gepb+t7Y=H9gxgm0dssDRFMROA-@mail.gmail.com>
	<AANLkTikY8TeWBtFFGKsWVUd22ZwZpsvASj_4Q_oWkyAW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56703 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab1BRHFP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 02:05:15 -0500
Received: by fxm20 with SMTP id 20so3467757fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 Feb 2011 23:05:14 -0800 (PST)
In-Reply-To: <AANLkTikY8TeWBtFFGKsWVUd22ZwZpsvASj_4Q_oWkyAW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

Hi Upendra,

Are you running init-ceph from the source directory? If you do that,
it will use the ceph.conf in the source directory itself, which is
probably not what you want. So it might be good to double-check that.

If all else fails, running init-ceph with -x will show you exactly
what the script is doing. If all goes well, its exit status should be
0. Are you getting exit status 0?

Colin


On Thu, Feb 17, 2011 at 1:55 AM, Upendra Moturi <upendra.m@hexagrid.com=
> wrote:
> Hi Colin
>
> Here is my ceph.conf :
>
> [global]
> =A0 =A0 =A0 pid file =3D /var/run/ceph/$name.pid
> =A0 =A0 =A0 debug ms =3D 1
> [mon]
> =A0 =A0 =A0 =A0mon data =3D /data/mon$id
> [mon.0]
> =A0 =A0 =A0 =A0host =3D ceph0
> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.5:6789
> [mon.1]
> =A0 =A0 =A0 =A0host =3D ceph1
> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.6:6789
> [mon.2]
> =A0 =A0 =A0 =A0host =3D ceph2
> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.7:6789
> [mds]
>
> [mds0]
> =A0 =A0 =A0 =A0host =3D ceph0
> [mds1]
> =A0 =A0 =A0 =A0host =3D ceph1
>
> [osd]
> =A0 =A0 =A0 =A0sudo =3D true
> =A0 =A0 =A0 =A0osd data =3D /data/osd$id
> =A0 =A0 =A0 =A0osd journal =3D /data/osd$id/journal
> =A0 =A0 =A0 =A0osd journal size =3D 512
> =A0 =A0 =A0 =A0osd use stale snap =3D true
> [osd0]
> =A0 =A0 =A0 =A0host =3D ceph0
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
> [osd1]
> =A0 =A0 =A0 =A0host =3D ceph1
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
> [osd2]
> =A0 =A0 =A0 =A0host =3D ceph2
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
>
>
>
>
> On Thu, Feb 17, 2011 at 1:06 PM, Colin McCabe <cmccabe@alumni.cmu.edu=
> wrote:
>> I'm using head of line from the master branch. But that particular
>> code hasn't changed since January, which is 0.24.2 is from.
>>
>> In my ceph.conf, I just had an osd that was on a remote machine, and
>> everything else local.
>>
>> If you could post your ceph.conf here or in IRC, perhaps we might sp=
ot
>> an issue that's causing the problems that you see.
>>
>> Colin
>>
>>
>> On Wed, Feb 16, 2011 at 11:01 PM, Upendra Moturi <upendra.m@hexagrid=
=2Ecom> wrote:
>>> Hi Colin
>>> I am using
>>> ceph version 0.24.2 commit:f7572de5cb87eb7157217be4975ae66d90831bb7
>>> ubuntu 11.04 32 bit with upgraded kernal of 2.6.38-2-generic
>>>
>>> Installed ceph form apt source.
>>>
>>> With above configurations i still able yo reproduce.
>>> Can you please share me ur configurations?
>>>
>>> On Thu, Feb 17, 2011 at 3:31 AM, Colin McCabe <cmccabe@alumni.cmu.e=
du> wrote:
>>>> On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@alumni.cmu.=
edu> wrote:
>>>>> On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m@hexagr=
id.com> wrote:
>>>>>> But if we want to start a particular osd or mon or mds ,its not
>>>>>> working and there is no error
>>>>>> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and don't =
get any error
>>>>>
>>>>> That is expected, unless you are running init-ceph on the same no=
de as
>>>>> osd1 is on.
>>>>>
>>>>> It might be nice to have some kind of interface like "run command=
 X on
>>>>> osd1", but init-ceph is not that.
>>>>>
>>>>>> /etc/init.d/ceph -a stop also does not stop ceph on all nodes.It=
 stops
>>>>>> on current node only
>>>>>> where as
>>>>>> /etc/init.d/ceph -a killall works fine.
>>>>>
>>>>> That sounds like a bug. I'll see if I can fix it.
>>>>
>>>> I'm afraid I can't reproduce this.
>>>>
>>>> I ran /etc/init.d/ceph -a stop
>>>>
>>>> and it stopped ceph daemons running on remote nodes too. Looking a=
t
>>>> the code, it looks correct.
>>>>
>>>> Colin
>>>>
>>>
>>>
>>>
>>> --
>>> Thanks and Regards,
>>> Upendra.M
>>>
>>
>
>
>
> --
> Thanks and Regards,
> Upendra.M
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
