From: Ben Rowland <ben.rowland@gmail.com>
Subject: Re: Write Replication on Degraded PGs
Date: Mon, 18 Feb 2013 10:34:15 +0000
Message-ID: <CAEU8emkbgJWBe8djvLJVb5ktS2pvLb3pp+NV3rZAU__1SrAvqQ@mail.gmail.com>
References: <CAEU8emn4FV+00iShH1Jg1CoiC7gu+TkUxnKRiJEW7Vb420Q52A@mail.gmail.com>
	<CAEU8emmfGvDRGtyZXtbnpm_+f+p7Z944-U2Abt6=jEYD6LGLCQ@mail.gmail.com>
	<CAKMAVE9a467a4J23AkwBOV_Vedwz5CzU1fXj9-Cj7jzUPGpD3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:47712 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab3BRKeS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 05:34:18 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so4213757lbj.17
        for <ceph-devel@vger.kernel.org>; Mon, 18 Feb 2013 02:34:16 -0800 (PST)
In-Reply-To: <CAKMAVE9a467a4J23AkwBOV_Vedwz5CzU1fXj9-Cj7jzUPGpD3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sam,

I can still reproduce it.  I'm not clear if this is actually the
expected behaviour of Ceph: if reads/writes are done at the primary
OSD, and if a new primary can't be 'elected' (say due to a net-split
between failure domains), then is a failure expected, for consistency
guarantees?  Or am I missing something?  If this is the case, then
we'll have to rule out Ceph as it would not be appropriate for our
use-case.  We need high availability across failure domains, which
could become split from one another say by a network failure,
resulting in an incomplete PG.  In this case we still need read
availability.

I tried to enable osd logging by adding: "debug osd =3D 20" to the [osd=
]
section of my ceph.conf on the requesting machine, but didn't get much
output (see below).  Could the fundamental issue be that the primary
OSD on the other machine is down (intentionally, for our test case)
and no other primary can be elected (as the CRUSH rule demands one OSD
on each host)?  Apologies for any speculation on my part here, any
clarification will help a lot!

2013-02-18 10:11:51.913256 osd.0 10.9.64.61:6801/25064 5 : [WRN] 2
slow requests, 1 included below; oldest blocked for > 95.700672 secs
2013-02-18 10:11:51.913290 osd.0 10.9.64.61:6801/25064 6 : [WRN] slow
request 30.976297 seconds old, received at 2013-02-18 10:11:20.936876:
osd_op(client.4345.0:29594
4345.365_91bf7acb-8321-494e-bc79-6ab1625162bc [getxattrs,stat,read
0~524288] 9.5aaf1592) v4 currently reached pg

Thanks,

Ben

On Sat, Feb 16, 2013 at 5:42 PM, Sam Lang <sam.lang@inktank.com> wrote:
> On Fri, Feb 15, 2013 at 6:29 AM, Ben Rowland <ben.rowland@gmail.com> =
wrote:
>> Further to my question about reads on a degraded PG, my tests show
>> that indeed reads from rgw fail when not all OSDs in a PG are up, ev=
en
>> when the data is physically available on an up/in OSD.
>>
>> I have a "size" and "min_size" of 2 on my pool, and 2 hosts with 2
>> OSDs on each.  Crush map is set to write to 1 OSD on each of 2 hosts=
=2E
>> After writing a file to successfully to rgw via host 1, I then stop
>> all Ceph services on host 2.  Attempts to read the file I just wrote
>> time out after 30 seconds.  Starting Ceph again on host 2 allows rea=
ds
>> to proceed from host 1 once again.
>>
>> I see the following in ceph.log after the read times out:
>>
>> 2013-02-15 12:04:39.162685 osd.0 10.9.64.61:6802/19242 3 : [WRN] slo=
w
>> request 30.461867 seconds old, received at 2013-02-15 12:04:08.70063=
0:
>> osd_op(client.4345.0:21511
>> 4345.365_91bf7acb-8321-494e-bc79-6ab1625162bc [getxattrs,stat,read
>> 0~524288] 9.5aaf1592 RETRY) v4 currently reached pg
>>
>> After stopping Ceph on host 2, "ceph -s" reports:
>>
>>    health HEALTH_WARN 514 pgs degraded; 16 pgs incomplete; 16 pgs
>> stuck inactive; 632 pgs stuck unclean; recovery 44/6804 degraded
>> (0.647%)
>>    monmap e1: 1 mons at {a=3D10.9.64.61:6789/0}, election epoch 1, q=
uorum 0 a
>>    osdmap e155: 4 osds: 2 up, 2 in
>>     pgmap v4911: 632 pgs: 102 active+remapped, 514 active+degraded, =
16
>> incomplete; 844 MB data, 5969 MB used, 2280 MB / 8691 MB avail;
>> 44/6804 degraded (0.647%)
>>    mdsmap e1: 0/0/1 up
>>
>> OSD tree just in case:
>>
>> # id weight type name up/down reweight
>> -1 2 root default
>> -3 2 rack unknownrack
>> -2 1 host squeezeceph1
>> 0 1 osd.0 up 1
>> 2 1 osd.2 up 1
>> -4 1 host squeezeceph2
>> 1 1 osd.1 down 0
>> 3 0 osd.3 down 0
>>
>> Running "osd map" on both the container and object names say host 1 =
is
>> "acting" for that PG (not sure if I'm looking at the right pools,
>> though):
>>
>> $ ceph osd map .rgw.buckets aa94e84a-e720-45e1-8c85-4afa7d0f6b5c
>>
>> osdmap e155 pool '.rgw.buckets' (9) object
>> 'aa94e84a-e720-45e1-8c85-4afa7d0f6b5c' -> pg 9.494717b9 (9.1) -> up
>> [0] acting [0]
>>
>> $ ceph osd map .rgw 91bf7acb-8321-494e-bc79-6ab1625162bc
>>
>> osdmap e155 pool '.rgw' (3) object
>> '91bf7acb-8321-494e-bc79-6ab1625162bc' -> pg 3.1db18d16 (3.6) -> up
>> [2] acting [2]
>>
>> Any thoughts?  It doesn't seem right that taking out a single failur=
e
>> domain should cause this degradation.
>
> Hi Ben,
>
> Are you still seeing this?  Can you enable osd logging and restart th=
e
> osds on host 1?
> -sam
>
>>
>> Many thanks,
>>
>> Ben
>>
>> On Thu, Feb 14, 2013 at 11:53 PM, Ben Rowland <ben.rowland@gmail.com=
> wrote:
>>>> On 13 Feb 2013 18:16, "Gregory Farnum" <greg@inktank.com> wrote:
>>>> >
>>>> > On Wed, Feb 13, 2013 at 3:40 AM, Ben Rowland <ben.rowland@gmail.=
com> wrote:
>>>
>>>> So it sounds from the rest of your post like you'd want to, for ea=
ch
>>>> pool that RGW uses (it's not just .rgw), run "ceph osd set .rgw
>>>> min_size 2". (and for .rgw.buckets, etc etc)
>>>
>>> Thanks, that did the trick. When the number of up OSDs is less than
>>> min_size, writes block for 30s then return http 500. Ceph honours m=
y
>>> crush rule in this case - adding more OSDs to only one of two failu=
re
>>> domains continues to block writes - all well and good!
>>>
>>>> > If this is the expected behaviour of Ceph, then it seems to pref=
er
>>>> > write-availability over read-availability (in this case my data =
is
>>>> > only stored on 1 OSD, thus a SPOF).  Is there any way to change =
this
>>>> > trade-off, e.g. as you can in Cassandra with its write quorums?
>>>>
>>>> I'm not quite sure this is describing it correctly =97 Ceph guaran=
tees
>>>> that anything that's been written to disk will be readable later o=
n,
>>>> and placement groups won't go active if they can't retrieve all da=
ta.
>>>> The sort of flexible policies allowed by Cassandra aren't possible
>>>> within Ceph =97 it is a strictly consistent system.
>>>
>>> Are objects always readable even if a PG is missing some OSDs, and
>>> where it cannot recover? Example: 2 hosts each with 1 osd, pool
>>> min_size is 2, with a crush rule saying to write to both hosts. I
>>> write a file successfully, then one host goes down, and eventually =
is
>>> marked 'out'. Is the file readable on the 'up' host (say if I'm
>>> running rgw there?) What if the up host does not have the primary
>>> copy?
>>>
>>> Furthermore, if Ceph is strictly consistent, how would it resolve
>>> possible stale reads? Say, if in the 2 hosts example, the network
>>> connection died, but min_size was set to 1. Would it be possible fo=
r
>>> writes to proceed, say making edits to an existing object? Could
>>> readers at the other host see stale data?
>>>
>>> Thanks again in advance,
>>>
>>> Ben
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
