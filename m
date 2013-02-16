From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Write Replication on Degraded PGs
Date: Sat, 16 Feb 2013 11:42:26 -0600
Message-ID: <CAKMAVE9a467a4J23AkwBOV_Vedwz5CzU1fXj9-Cj7jzUPGpD3g@mail.gmail.com>
References: <CAEU8emn4FV+00iShH1Jg1CoiC7gu+TkUxnKRiJEW7Vb420Q52A@mail.gmail.com>
	<CAEU8emmfGvDRGtyZXtbnpm_+f+p7Z944-U2Abt6=jEYD6LGLCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:59812 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab3BPRm0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:42:26 -0500
Received: by mail-ob0-f182.google.com with SMTP id va7so4568338obc.13
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:42:26 -0800 (PST)
In-Reply-To: <CAEU8emmfGvDRGtyZXtbnpm_+f+p7Z944-U2Abt6=jEYD6LGLCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben Rowland <ben.rowland@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 15, 2013 at 6:29 AM, Ben Rowland <ben.rowland@gmail.com> wr=
ote:
> Further to my question about reads on a degraded PG, my tests show
> that indeed reads from rgw fail when not all OSDs in a PG are up, eve=
n
> when the data is physically available on an up/in OSD.
>
> I have a "size" and "min_size" of 2 on my pool, and 2 hosts with 2
> OSDs on each.  Crush map is set to write to 1 OSD on each of 2 hosts.
> After writing a file to successfully to rgw via host 1, I then stop
> all Ceph services on host 2.  Attempts to read the file I just wrote
> time out after 30 seconds.  Starting Ceph again on host 2 allows read=
s
> to proceed from host 1 once again.
>
> I see the following in ceph.log after the read times out:
>
> 2013-02-15 12:04:39.162685 osd.0 10.9.64.61:6802/19242 3 : [WRN] slow
> request 30.461867 seconds old, received at 2013-02-15 12:04:08.700630=
:
> osd_op(client.4345.0:21511
> 4345.365_91bf7acb-8321-494e-bc79-6ab1625162bc [getxattrs,stat,read
> 0~524288] 9.5aaf1592 RETRY) v4 currently reached pg
>
> After stopping Ceph on host 2, "ceph -s" reports:
>
>    health HEALTH_WARN 514 pgs degraded; 16 pgs incomplete; 16 pgs
> stuck inactive; 632 pgs stuck unclean; recovery 44/6804 degraded
> (0.647%)
>    monmap e1: 1 mons at {a=3D10.9.64.61:6789/0}, election epoch 1, qu=
orum 0 a
>    osdmap e155: 4 osds: 2 up, 2 in
>     pgmap v4911: 632 pgs: 102 active+remapped, 514 active+degraded, 1=
6
> incomplete; 844 MB data, 5969 MB used, 2280 MB / 8691 MB avail;
> 44/6804 degraded (0.647%)
>    mdsmap e1: 0/0/1 up
>
> OSD tree just in case:
>
> # id weight type name up/down reweight
> -1 2 root default
> -3 2 rack unknownrack
> -2 1 host squeezeceph1
> 0 1 osd.0 up 1
> 2 1 osd.2 up 1
> -4 1 host squeezeceph2
> 1 1 osd.1 down 0
> 3 0 osd.3 down 0
>
> Running "osd map" on both the container and object names say host 1 i=
s
> "acting" for that PG (not sure if I'm looking at the right pools,
> though):
>
> $ ceph osd map .rgw.buckets aa94e84a-e720-45e1-8c85-4afa7d0f6b5c
>
> osdmap e155 pool '.rgw.buckets' (9) object
> 'aa94e84a-e720-45e1-8c85-4afa7d0f6b5c' -> pg 9.494717b9 (9.1) -> up
> [0] acting [0]
>
> $ ceph osd map .rgw 91bf7acb-8321-494e-bc79-6ab1625162bc
>
> osdmap e155 pool '.rgw' (3) object
> '91bf7acb-8321-494e-bc79-6ab1625162bc' -> pg 3.1db18d16 (3.6) -> up
> [2] acting [2]
>
> Any thoughts?  It doesn't seem right that taking out a single failure
> domain should cause this degradation.

Hi Ben,

Are you still seeing this?  Can you enable osd logging and restart the
osds on host 1?
-sam

>
> Many thanks,
>
> Ben
>
> On Thu, Feb 14, 2013 at 11:53 PM, Ben Rowland <ben.rowland@gmail.com>=
 wrote:
>>> On 13 Feb 2013 18:16, "Gregory Farnum" <greg@inktank.com> wrote:
>>> >
>>> > On Wed, Feb 13, 2013 at 3:40 AM, Ben Rowland <ben.rowland@gmail.c=
om> wrote:
>>
>>> So it sounds from the rest of your post like you'd want to, for eac=
h
>>> pool that RGW uses (it's not just .rgw), run "ceph osd set .rgw
>>> min_size 2". (and for .rgw.buckets, etc etc)
>>
>> Thanks, that did the trick. When the number of up OSDs is less than
>> min_size, writes block for 30s then return http 500. Ceph honours my
>> crush rule in this case - adding more OSDs to only one of two failur=
e
>> domains continues to block writes - all well and good!
>>
>>> > If this is the expected behaviour of Ceph, then it seems to prefe=
r
>>> > write-availability over read-availability (in this case my data i=
s
>>> > only stored on 1 OSD, thus a SPOF).  Is there any way to change t=
his
>>> > trade-off, e.g. as you can in Cassandra with its write quorums?
>>>
>>> I'm not quite sure this is describing it correctly =97 Ceph guarant=
ees
>>> that anything that's been written to disk will be readable later on=
,
>>> and placement groups won't go active if they can't retrieve all dat=
a.
>>> The sort of flexible policies allowed by Cassandra aren't possible
>>> within Ceph =97 it is a strictly consistent system.
>>
>> Are objects always readable even if a PG is missing some OSDs, and
>> where it cannot recover? Example: 2 hosts each with 1 osd, pool
>> min_size is 2, with a crush rule saying to write to both hosts. I
>> write a file successfully, then one host goes down, and eventually i=
s
>> marked 'out'. Is the file readable on the 'up' host (say if I'm
>> running rgw there?) What if the up host does not have the primary
>> copy?
>>
>> Furthermore, if Ceph is strictly consistent, how would it resolve
>> possible stale reads? Say, if in the 2 hosts example, the network
>> connection died, but min_size was set to 1. Would it be possible for
>> writes to proceed, say making edits to an existing object? Could
>> readers at the other host see stale data?
>>
>> Thanks again in advance,
>>
>> Ben
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
