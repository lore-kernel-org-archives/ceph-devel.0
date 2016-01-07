From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: scrub test assert
Date: Thu, 7 Jan 2016 12:44:34 -0800
Message-ID: <CAJ4mKGb-qtb99mFih+zZ-GD-HivgOdcAQpccnrGsD1i5+n77vA@mail.gmail.com>
References: <D2B36D43.A56C%evgeniy.firsov@sandisk.com>
	<CAJ4mKGahSM5kb-5vJttHuoY7pBQFkv9+EQr=V8Dg+sX+kOM6pg@mail.gmail.com>
	<CO1PR02MB2089249E91F4EEAC402BE18F4F50@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33089 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbcAGUog convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 15:44:36 -0500
Received: by mail-wm0-f48.google.com with SMTP id f206so112839334wmf.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jan 2016 12:44:35 -0800 (PST)
In-Reply-To: <CO1PR02MB2089249E91F4EEAC402BE18F4F50@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 7, 2016 at 12:25 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Greg,
> I think one point is missing in the description..
>
> After deleting pg entries, 1 PG becomes inconsistent (as expected).
>
> Ran pg repair and the cluster became consistent again , all pgs are active + clean
>
> But, after restart we got the assert.
>
> So, yes, it seems there are some cache effect and not everything persisted during pg repair (?)..
>
> I guess, the question is, if after PG repair is successful, why it is giving the assert during restart ? There shouldn't be any missing files , am I missing anything ?

At a guess then, some portion of the files aren't in the fd cache and
it's detecting and fixing those. But on restart it's detecting stuff
which is in the pglog but not on the disk. This is stuff you can work
out if you check the scrub repair logs and see what it does in
comparison to known PG contents, and then what it's actually running
into before asserting on restart.

Or possibly there's an unnecessary assert in the startup path but not
the recovery path; I think David fixed one of those recently. *shrug*
-Greg

>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Gregory Farnum
> Sent: Thursday, January 07, 2016 12:08 PM
> To: Evgeniy Firsov
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: scrub test assert
>
> On Thu, Jan 7, 2016 at 1:17 AM, Evgeniy Firsov <Evgeniy.Firsov@sandisk.com> wrote:
>> Hi, Devs,
>>
>> We hit an assert while doing scrub test.
>> Can you, please, verify if the test case is valid?
>>
>> The test:
>> 1. Start Jewel cluster. 2 nodes, 8 osds each.
>> 2. Start fio, pure write workload.
>> 3. Delete data of random pg: rm -rf
>> /var/lib/ceph/osd/ceph-7/2.185_head/*
>> 4. Stop workload
>> 5. Do a scrub on that pg. Cluster active and clean after that.
>> 6. Restart the node with that pg.
>> 7. The OSD with that pg fails to recover and asserts with:
>>      osd/PGLog.cc: 382: FAILED assert(objiter->second->version >
>> last_divergent_update)
>
> The OSD is passing scrub tests because of the file descriptor cache (so it still has its own fds open for the deleted files that it references), but then on restart everything gets wiped away and it discovers its data store is inconsistent. I believe your team has run into this before when designing data loss tests. :) -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
