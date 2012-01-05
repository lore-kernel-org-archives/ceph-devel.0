From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Thu, 5 Jan 2012 11:06:42 -0800
Message-ID: <CAF3hT9A9BYPqAWh35+9CSndkzte+gmjZ762OkRUPZ0=FDUkhkA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63944 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab2AETGm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 14:06:42 -0500
Received: by iaeh11 with SMTP id h11so1323473iae.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2012 11:06:42 -0800 (PST)
In-Reply-To: <CA+o_KfttjRQN_7_XURq7rLSC88ir2AErorr-3J2EdtS=nLCW0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jan 5, 2012 at 5:24 AM, Karoly Horvath <rhswdev@gmail.com> wrot=
e:
> Hi,
>
> back from holiday.
>
> I did a successful power unplug test now, but the FS was unavailable
> for 16 minutes which is clearly wrong...
>
> I have the log files but the MDS log is 1.2 gigabyte, if you let me
> know which lines to filter / filter out I will =A0upload it somewhere=
=2E..
>
> --
> Karoly Horvath

Assuming it's the same error as last time, the log will have a line
that contains "waiting for osdmap n (which blacklists prior
instance)", where n is an epoch number.

Then at some later point there will be a line that looks something
like the following:
"2011-12-21 13:45:17.594746 7f4885307700 -- xxx.xxx.xxx.31:6800/4438
<=3D=3D mon.2 xxx.xxx.xxx.35:6789/0 9 =3D=3D=3D=3D osd_map(y..z src has=
 1..495) v2
=3D=3D=3D=3D 748+0+0 (656995691 0 0) 0x1637400 con 0x163c000"
Where y and z are an interval which contains n. (In the previous log,
and probably here too, y=3Dz=3Dn.) I'm going to be interested in those =
two
lines and the stuff following when the osdmap arrives. Probably I will
only care about "objecter" lines, but it might be all of them...try
trimming off the minute following that osdmap line; it'll probably
contain more than I care about. :)
-Greg


> On Fri, Dec 23, 2011 at 12:00 AM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> On Wed, Dec 21, 2011 at 8:43 AM, Karoly Horvath <rhswdev@gmail.com> =
wrote:
>>> On Wed, Dec 21, 2011 at 4:13 PM, Gregory Farnum
>>>>> By client I assume you mean the kernel driver.. the FS is freezed=
, so
>>>>> I cannot unmount (cannot even `shutdown`).. how can I force the c=
lient
>>>>> to reconnect?
>>>>
>>>> Try a lazy force unmount:
>>>> umount -lf ceph_mnt_point/
>>>> And then mount again.
>>>
>>> wow, never heard about this, thanks.:)
>>> will report with the next mail
>>>
>>> In the meantime I did one test, killing mds+osd+mon on beta,
>>> it's jammed in '{0=3Dalpha=3Dup:replay}', after 45 minutes I shut i=
t down...
>>> I attached the logs.
>>
>> Oh, this is very odd! The MDS goes to sleep while it waits for an
>> up-to-date OSDMap, but it never seems to get woken up even though I
>> see the message sending in the OSDMap.
>>
>> So let's try this one more time, but this time also add in "debug
>> objecter =3D 20" to the MDS config...Those logs will include everyth=
ing
>> I need, or nothing will, promise! :)
>> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
