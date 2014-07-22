From: Shayan Saeed <shayansaeed93@gmail.com>
Subject: Re: Disabling CRUSH for erasure code and doing custom placement
Date: Tue, 22 Jul 2014 17:48:23 -0400
Message-ID: <CALUBZ_-HxjMrni0Gtv_gs=nT1RGxTEYhZGmw1s=z5hkPT4kV3w@mail.gmail.com>
References: <CALUBZ__98nzUjucW9NmFKEHzPFvu0yY0X5yHEtFH7g9QkhqSAQ@mail.gmail.com>
	<CAPYLRzgeb2DB_tJfRFvK1gk5XEYYd7mgHH5E5URqYsn_2bH4mQ@mail.gmail.com>
	<CALUBZ_-gBR2KHMQcGe65+GDHE3xC+Fq9_J+DZLDqf+7LQHrq6g@mail.gmail.com>
	<CAPYLRzhoiP7t81VG5FEgo53xP9GVMOu6e8zQdwU+HxF2gB7HRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:62087 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbaGVVsY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jul 2014 17:48:24 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so341391pad.21
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jul 2014 14:48:23 -0700 (PDT)
In-Reply-To: <CAPYLRzhoiP7t81VG5FEgo53xP9GVMOu6e8zQdwU+HxF2gB7HRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Another question along the same lines. For erasure code, same as
replicated files, the request goes through the primary member. Isn't
it possible to send the request to any of the members and get the
file. While this might have kept things neater on the development side
and might have made some sense for replicated system, it makes the
availability and load balancing worse for erasure coded files. I see a
lot of requests coming in for a specific object which makes the
primary osd hosting it go down sometimes and then all the requests
have to wait another osd comes up and repair is done.  For load
balancing purposes, is there a way to make the requests go to someone
else without hinderance and get the object without waiting for repair.

Thanks,
Shayan
Regards,
Shayan Saeed


On Tue, Jul 15, 2014 at 1:18 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> One of Ceph's design tentpoles is *avoiding* a central metadata looku=
p
> table. The Ceph MDS maintains a filesystem hierarchy but doesn't
> really handle the sort of thing you're talking about, either. If you
> want some kind of lookup, you'll need to build it yourself =E2=80=94 =
although
> you could make use of some RADOS features to do it, if you really
> wanted to. (For instance, depending on scale you could keep an index
> of objects in an omap somewhere.)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
> On Tue, Jul 15, 2014 at 10:11 AM, Shayan Saeed <shayansaeed93@gmail.c=
om> wrote:
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
>> On Tue, Jun 24, 2014 at 11:37 AM, Gregory Farnum <greg@inktank.com> =
wrote:
>>> On Tue, Jun 24, 2014 at 8:29 AM, Shayan Saeed <shayansaeed93@gmail.=
com> wrote:
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
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
