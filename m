From: Damien Churchill <damoxc@gmail.com>
Subject: Re: pgs stuck inactive
Date: Fri, 6 Apr 2012 18:53:08 +0100
Message-ID: <CAFtEh-evVi0q8CZmbPJX_WaCD_y2E=RBf6nNu13106E8hopk5A@mail.gmail.com>
References: <CAFtEh-dcEKQ2AzcVmu1G5i-zFHgim5SLZvEmNtDsvkHt+JnzLA@mail.gmail.com>
	<CACLRD_2yhpoUGoivHQpp-LyO82MdTz5SpD0MN5b_vEoqSGBzgg@mail.gmail.com>
	<CAFtEh-dsM_G5GCyqnnBVfAc7GmKZLZcLzkQzrCAGjDgyLC3CGg@mail.gmail.com>
	<CACLRD_1NiFHjx_PZxokVBkADG0z+A61Sj57NJFyYF_vM=ZKSbA@mail.gmail.com>
	<CAFtEh-dLfUYpSbUJamReXB2e1JHm0b55HPs-h1wjCXym-cmHyA@mail.gmail.com>
	<CACLRD_3ccxvLiHxEHMBK+Q+2Ag41a+M07NofU9+Z8Fr06vvvfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35718 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab2DFRxI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 13:53:08 -0400
Received: by yenl12 with SMTP id l12so1333655yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Apr 2012 10:53:08 -0700 (PDT)
In-Reply-To: <CACLRD_3ccxvLiHxEHMBK+Q+2Ag41a+M07NofU9+Z8Fr06vvvfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Okay, uploaded it to http://damoxc.net/ceph/osd.0.log.gz. I restarted
the osd with debug osd =3D 20 and let it run for 5 minutes or so.

On 6 April 2012 18:30, Samuel Just <sam.just@dreamhost.com> wrote:
> Hmm, osd.0 should be enough. =C2=A0I need osd debugging at around 20 =
from
> when the osd started. =C2=A0Restarting the osd with debugging at 20 w=
ould
> also work fine.
> -Sam
>
> On Fri, Apr 6, 2012 at 9:55 AM, Damien Churchill <damoxc@gmail.com> w=
rote:
>> I've got that directory on 3 of the osds: 0, 3 and 4. Do you want th=
e
>> logs to all 3 of them?
>>
>> On 6 April 2012 17:50, Samuel Just <sam.just@dreamhost.com> wrote:
>>> Is there a 0.138_head directory under current/ on any of your osds?
>>> If so, can you post the log to that osd? =C2=A0I could also use the=
 osd.0
>>> log.
>>> -Sam
>>>
>>> On Wed, Apr 4, 2012 at 2:44 PM, Damien Churchill <damoxc@gmail.com>=
 wrote:
>>>> I've uploaded them to:
>>>>
>>>> http://damoxc.net/ceph/osdmap
>>>> http://damoxc.net/ceph/pg_dump
>>>>
>>>> Thanks
>>>>
>>>> On 4 April 2012 21:51, Samuel Just <sam.just@dreamhost.com> wrote:
>>>>> Can you post a copy of your osd map and the output of 'ceph pg du=
mp' ?
>>>>> =C2=A0You can get the osdmap via 'ceph osd getmap -o <filename>'.
>>>>> -Sam
>>>>>
>>>>> On Wed, Apr 4, 2012 at 1:12 AM, Damien Churchill <damoxc@gmail.co=
m> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm having some trouble getting some pgs to stop being inactive.=
 The
>>>>>> cluster is running 0.44.1 and the kernel version is 3.2.x.
>>>>>>
>>>>>> ceph -s reports:
>>>>>> 2012-04-04 09:08:57.816029 =C2=A0 =C2=A0pg v188540: 990 pgs: 223=
 inactive, 767
>>>>>> active+clean; 205 GB data, 1013 GB used, 8204 GB / 9315 GB avail
>>>>>> 2012-04-04 09:08:57.817970 =C2=A0 mds e2198: 1/1/1 up {0=3Dnode2=
4=3Dup:active},
>>>>>> 4 up:standby
>>>>>> 2012-04-04 09:08:57.818024 =C2=A0 osd e5910: 5 osds: 5 up, 5 in
>>>>>> 2012-04-04 09:08:57.818201 =C2=A0 log 2012-04-04 09:04:03.838358=
 osd.3
>>>>>> 172.22.10.24:6801/30000 159 : [INF] 0.13d scrub ok
>>>>>> 2012-04-04 09:08:57.818280 =C2=A0 mon e7: 3 mons at
>>>>>> {node21=3D172.22.10.21:6789/0,node22=3D172.22.10.22:6789/0,node2=
3=3D172.22.10.23:6789/0}
>>>>>>
>>>>>> ceph health says:
>>>>>> 2012-04-04 09:09:01.651053 mon <- [health]
>>>>>> 2012-04-04 09:09:01.666585 mon.1 -> 'HEALTH_WARN 223 pgs stuck
>>>>>> inactive; 223 pgs stuck unclean' (0)
>>>>>>
>>>>>> I was wondering if anyone has any suggestions about how to resol=
ve
>>>>>> this, or things to look for. I've tried restarted the ceph daemo=
ns on
>>>>>> the various nodes a few times to no-avail. I don't think that th=
ere is
>>>>>> anything wrong with any of the nodes either.
>>>>>>
>>>>>> Thanks in advance,
>>>>>> Damien
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-in=
fo.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
