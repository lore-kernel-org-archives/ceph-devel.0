From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw/s3_bucket_quota.pl failure on the jewel-backports integration
 branch
Date: Thu, 25 Aug 2016 19:23:58 +0200
Message-ID: <57BF29AE.2050203@dachary.org>
References: <57BEF687.80805@dachary.org>
 <79549893.74970999.1472136184073.JavaMail.zimbra@redhat.com>
 <CABo9giT5Y4xt3Xs4h2T=jogrLZn+GC=XeogRnbSL3h=qfGC9jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:49529 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbcHYR2T (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 13:28:19 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 5CBCD4B672E
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 19:25:04 +0200 (CEST)
In-Reply-To: <CABo9giT5Y4xt3Xs4h2T=jogrLZn+GC=XeogRnbSL3h=qfGC9jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 25/08/2016 17:32, Orit Wasserman wrote:
> could be the default quota backport:
> https://github.com/ceph/ceph/pull/10832?

Oh, right ! I'll re-run without this pull request.

> 
> On Thu, Aug 25, 2016 at 4:43 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
>> Looks like a failure in s3_bucket_quota.  I'm not sure if this could be related to the issues w/bucket lifecycle PR?
>>
>> Matt
>>
>> ----- Original Message -----
>>> From: "Loic Dachary" <loic@dachary.org>
>>> To: "Casey Bodley" <cbodley@redhat.com>
>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Sent: Thursday, August 25, 2016 9:45:43 AM
>>> Subject: rgw/s3_bucket_quota.pl failure on the jewel-backports integration branch
>>>
>>> Hi Casey,
>>>
>>> http://pulpito.ceph.com/loic-2016-08-25_06:41:52-rgw-jewel-backports-distro-basic-smithi/
>>>
>>> which runs against the jewel-backports branch has a number of rgw pull
>>> requests
>>>
>>> http://tracker.ceph.com/issues/16344#note-36
>>>
>>> and shows a new failures which look like this:
>>>
>>> http://qa-proxy.ceph.com/teuthology/loic-2016-08-25_06:41:52-rgw-jewel-backports-distro-basic-smithi/384799/teuthology.log
>>>
>>> 2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:user
>>> qa_user deleted
>>> 2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:bucket
>>> delete succeeded
>>> 2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:Bucket
>>> Created: buck_2016_07_25_11_16_51
>>> 2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:quota
>>> set for the bucket: buck_2016_07_25_11_16_51
>>> 2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:quota
>>> enabled for the bucket: buck_2016_07_25_11_16_51
>>> 2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:adding
>>> file to bucket: 10Mb.
>>> 2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:upload
>>> file successful
>>> 2016-08-25T11:16:52.378
>>> INFO:tasks.workunit.client.0.smithi042.stdout:readding file to bucket:
>>> 10MBfile1
>>> 2016-08-25T11:16:52.378
>>> INFO:tasks.workunit.client.0.smithi042.stdout:readding file success
>>> 2016-08-25T11:16:52.378
>>> INFO:tasks.workunit.client.0.smithi042.stdout:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:Test
>>> case:  FAILED - set max objects and test beyond max objects failed
>>> 2016-08-25T11:16:52.378
>>> INFO:tasks.workunit.client.0.smithi042.stdout:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Our focus in this run is to make sure https://github.com/ceph/ceph/pull/10845
>>> passes. I don't know enough about rgw tests to figure out if it is related
>>> to the commits in this pull request or not.
>>>
>>> What do you think ?
>>>
>>> P.S. The error also seems to be incorrectly handled later on but that's
>>> another issue ;-)
>>>
>>> 2016-08-25T11:16:52.489 INFO:tasks.workunit.client.0.smithi042.stderr:Can't
>>> call method "err" on an undefined value at
>>> /home/ubuntu/cephtest/workunit.client.0/rgw/s3_bucket_quota.pl line 199.
>>>
>>> --
>>> Loïc Dachary, Artisan Logiciel Libre
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Matt Benjamin
>> Red Hat, Inc.
>> 315 West Huron Street, Suite 140A
>> Ann Arbor, Michigan 48103
>>
>> http://www.redhat.com/en/technologies/storage
>>
>> tel.  734-707-0660
>> fax.  734-769-8938
>> cel.  734-216-5309
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
