From: Kaifeng Yao <kaifeng@yahoo-inc.com>
Subject: Re: Disabling CRUSH for erasure code and doing custom placement
Date: Fri, 18 Jul 2014 09:12:40 +0000
Message-ID: <CFEEFD16.5F5CB%kaifeng@yahoo-inc.com>
References: <CALUBZ__98nzUjucW9NmFKEHzPFvu0yY0X5yHEtFH7g9QkhqSAQ@mail.gmail.com>
 <CAPYLRzgeb2DB_tJfRFvK1gk5XEYYd7mgHH5E5URqYsn_2bH4mQ@mail.gmail.com>
 <CALUBZ_-gBR2KHMQcGe65+GDHE3xC+Fq9_J+DZLDqf+7LQHrq6g@mail.gmail.com>
 <CAPYLRzhoiP7t81VG5FEgo53xP9GVMOu6e8zQdwU+HxF2gB7HRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mrout1-b.corp.bf1.yahoo.com ([98.139.253.104]:44989 "EHLO
	mrout1-b.corp.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932122AbaGRJYb convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Jul 2014 05:24:31 -0400
In-Reply-To: <CAPYLRzhoiP7t81VG5FEgo53xP9GVMOu6e8zQdwU+HxF2gB7HRQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <7ED04BE27C8AE34DA2CEB16920F6F0AA@yforest.corp.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Shayan Saeed <shayansaeed93@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I was thinking about 'PG preferred' to allow binding a PG's placement t=
o
arbitrary OSDs. My angle is to make the PG more evenly distributed acro=
ss
OSDs, thus to potentially save ~20% cost. I am searching the 'pg
preferred' implementation in CEPH to get more context.

=46or the PG -> OSD distribution problem, we have tried the after-fact
reweight-by-utilization, which results heavy data movements, and finall=
y
the PG/OSD variation dropped from +- 2x% to +- 1x%. We also tried
pre-reweight right after the pool creation but before any data is store=
d.
Similar to reweight-by-utilization but here the weight is calculated by
PGs per OSD. In this way it can run several rounds of iterations
relatively quicker and the variation can drop to +- 10%. Neither is goo=
d
enough. So I wonder if we can work around CRUSH placement for this case=
=2E

Here are the scenarios I am thinking about:
Admin can create a pool with a given crush rule, then adjust the PG's
'preferred OSD' to its one or several replicas (or EC strips). Basicall=
y
if OSD #n is overloaded and OSD #m is less occupied, then we enumerate =
the
PGs that have some replica on OSD #n, and move that replica to #m. This
process can be automated. After some iterations it should be very close=
 to
uniform distribution (+- 5% variation or less?).

Some more stuff to consider:
1) The setting takes effect only if it complies to the CRUSH rule, and =
the
OSD is in.=20
2) For scaling out/in cases, the preferred flags have to be recalculate=
d
to make the distribution even again. It is not so good as CRUSH's
consistent hashing. But this can be automated too.

Comments?=20

Thanks,
Kaifeng

On 7/16/14, 1:18 AM, "Gregory Farnum" <greg@inktank.com> wrote:

>One of Ceph's design tentpoles is *avoiding* a central metadata lookup
>table. The Ceph MDS maintains a filesystem hierarchy but doesn't
>really handle the sort of thing you're talking about, either. If you
>want some kind of lookup, you'll need to build it yourself =8B althoug=
h
>you could make use of some RADOS features to do it, if you really
>wanted to. (For instance, depending on scale you could keep an index
>of objects in an omap somewhere.)
>-Greg
>Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
>On Tue, Jul 15, 2014 at 10:11 AM, Shayan Saeed <shayansaeed93@gmail.co=
m>
>wrote:
>> Well I did end up putting the data in different pools for custom
>> placement. However, I run into trouble during retrieval. The messy w=
ay
>> is to query every pool to check where the data is stored. This
>> requires many round trips to machines in the far off racks. Is it
>> possible this information is contained within a centralized sort of
>> metadata server? I understand that for simple object store MDS is no=
t
>> used but is there a way to utilize it for faster querying?
>>
>> Regards,
>> Shayan Saeed
>>
>>
>> On Tue, Jun 24, 2014 at 11:37 AM, Gregory Farnum <greg@inktank.com>
>>wrote:
>>> On Tue, Jun 24, 2014 at 8:29 AM, Shayan Saeed
>>><shayansaeed93@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> CRUSH placement algorithm works really nice with replication. Howe=
ver,
>>>> with erasure code, my cluster has some issues which require making
>>>> changes that I cannot specify with CRUSH maps.
>>>> Sometimes, depending on the type of data, I would like to place th=
em
>>>> on different OSDs but in the same pool.
>>>
>>> Why do you want to keep the data in the same pool?
>>>
>>>>
>>>> I realize that to disable the CRUSH placement algorithm and replac=
ing
>>>> it with my own custom algorithm, such as random placement algo or =
any
>>>> other, I have to make changes in the source code. I want to ask if
>>>> there is an easy way to do this without going into every code file=
 and
>>>> looking where the mapping from objects to PG is done and changing
>>>> that. Is there some configuration option which disables crush and
>>>> points to my own placement algo file for doing custom placement.
>>>
>>> What you're asking for really doesn't sound feasible, but the thing
>>> that comes closest would probably be resurrecting the "pg preferred=
"
>>> mechanisms in CRUSH and the Ceph codebase. You'll have to go back
>>> through the git history to find it, but once upon a time we support=
ed
>>> a mechanism that let you specify a specific OSD you wanted a
>>> particular object to live on, and then it would place the remaining
>>> replicas using CRUSH.
>>> -Greg
>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>
>>>>
>>>> Let me know about the most neat way to go about it. Appreciate any
>>>> help I can get.
>>>>
>>>> Regards,
>>>> Shayan Saeed
>>>> Research Assistant, Systems Research Lab
>>>> University of Illinois Urbana-Champaign
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>>in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
