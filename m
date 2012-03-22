From: Borodin Vladimir <v.a.borodin@gmail.com>
Subject: Re: Theoretical questions
Date: Thu, 22 Mar 2012 07:40:05 +0300
Message-ID: <CAGEBRh0ukyt6HGbQ6Souw3V0OFOuytWOaHPrVTqTZuiq9=F4SQ@mail.gmail.com>
References: <CAGEBRh0t-X4-HE5-nyFbAmW7-k+yj7d4FjhiZL_WhQ6CjPToew@mail.gmail.com>
	<CAGEBRh176DeZ_sj0hMsBSXs+tKm52D+iCCRZew+XUDpTL7Kf6g@mail.gmail.com>
	<CACLRD_093zadirQSkC+z4ec6ULs3JGBVgB=Bo2x-k4QrLiUVWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2CVEkG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 00:40:06 -0400
Received: by iagz16 with SMTP id z16so2577008iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 21:40:05 -0700 (PDT)
In-Reply-To: <CACLRD_093zadirQSkC+z4ec6ULs3JGBVgB=Bo2x-k4QrLiUVWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thank you very much, Samuel. And sorry for writing from different e-mai=
ls.

2012/3/22 Samuel Just <sam.just@dreamhost.com>:
> First, an object is hashed into a pg. =9AThe pg is then moved between
> osds as osds are added and removed (or fail).
>
> Once enough other osds report an osd as failed, the monitors will mar=
k
> the osd as down. =9ADuring this time,
> pgs with that osd as a replica will continue to serve writes in a
> degraded state writing to the remaining
> replicas. =9ASome time later, that osd will be marked out causing the=
 pg
> to be remapped to different osds,
> at which point the degraded objects will re-replicate. =9AThe time
> between being marked down and being
> marked out is controlled by mon_osd_down_out_interval. =9ANote that
> setting that option to 0 prevents the
> down osd from ever being marked out. =9AI have created a bug to allow
> the user to force a down osd to
> be immediately marked out (#2198).
> -Sam Just
>
> On Wed, Mar 21, 2012 at 11:44 AM, =E2=CF=D2=CF=C4=C9=CE =F7=CC=C1=C4=C9=
=CD=C9=D2 <volk@xakep.ru> wrote:
>> Thank you, Samuel.
>>
>> Here is what I meant in fourth question:
>> We have pool "data" and in the crushmap there is a rule like this:
>> rule data {
>> =9A =9A =9A =9Aruleset 1
>> =9A =9A =9A =9Atype replicated
>> =9A =9A =9A =9Amin_size 3
>> =9A =9A =9A =9Amax_size 3
>> =9A =9A =9A =9Astep take root
>> =9A =9A =9A =9Astep chooseleaf firstn 0 type rack
>> =9A =9A =9A =9Astep emit
>> }
>> The client tries to write an object to pool "data". Ceph selects PG
>> where to put the object. The object is then written to the buffer of
>> the primary OSD. Primary OSD then tries to write copies to buffer of
>> two replica OSDs and fails (perhaps, they are marked as down). Does
>> client recieve ack? Or will ceph try to write the object into anothe=
r
>> PG?
>> Primary OSD then writes object from buffer to disk. Two replicas are
>> still down. Does client receive commit?
>> Is there a way to write always 3 successfull copies of an object and
>> then return ack to client?
>>
>> 21.03.2012, 21:12, "Samuel Just" <sam.just@dreamhost.com>:
>>> 1. The standby mds does not maintain cached metadata in memory or
>>> serve reads. =9AWhen taking over from a failed mds, it reads the
>>> primary's journal, which does warm up its cache somewhat. =9AOption=
ally,
>>> you can put an mds into standby-replay for an active mds. =9AIn thi=
s case,
>>> the standby-replay mds will continually replay the primary's journa=
l in
>>> order to more quickly take over in the case of a crash.
>>>
>>> 2. Primary-copy is the only strategy currently implemented.
>>>
>>> 3. On a sync, we wait for commits to ensure data safety.
>>>
>>> 4. I don't quite understand this question.
>>>
>>> 5. =9ACurrently, there is not a good way to accomplish this using o=
nly
>>> ceph. =9AReplication is synchronous on writes, so you would be payi=
ng
>>> the latency cost between data centers on each write if you wanted t=
o
>>> replicate between data centers. =9AWe don't currently support readi=
ng from
>>> the closest replica.
>>>
>>> On Wed, Mar 21, 2012 at 2:22 AM, Borodin Vladimir <v.a.borodin@gmai=
l.com> wrote:
>>>
>>>> =9AHi all.
>>>>
>>>> =9AI've read everything in ceph.newdream.net/docs and
>>>> =9Aceph.newdream.net/wiki. I've also read some articles from
>>>> =9Aceph.newdream.net/publications. But I haven't found answers on =
some
>>>> =9Aquestions:
>>>> =9A1. there is one active MDS and one in standby mode. Active MDS =
caches
>>>> =9Aall metadata in RAM. Does standby MDS copy this information to =
RAM?
>>>> =9AWill it take metadata from OSDs on every request after primary =
MDS
>>>> =9Afailure? Do read requests come to standby MDS?
>>>> =9A2. what replication strategy on OSDs (primary-copy, chain or sp=
lay) is
>>>> =9Aturned on by default?
>>>> =9A3. when does kernel client understand that the write was succes=
sfull
>>>> =9A(when it recieves ack or commit from primary OSD)?
>>>> =9A4. I want to have 3 copies of each object. By default there is =
a way
>>>> =9Ato write only one successfull copy (and two others give a failu=
re),
>>>> =9Aisn't that? Is there a way to turn this off (even if one of thr=
ee
>>>> =9Acopies failed, the object will be placed to another PG)?
>>>> =9A5. if I have several data centers with good network connection,=
 what
>>>> =9Ais the way to provide data locality? For example, most of write=
 and
>>>> =9Aread requests from Spain come to Spanish DC and most of write a=
nd read
>>>> =9Arequests from Russia come to Russian DC. Is it posible?
>>>>
>>>> =9ARegards,
>>>> =9AVladimir.
>>>> =9A--
>>>> =9ATo unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>>>> =9Athe body of a message to majordomo@vger.kernel.org
>>>> =9AMore majordomo info at =9Ahttp://vger.kernel.org/majordomo-info=
=2Ehtml
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.htm=
l
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
