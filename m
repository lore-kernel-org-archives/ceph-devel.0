From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: Re: problem with ceph init scripts
Date: Thu, 17 Feb 2011 15:25:41 +0530
Message-ID: <AANLkTikY8TeWBtFFGKsWVUd22ZwZpsvASj_4Q_oWkyAW@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
	<AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
	<AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
	<AANLkTik4GFBFLWsq_gepb+t7Y=H9gxgm0dssDRFMROA-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53358 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1BQJzm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 04:55:42 -0500
Received: by yxt3 with SMTP id 3so1035722yxt.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 Feb 2011 01:55:41 -0800 (PST)
In-Reply-To: <AANLkTik4GFBFLWsq_gepb+t7Y=H9gxgm0dssDRFMROA-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

Hi Colin

Here is my ceph.conf :

[global]
       pid file =3D /var/run/ceph/$name.pid
       debug ms =3D 1
[mon]
        mon data =3D /data/mon$id
[mon.0]
        host =3D ceph0
        mon addr =3D 192.168.155.5:6789
[mon.1]
        host =3D ceph1
        mon addr =3D 192.168.155.6:6789
[mon.2]
        host =3D ceph2
        mon addr =3D 192.168.155.7:6789
[mds]

[mds0]
        host =3D ceph0
[mds1]
        host =3D ceph1

[osd]
        sudo =3D true
        osd data =3D /data/osd$id
        osd journal =3D /data/osd$id/journal
        osd journal size =3D 512
        osd use stale snap =3D true
[osd0]
        host =3D ceph0
        btrfs devs =3D /dev/sdb
[osd1]
        host =3D ceph1
        btrfs devs =3D /dev/sdb
[osd2]
        host =3D ceph2
        btrfs devs =3D /dev/sdb




On Thu, Feb 17, 2011 at 1:06 PM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> I'm using head of line from the master branch. But that particular
> code hasn't changed since January, which is 0.24.2 is from.
>
> In my ceph.conf, I just had an osd that was on a remote machine, and
> everything else local.
>
> If you could post your ceph.conf here or in IRC, perhaps we might spo=
t
> an issue that's causing the problems that you see.
>
> Colin
>
>
> On Wed, Feb 16, 2011 at 11:01 PM, Upendra Moturi <upendra.m@hexagrid.=
com> wrote:
>> Hi Colin
>> I am using
>> ceph version 0.24.2 commit:f7572de5cb87eb7157217be4975ae66d90831bb7
>> ubuntu 11.04 32 bit with upgraded kernal of 2.6.38-2-generic
>>
>> Installed ceph form apt source.
>>
>> With above configurations i still able yo reproduce.
>> Can you please share me ur configurations?
>>
>> On Thu, Feb 17, 2011 at 3:31 AM, Colin McCabe <cmccabe@alumni.cmu.ed=
u> wrote:
>>> On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@alumni.cmu.e=
du> wrote:
>>>> On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m@hexagri=
d.com> wrote:
>>>>> But if we want to start a particular osd or mon or mds ,its not
>>>>> working and there is no error
>>>>> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and don't g=
et any error
>>>>
>>>> That is expected, unless you are running init-ceph on the same nod=
e as
>>>> osd1 is on.
>>>>
>>>> It might be nice to have some kind of interface like "run command =
X on
>>>> osd1", but init-ceph is not that.
>>>>
>>>>> /etc/init.d/ceph -a stop also does not stop ceph on all nodes.It =
stops
>>>>> on current node only
>>>>> where as
>>>>> /etc/init.d/ceph -a killall works fine.
>>>>
>>>> That sounds like a bug. I'll see if I can fix it.
>>>
>>> I'm afraid I can't reproduce this.
>>>
>>> I ran /etc/init.d/ceph -a stop
>>>
>>> and it stopped ceph daemons running on remote nodes too. Looking at
>>> the code, it looks correct.
>>>
>>> Colin
>>>
>>
>>
>>
>> --
>> Thanks and Regards,
>> Upendra.M
>>
>



--=20
Thanks and Regards,
Upendra.M
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
