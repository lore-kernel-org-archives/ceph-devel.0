From: Samuel Just <sam.just@inktank.com>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sat, 25 May 2013 11:06:08 -0700
Message-ID: <CA+4uBUY2TRTTQxPhsA9tdES0HdZph03a8XNLghSTUNRuXa1OKw@mail.gmail.com>
References: <51A0A6B2.9060105@dachary.org>
	<20130525123315.GA13595@apia.perrit.net>
	<51A0CA44.5000609@dachary.org>
	<20130525144818.GC32615@apia.perrit.net>
	<51A0F6D9.8080905@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:54608 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491Ab3EYSGK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 May 2013 14:06:10 -0400
Received: by mail-ea0-f172.google.com with SMTP id d10so3174471eaj.17
        for <ceph-devel@vger.kernel.org>; Sat, 25 May 2013 11:06:09 -0700 (PDT)
In-Reply-To: <51A0F6D9.8080905@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: leen@consolejunkie.net, Ceph Development <ceph-devel@vger.kernel.org>

Hi, thanks for taking the time to try to get all this documented!

Placement groups are assigned to a set of OSDs by crush.

(4.1, osdmap(e 1)) --CRUSH--> [3,1,2]

where the primary is 3.  When 3 dies, the osdmap is updated to reflect =
this
and we get a new mapping for pg 4.1:

(4,1, osdmap(e 2)) --CRUSH--> [1,2,4]

Here, 1 and 2 already have up-to-date copies of 4.1.  osd 4, however, n=
eeds
to be brought up to date.  During peering, osd 1 will learn that osd 4
falls into
1 of 2 cases.

Case 1 is that osd 4 already had an old copy of pg 4.1 AND its pg log f=
or pg
4.1 happens to overlap osd 1's pg log for pg 4.1.  In that case, by run=
ning
through the log of operations, we can determine exactly which objects n=
eed
to be copied over.  We usually refer to this as just "recovery" (or log=
 based
recovery).

In case 2, either osd 4's pg log does not overlap that of osd 1.  In th=
is case,
we cannot determine from the log which objects need to be copied over.
To bring osd 4 up to date, we therefore need to backfill.

Backfill involves the primary and the backfill peer (there is only ever=
 one in
the acting set at a time, see PG::choose_acting) scanning over their pg=
 stores
and copying the objects which are different or missing from the primary=
 to the
backfill peer.  Because this may take a long time, we track the a last_=
backfill
attribute for each local pg copy indicating how far the local copy has =
been
backfilled.  In the case that the copy is complete, last_backfill is
hobject_t::max().

More exactly, a local pg copy is described by a few pieces of informati=
on:
1) the local pg log
2) the local last_backfill
3) the local last_complete
4) the local missing set
The local pg store reflects all updates up to version last_complete on =
all
hobject_ts hoid such that hoid < last_backfill AND hoid is not in the m=
issing
set.  Comparing the pg logs is used to fill in the missing set for OSDs=
 which
were only down for a brief period thus avoiding a costly backfill in ma=
ny cases.

This is a bit of a rough brain dump and may be somewhat misleading/wron=
g.
I'll get it cleaned up and put it into
doc/dev/osd_internals/pg_recovery.rst next
week.

Also, rados objects currently have three pieces:
1) data - read, write, writefull, etc.
2) xattrs
3) omap
The omap is much like the xattrs except that it can generally store a m=
uch
larger number of keys and support efficient scans.  It's used at the mo=
ment
for a few things including rgw bucket indices.  The omap entries are co=
pied
over along with the rest of the object in recovery.  Behind the scenes,=
 all
omap entries for all objects stored on an OSD are stored prefixed in a =
single
big leveldb instance.

omap operations probably shouldn't be supported on objects in an
ErasureCodedPG :)
-Sam

On Sat, May 25, 2013 at 10:37 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 05/25/2013 04:48 PM, Leen Besselink wrote:
>> On Sat, May 25, 2013 at 04:27:16PM +0200, Loic Dachary wrote:
>>>
>>>
>>> On 05/25/2013 02:33 PM, Leen Besselink wrote:
>>> Hi Leen,
>>>
>>>> - a Cehp object can store keys/values, not just data
>>>
>>> I did not know that. Could you explain or give me the URL ?
>>>
>>
>> Well, I got that impression from some of the earlier talks and from =
this blog post:
>>
>> http://ceph.com/community/my-first-impressions-of-ceph-as-a-summer-i=
ntern/
>>
>> But I haven't read it in while.
>>
>> But at this time I only see something like:
>>
>> http://ceph.com/docs/master/rados/api/librados/?highlight=3Drados_ge=
txattr#rados_getxattr
>>
>> Which looks like it is storing it in filesystem attributes.
>>
>> So maybe an object can be a piece of data or a key/value store.
>
> Thanks for explaining: I did not know about the works of Eleanor Cawt=
hon. I knew about the objects xattributes but I thought you meant that =
the data inside of the object could be structured as key/value pairs. M=
y bad :-)
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
