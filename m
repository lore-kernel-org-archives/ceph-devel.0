From: Gregory Farnum <greg@inktank.com>
Subject: Re: Files lost after mds rebuild
Date: Tue, 20 Nov 2012 09:29:44 -0800
Message-ID: <CAPYLRzhF2hpkqVLk9RQZwffzJz4DhsmwA30PBxOxNJi+HSkf3w@mail.gmail.com>
References: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com>
	<CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
	<CAJiejCQt2xVBMzY9q6viYLkXYNrDcmHZP=rcWj+GK+qsYu=XuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47060 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab2KTR3p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 12:29:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so8952927iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 09:29:44 -0800 (PST)
In-Reply-To: <CAJiejCQt2xVBMzY9q6viYLkXYNrDcmHZP=rcWj+GK+qsYu=XuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 20, 2012 at 1:25 AM, Drunkard Zhang <gongfan193@gmail.com> wrote:
> 2012/11/20 Gregory Farnum <greg@inktank.com>:
>> On Mon, Nov 19, 2012 at 7:55 AM, Drunkard Zhang <gongfan193@gmail.com> wrote:
>>> I created a ceph cluster for test, here's mistake I made:
>>> Add a second mds: mds.ab, executed 'ceph mds set_max_mds 2', then
>>> removed the mds just added;
>>> Then 'ceph mds set_max_mds 1', the first mds.aa crashed, and became laggy.
>>> As I can't repair mds.aa, so did 'ceph mds newfs metadata data
>>> --yes-i-really-mean-it';
>>
>> So this command is a mkfs sort of thing. It's deleted all the
>> "allocation tables" and filesystem metadata in favor of new, empty
>> ones. You should not run "--yes-i-really-mean-it" commands if you
>> don't know exactly what the command is doing and why you're using it.
>>
>>> mds.aa was back, but 1TB data was in cluster lost, but disk space
>>> still used, by 'ceps -s'.
>>>
>>> Is there any chance I can get my data back? If can't, how can I
>>> retrieve back the disk space.
>>
>> There's not currently a great way to get that data back. With
>> sufficient energy it could be re-constructed by looking through all
>> the RADOS objects and putting something together.
>> To retrieve the disk space, you'll want to delete the "data" and
>> "metadata" RADOS pools. This will of course *eliminate* the data you
>> have in your new filesystem, so grab that out first if there's
>> anything there you care about. Then create the pools and run the newfs
>> command again.
>> Also, you've got the syntax wrong on that newfs command. You should be
>> using pool IDs:
>> "ceph mds newfs 1 0 --yes-i-really-mean-it"
>> (Though these IDs may change after re-creating the pools.)
>> -Greg
>
> I followed your instructions, but didn't success, 'ceph mds newfs 1 0
> --yes-i-really-mean-it' changed nothing, do I have to delete all pools
> I created first? why is this way? Confused.

If you look below at your pools, you no longer have pool IDs 0 and 1.
They were the old "data" and "metadata" pools that you just deleted.
You will need to create new pools for the filesystem and use their
IDs.

> While testing, I found that the default pool is parent of all pools I
> created later, right? So, delete the default 'data' pool also deleted
> data belongs to other pools, is this true?

No, absolutely not. There is no relationship between different RADOS
pools. If you've been using the cephfs tool to place some filesystem
data in different pools then your configuration is a little more
complicated (have you done that?), but deleting one pool is never
going to remove data from the others.
-Greg

> log3 ~ # ceph osd pool delete data
> pool 'data' deleted
> log3 ~ # ceph osd pool delete metadata
> pool 'metadata' deleted
>
> log3 ~ # ceph mds newfs 1 0 --yes-i-really-mean-it
> new fs with metadata pool 1 and data pool 0
> log3 ~ # ceph osd dump | grep ^pool
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num
> 320 pgp_num 320 last_change 1 owner 0
> pool 3 'netflow' rep size 2 crush_ruleset 0 object_hash rjenkins
> pg_num 8 pgp_num 8 last_change 1556 owner 0
> pool 4 'audit' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
> 8 pgp_num 8 last_change 1558 owner 0
> pool 5 'dns-trend' rep size 2 crush_ruleset 0 object_hash rjenkins
> pg_num 8 pgp_num 8 last_change 1561 owner 0
> log3 ~ # ceph -s
>    health HEALTH_OK
>    monmap e1: 1 mons at {log3=10.205.119.2:6789/0}, election epoch 0,
> quorum 0 log3
>    osdmap e1581: 28 osds: 20 up, 20 in
>     pgmap v57715: 344 pgs: 344 active+clean; 0 bytes data, 22050 MB
> used, 53628 GB / 55890 GB avail
>    mdsmap e825: 0/0/1 up
