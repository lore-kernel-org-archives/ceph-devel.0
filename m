From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Mon, 9 Jan 2012 17:06:56 -0800
Message-ID: <CAF3hT9BBe-iiv_Fn6S_gsTWoyaba0ArWZt0fG8Uu=SQB2DD8sA@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
	<CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
	<CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
	<CA+o_KfsG=_TvQVNJ1HcUcTvntN5gqKCC3eXFhYwZVj3_fF4wRg@mail.gmail.com>
	<CAF3hT9Bq6Nwan2wF54Gz0OpHWoO9pGJE1h2a-ke6=7wW4wBSrA@mail.gmail.com>
	<CA+o_KfuigaFGYvHVOk_W-gpTQryheYfc4=9v5nxemUyqhH-GQw@mail.gmail.com>
	<CAF3hT9AUFiZz01PzE9n8VYK0NJCQBFndKVsiOfAX5-ZNrNw+Og@mail.gmail.com>
	<CA+o_KfvFnNqhiYuySZnhz7jdhj=MXgpiGqZA+D7Dw+fqZ7VNjA@mail.gmail.com>
	<CAF3hT9A=iDLWtmY_GsiS49Mi-pDNN1U0Rs3MuJsW93JFDObJ+w@mail.gmail.com>
	<CA+o_KfttjRQN_7_XURq7rLSC88ir2AErorr-3J2EdtS=nLCW0A@mail.gmail.com>
	<CAF3hT9A9BYPqAWh35+9CSndkzte+gmjZ762OkRUPZ0=FDUkhkA@mail.gmail.com>
	<CA+o_KftBMHMqk4zRKp3z-fe+KBSjRsoon4OCbc47bWdjQQTQ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:55815 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2AJBG5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2012 20:06:57 -0500
Received: by qadb15 with SMTP id b15so2626955qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2012 17:06:57 -0800 (PST)
In-Reply-To: <CA+o_KftBMHMqk4zRKp3z-fe+KBSjRsoon4OCbc47bWdjQQTQ=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 6, 2012 at 4:36 AM, Karoly Horvath <rhswdev@gmail.com> wrot=
e:
> Hi,
>
> no, this is a different problem, this time the failover was successfu=
l.

Aha, a different problem indeed! I assume that mon.1 was located on
beta (the computer you killed)? It turns out that the standby MDS was
connected to the monitor you killed, and the MDS took a long time to
time out its connection so it didn't find out it needed to go active
until after the default connection timeout period had elapsed.

I've created a bug to track this issue:
http://tracker.newdream.net/issues/1912 (I will push a fix for it to
master tonight or tomorrow).
In the meantime you can work around it by only running one monitor and
not killing the node it's on; if you can attempt to reproduce the
previous issue that is a more interesting one! :)
-Greg

> 2012-01-05 12:49:48.185815 =A0 mds e376: 1/1/1 up {0=3Dbeta=3Dup:acti=
ve}, 1 up:standby
> 2012-01-05 12:50:32.200055 =A0 mds e377: 1/1/1 up
> {0=3Dalpha=3Dup:replay(laggy or crashed)}
> 2012-01-05 13:05:09.800119 7fd192bfa700 mds.0.55 =A0waiting for osdma=
p
> 568 (which blacklists prior instance)
> 2012-01-05 13:06:07.851253 7fd192bfa700 mds.0.55 request_state up:act=
ive
> 2012-01-05 13:06:07.851259 7fd192bfa700 mds.0.55 beacon_send up:activ=
e
> seq 526 (currently up:rejoin)
>
> It took 15 minutes to get to the point where it prints "waiting for
> osdmap". After that it was quite fast. I hope someone will find the
> problem...
>
> --
> Karoly Horvath
> rhswdev@gmail.com
>
>
> On Thu, Jan 5, 2012 at 7:06 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> On Thu, Jan 5, 2012 at 5:24 AM, Karoly Horvath <rhswdev@gmail.com> w=
rote:
>>> Hi,
>>>
>>> back from holiday.
>>>
>>> I did a successful power unplug test now, but the FS was unavailabl=
e
>>> for 16 minutes which is clearly wrong...
>>>
>>> I have the log files but the MDS log is 1.2 gigabyte, if you let me
>>> know which lines to filter / filter out I will =A0upload it somewhe=
re...
>>>
>>> --
>>> Karoly Horvath
>>
>> Assuming it's the same error as last time, the log will have a line
>> that contains "waiting for osdmap n (which blacklists prior
>> instance)", where n is an epoch number.
>>
>> Then at some later point there will be a line that looks something
>> like the following:
>> "2011-12-21 13:45:17.594746 7f4885307700 -- xxx.xxx.xxx.31:6800/4438
>> <=3D=3D mon.2 xxx.xxx.xxx.35:6789/0 9 =3D=3D=3D=3D osd_map(y..z src =
has 1..495) v2
>> =3D=3D=3D=3D 748+0+0 (656995691 0 0) 0x1637400 con 0x163c000"
>> Where y and z are an interval which contains n. (In the previous log=
,
>> and probably here too, y=3Dz=3Dn.) I'm going to be interested in tho=
se two
>> lines and the stuff following when the osdmap arrives. Probably I wi=
ll
>> only care about "objecter" lines, but it might be all of them...try
>> trimming off the minute following that osdmap line; it'll probably
>> contain more than I care about. :)
>> -Greg
>>
>>
>>> On Fri, Dec 23, 2011 at 12:00 AM, Gregory Farnum
>>> <gregory.farnum@dreamhost.com> wrote:
>>>> On Wed, Dec 21, 2011 at 8:43 AM, Karoly Horvath <rhswdev@gmail.com=
> wrote:
>>>>> On Wed, Dec 21, 2011 at 4:13 PM, Gregory Farnum
>>>>>>> By client I assume you mean the kernel driver.. the FS is freez=
ed, so
>>>>>>> I cannot unmount (cannot even `shutdown`).. how can I force the=
 client
>>>>>>> to reconnect?
>>>>>>
>>>>>> Try a lazy force unmount:
>>>>>> umount -lf ceph_mnt_point/
>>>>>> And then mount again.
>>>>>
>>>>> wow, never heard about this, thanks.:)
>>>>> will report with the next mail
>>>>>
>>>>> In the meantime I did one test, killing mds+osd+mon on beta,
>>>>> it's jammed in '{0=3Dalpha=3Dup:replay}', after 45 minutes I shut=
 it down...
>>>>> I attached the logs.
>>>>
>>>> Oh, this is very odd! The MDS goes to sleep while it waits for an
>>>> up-to-date OSDMap, but it never seems to get woken up even though =
I
>>>> see the message sending in the OSDMap.
>>>>
>>>> So let's try this one more time, but this time also add in "debug
>>>> objecter =3D 20" to the MDS config...Those logs will include every=
thing
>>>> I need, or nothing will, promise! :)
>>>> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
