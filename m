From: =?UTF-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Subject: Re: rgw: leak with incomplete multiparts (was: Request for review)
Date: Wed, 14 Jun 2017 18:06:39 +0800
Message-ID: <CAE5T3Nw9W-veddTuwAhFk9yyuNKvoWoTF9Sy+hYsb0g9HMQjeg@mail.gmail.com>
References: <CAP3mxSwbgTxzSL-d7-HxncV16JehvEuP+Pz-EmbQJvxT_G4HtQ@mail.gmail.com>
 <CAE5T3Nz6voZMcq-g89JGhzXyhGaAbu6EXXEADDhEhfiQuBWjXw@mail.gmail.com>
 <CAP3mxSzUyQf0gS-JR5W8pwvp74EMQhfX-WqGGsNFs3H4CVnotg@mail.gmail.com>
 <CAE5T3Nyxr=mZYws0B_rgkKE7EbMEWwnRQ5ygRHOdBfRp7Zgrsw@mail.gmail.com> <CAP3mxSxZF7ek40wRmrq9M90W29cinNXnXmA10pLf3OT7No4haQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36457 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdFNKGm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 06:06:42 -0400
Received: by mail-wr0-f176.google.com with SMTP id 36so60135647wry.3
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 03:06:41 -0700 (PDT)
In-Reply-To: <CAP3mxSxZF7ek40wRmrq9M90W29cinNXnXmA10pLf3OT7No4haQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2017-06-14 17:32 GMT+08:00 Abhishek Varshney <abhishek.varshney@flipkart.co=
m>:
> On Wed, Jun 14, 2017 at 7:44 AM, =E4=BA=8E=E7=9B=B8=E6=B4=8B <penglaiyxy@=
gmail.com> wrote:
>> Hi Abhishek,
>>
>> Our team has developed a radosgw-admin command to reclaim the leak
>> space caused by re-upload the same part.
>
> Is this an enhancement of the radosgw-admin orphans find command? The
> orphans find in itself has not proved to be very practical in our
> production environment with 500M objects and takes forever to run.
>
>>
>> I have reviewed the code yestoday and the procedure is scheduled as belo=
w:
>> 1. list the objects with ns=3Dmultipart from the bucket index with a
>> specified shard-id, since meta and multipart part index belongs to the
>> same shard-id.
>> 2. if meta index exists, we ignore the object.
>> 3. if meta index does not exists, we think the multipart index is
>> orphan parts and any objects associated are also leaked, then we put
>> these leaked objects to gc.
>
> In my opinion, this should be the right logical approach. The thing to
> take care of would be how you handle in-flight multipart uploads
> happening while this command is running, if you are doing bucket
> listing in chunks of 100 or 1000 entries at a time. Experienced rgw
> developers could comment better.

I will try to upload the code to Hammer(0.94) branch.

>
>>
>> It's a method to reclaim the leaked space.But in my opinion, I do not
>> think it is good enough.
>> And we have to trigger the reclaim through shell or humen.
>> We have to check which object is leaked, if bucket index shard-num is
>> too large, it is a heavy and long work.
>>
>> How do you think the method?
>> I hope to modify the code well and contribute  to the ceph community.
>>
>> I have opened a tracker for the problem.
>> http://tracker.ceph.com/issues/20284
>>
>> Best Regards,
>> Penglaixy
>> --
>> Software Engineer, ChinaNetCenter Co., ShenZhen, Guangdong Province, Chi=
na
>>
>> 2017-06-14 0:10 GMT+08:00 Abhishek Varshney <abhishek.varshney@flipkart.=
com>:
>>> Hi Penglaiyxy,
>>>
>>> I was able to reproduce the scenario described by you in current
>>> master branch. It turns out that, in case of re-uploading a part, rgw
>>> assigns a different prefix to it. This was introduced by the commit
>>> [1] as a fix for racy part uploads [2]. This leads to orphaned parts
>>> being uploaded, which have an entry in bucket index, but are not
>>> really part of any uploaded object. Such orphaned parts should have
>>> ideally been cleaned-up on multipart complete or abort operation. This
>>> looks like a slightly different issue, as the clean-up of such parts
>>> should not wait for a bucket deletion operation to happen.
>>>
>>> Can you open a separate tracker issue for this, if one not present alre=
ady.
>>>
>>> [1] https://github.com/ceph/ceph/pull/1781/commits/bd8e026f88b812cc70ca=
f6232c247844df5d99bf
>>> [2] http://tracker.ceph.com/issues/8269
>>>
>>> Thanks
>>> Abhishek
>>>
>>> On Tue, Jun 13, 2017 at 12:28 PM, =E4=BA=8E=E7=9B=B8=E6=B4=8B <penglaiy=
xy@gmail.com> wrote:
>>>> Hi Abhishek,
>>>>
>>>> Your PR is practical  for anyone who can not delete an non-empty bucke=
t.
>>>>
>>>> But I think in one scenario that you still can not delete bucket
>>>> because of the orphan object leaked by multipart upload.
>>>>
>>>> Upload a multipart object:
>>>>
>>>> 1. Upload part 1 with prefix   2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5
>>>>
>>>> 2. The connection between rgw client and server is cutoff,  I don't
>>>> know if  I have upload part one completely ,so I re-upload part 1 then
>>>> the part 1 is attached with a new prefix like
>>>> eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH(which is tackled by rgw server )
>>>>
>>>> 3. The connection between rgw client and server is cutoff again, then
>>>> I re-upload part 1 with new  prefix d9H1FWnoOwmr3IAejtYQJ2hyIjsUA7U
>>>>
>>>> 4. Upload part 2 and left parts
>>>>
>>>> 5. At the end, complete the upload.
>>>>
>>>> The object with names below is leaked and I can not see them through
>>>> s3 client.  (My upload size is 15MB and stripe size is 4M)
>>>>
>>>> center-master.4439.1__multipart_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEU=
v-5.1
>>>> center-master.4439.1__shadow_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5=
.1_1
>>>> center-master.4439.1__shadow_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5=
.1_2
>>>> center-master.4439.1__shadow_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5=
.1_3
>>>>
>>>> center-master.4439.1__multipart_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HP=
H.1
>>>> center-master.4439.1__shadow_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH.1=
_1
>>>> center-master.4439.1__shadow_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH.1=
_2
>>>> center-master.4439.1__shadow_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH.1=
_3
>>>>
>>>> The above upload process is really occurring in our production
>>>> application and we find a lot space leaked.
>>>>
>>>> How can I reclaim the space leaked?
>>>>
>>>> Any Idea is appreciated.
>>>>
>>>>
>>>> ________________________________
>>>> penglaiyxy
>>>>
>>>> From: Abhishek Varshney
>>>> Date: 2017-06-13 00:17
>>>> To: Ceph Development
>>>> Subject: rgw: leak with incomplete multiparts (was: Request for review=
)
>>>> Reviving an old thread by a colleague on rgw leaking rados objects,
>>>> the PR submitted earlier [1] had failed teuthology rgw run, due to
>>>> radosgw-admin failing to remove a user with --purge-data flag. I tried
>>>> to root cause the issue, and it turned out that incomplete multiparts
>>>> need to be aborted when doing bucket rm with --purge-data. Here is the
>>>> new PR (https://github.com/ceph/ceph/pull/15630) which handles
>>>> incomplete multiparts with behaviour as given below:
>>>>
>>>> * radosgw-admin user/bucket rm with incomplete multiparts would return
>>>> bucket not empty error.
>>>> * radosgw-admin user/bucket rm --purge-data with incomplete multiparts
>>>> would abort the pending multiparts and then delete the bucket.
>>>> * S3 delete bucket API with incomplete multiparts would return bucket
>>>> not empty error. The expectation here is on the user to either
>>>> complete or cancel all pending multipart uploads before deleting the
>>>> bucket.
>>>>
>>>> Requesting review on this PR.
>>>>
>>>> PS : The check for an empty bucket index here [2] in the previous PR
>>>> [1] has been removed, as we found instances of inconsistent bucket
>>>> index with stale entries, without corresponding objects present in
>>>> data pool. This would have prevented the deletion of an empty bucket
>>>> with such inconsistent indexes. I am not sure on how to reproduce such
>>>> a scenario though.
>>>>
>>>> [1] https://github.com/ceph/ceph/pull/10920
>>>> [2] https://github.com/ceph/ceph/pull/10920/files#diff-c30965955342b98=
393b73be699f4e355R7349
>>>>
>>>> Thanks
>>>> Abhishek
>>>>
>>>> On Mon, Sep 12, 2016 at 4:23 AM, Praveen Kumar G T (Cloud Platform)
>>>> <praveen.gt@flipkart.com> wrote:
>>>>> Definitions
>>>>>
>>>>> Orphaned Objects: Orphaned objects are created when a Multipart uploa=
d has uploaded some or all of the parts but without executing multipart can=
cel or multipart complete. An incomplete Multipart upload is neither create=
d nor destroyed, it is in orphan state
>>>>> Leaked Objects : Objects that are not deleted on the ceph cluster but=
 assumed to be deleted by s3 client. These objects cannot be accessed by s3=
 clients but still occupy space in the ceph cluster
>>>>>
>>>>> Problem
>>>>>
>>>>> A s3 bucket cannot be deleted when there are objects in it. The bucke=
t deletion command will fail with error BucketNotEmpty. The objects in the =
buckets can be listed using any of the s3 clients. In case if we have orpha=
ned objects present in the bucket, they will not be listed via the normal l=
isting operations of the s3 clients. If the bucket is deleted when there ar=
e orphaned objects in the bucket, they will end up being leaked. This ends =
of using space in the ceph cluster even though the objects are not accessed=
 by any of the s3 clients. This space is not accounted under the radosgw us=
er account as well
>>>>>
>>>>> Tracker link
>>>>>
>>>>> http://tracker.ceph.com/issues/17164
>>>>>
>>>>> Fix
>>>>>
>>>>> The fix will avoid deletion of buckets even if there are Orphaned obj=
ects in the bucket. So now bucket deletion command will return BucketNotEmp=
ty  when there are orphaned objects as well.
>>>>>
>>>>> Pull request
>>>>>
>>>>> https://github.com/ceph/ceph/pull/10920
>>>>>
>>>>> Can somebody Please review the fix. We have already verified the fix =
locally.
>>>>>
>>>>> Regards,
>>>>> Praveen.
>>>>>
>>>>>
>>>>> --
>>>>
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>>>
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
