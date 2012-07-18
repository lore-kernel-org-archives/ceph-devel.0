From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: ceph status reporting non-existing osd
Date: Wed, 18 Jul 2012 23:07:42 +0400
Message-ID: <CABYiri9WYyip_TVXi8EGTfSV7=opcaJ9DWV6+guMwX--Lj+jng@mail.gmail.com>
References: <4FFFD9AB.40608@xdel.ru> <CAPYLRzgOHf9nMdK5oOrs6++H22iFLYvcbhMQsZtd8Z3OskX=yw@mail.gmail.com>
 <alpine.DEB.2.00.1207131009280.9771@cobra.newdream.net> <CABYiri9wEoPs87qUr2MANX_AHB-aHprJBdXV0o4TxeDPj6SrhQ@mail.gmail.com>
 <823856EB9E9B4D1EBB352F93465B742A@inktank.com> <CABYiri-D4qPv1nQ4KHkwDS6wrH9gZdSu=b6ePxk61Ks-qx+Ajg@mail.gmail.com>
 <C286CA87975941CD913337EAC9844935@inktank.com> <CABYiri9RAYrVaqePQq00J-KK32_Y_pf1c0jHxhJD2ZVBRrxOhA@mail.gmail.com>
 <45F07A6460B34ED5A9C589696933A936@inktank.com> <CABYiri_sCkq=7-NFgP6ohT=yZxFJboqgC5es_xDb+ijUZ5hrYg@mail.gmail.com>
 <9D6CE6A067E543BFBDDD0A29BB2E34F9@inktank.com> <CABYiri9neTby8heHcw9PsZG0tGgX4nJYrCQiBmE-rKX0X8W3LA@mail.gmail.com>
 <CAPYLRzg9anTj8vgX82=RJBiw57fyhQ1qBWs8Q4-Ymrv-f3Q2jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33863 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab2GRTIF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 15:08:05 -0400
Received: by wgbdr13 with SMTP id dr13so1652167wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 12:08:02 -0700 (PDT)
In-Reply-To: <CAPYLRzg9anTj8vgX82=RJBiw57fyhQ1qBWs8Q4-Ymrv-f3Q2jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Jul 18, 2012 at 10:30 PM, Gregory Farnum <greg@inktank.com> wro=
te:
> On Wed, Jul 18, 2012 at 12:47 AM, Andrey Korolyov <andrey@xdel.ru> wr=
ote:
>> On Wed, Jul 18, 2012 at 11:18 AM, Gregory Farnum <greg@inktank.com> =
wrote:
>>> On Tuesday, July 17, 2012 at 11:22 PM, Andrey Korolyov wrote:
>>>> On Wed, Jul 18, 2012 at 10:09 AM, Gregory Farnum <greg@inktank.com=
 (mailto:greg@inktank.com)> wrote:
>>>> > Hrm. That shouldn't be possible if the OSD has been removed. How=
 did you take it out? It sounds like maybe you just marked it in the OU=
T state (and turned it off quite quickly) without actually taking it ou=
t of the cluster?
>>>> > -Greg
>>>>
>>>>
>>>>
>>>> As I have did removal, it was definitely not like that - at first
>>>> place, I have marked osds(4 and 5 on same host) out, then rebuilt
>>>> crushmap and then kill osd processes. As I mentioned before, osd.4
>>>> doest not exist in crushmap and therefore it shouldn`t be reported=
 at
>>>> all(theoretically).
>>>
>>> Okay, that's what happened =E2=80=94 marking an OSD out in the CRUS=
H map means all the data gets moved off it, but that doesn't remove it =
from all the places where it's registered in the monitor and in the map=
, for a couple reasons:
>>> 1) You might want to mark an OSD out before taking it down, to allo=
w for more orderly data movement.
>>> 2) OSDs can get marked out automatically, but the system shouldn't =
be able to forget about them on its own.
>>> 3) You might want to remove an OSD from the CRUSH map in the proces=
s of placing it somewhere else (perhaps you moved the physical machine =
to a new location).
>>> etc.
>>>
>>> You want to run "ceph osd rm 4 5" and that should unregister both o=
f them from everything[1]. :)
>>> -Greg
>>> [1]: Except for the full lists, which have a bug in the version of =
code you're running =E2=80=94 remove the OSDs, then adjust the full rat=
ios again, and all will be well.
>>>
>>
>> $ ceph osd rm 4
>> osd.4 does not exist
>> $ ceph -s
>>    health HEALTH_WARN 1 near full osd(s)
>>    monmap e3: 3 mons at
>> {0=3D192.168.10.129:6789/0,1=3D192.168.10.128:6789/0,2=3D192.168.10.=
127:6789/0},
>> election epoch 58, quorum 0,1,2 0,1,2
>>    osdmap e2198: 4 osds: 4 up, 4 in
>>     pgmap v586056: 464 pgs: 464 active+clean; 66645 MB data, 231 GB
>> used, 95877 MB / 324 GB avail
>>    mdsmap e207: 1/1/1 up {0=3Da=3Dup:active}
>>
>> $ ceph health detail
>> HEALTH_WARN 1 near full osd(s)
>> osd.4 is near full at 89%
>>
>> $ ceph osd dump
>> ....
>> max_osd 4
>> osd.0 up   in  weight 1 up_from 2183 up_thru 2187 down_at 2172
>> last_clean_interval [2136,2171) 192.168.10.128:6800/4030
>> 192.168.10.128:6801/4030 192.168.10.128:6802/4030 exists,up
>> 68b3deec-e80a-48b7-9c29-1b98f5de4f62
>> osd.1 up   in  weight 1 up_from 2136 up_thru 2186 down_at 2135
>> last_clean_interval [2115,2134) 192.168.10.129:6800/2980
>> 192.168.10.129:6801/2980 192.168.10.129:6802/2980 exists,up
>> b2a26fe9-aaa8-445f-be1f-fa7d2a283b57
>> osd.2 up   in  weight 1 up_from 2181 up_thru 2187 down_at 2172
>> last_clean_interval [2136,2171) 192.168.10.128:6803/4128
>> 192.168.10.128:6804/4128 192.168.10.128:6805/4128 exists,up
>> 378d367a-f7fb-4892-9ec9-db8ffdd2eb20
>> osd.3 up   in  weight 1 up_from 2136 up_thru 2186 down_at 2135
>> last_clean_interval [2115,2134) 192.168.10.129:6803/3069
>> 192.168.10.129:6804/3069 192.168.10.129:6805/3069 exists,up
>> faf8eda8-55fc-4a0e-899f-47dbd32b81b8
>> ....
>
> Hrm. How did you create your new crush map? All the normal avenues of
> removing an OSD from the map set a flag which the PGMap uses to delet=
e
> its records (which would prevent it reappearing in the full list), an=
d
> I can't see how setcrushmap would remove an OSD from the map (althoug=
h
> there might be a code path I haven't found).

Manually, by deleting osd4|5 entries and reweighing remaining nodes.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
