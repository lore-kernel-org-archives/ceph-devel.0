From: =?UTF-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Subject: Re: rgw: leak with incomplete multiparts (was: Request for review)
Date: Tue, 13 Jun 2017 14:58:28 +0800
Message-ID: <CAE5T3Nz6voZMcq-g89JGhzXyhGaAbu6EXXEADDhEhfiQuBWjXw@mail.gmail.com>
References: <CAP3mxSwbgTxzSL-d7-HxncV16JehvEuP+Pz-EmbQJvxT_G4HtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36701 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdFMG6a (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 02:58:30 -0400
Received: by mail-wr0-f169.google.com with SMTP id 36so5706506wry.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 23:58:30 -0700 (PDT)
In-Reply-To: <CAP3mxSwbgTxzSL-d7-HxncV16JehvEuP+Pz-EmbQJvxT_G4HtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Abhishek,

Your PR is practical  for anyone who can not delete an non-empty bucket.

But I think in one scenario that you still can not delete bucket
because of the orphan object leaked by multipart upload.

Upload a multipart object:

1. Upload part 1 with prefix   2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5

2. The connection between rgw client and server is cutoff,  I don't
know if  I have upload part one completely ,so I re-upload part 1 then
the part 1 is attached with a new prefix like
eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH(which is tackled by rgw server )

3. The connection between rgw client and server is cutoff again, then
I re-upload part 1 with new  prefix d9H1FWnoOwmr3IAejtYQJ2hyIjsUA7U

4. Upload part 2 and left parts

5. At the end, complete the upload.

The object with names below is leaked and I can not see them through
s3 client.  (My upload size is 15MB and stripe size is 4M)

center-master.4439.1__multipart_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5.1
center-master.4439.1__shadow_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5.1_1
center-master.4439.1__shadow_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5.1_2
center-master.4439.1__shadow_bigfile.2~-DUZmxVbiv9dBycBdci2iMhiKEEUv-5.1_3

center-master.4439.1__multipart_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH.1
center-master.4439.1__shadow_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH.1_1
center-master.4439.1__shadow_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH.1_2
center-master.4439.1__shadow_bigfile.eOntuNHW8UdvnpbLl9UAdYGuWrL9HPH.1_3

The above upload process is really occurring in our production
application and we find a lot space leaked.

How can I reclaim the space leaked?

Any Idea is appreciated.


________________________________
penglaiyxy

From: Abhishek Varshney
Date: 2017-06-13 00:17
To: Ceph Development
Subject: rgw: leak with incomplete multiparts (was: Request for review)
Reviving an old thread by a colleague on rgw leaking rados objects,
the PR submitted earlier [1] had failed teuthology rgw run, due to
radosgw-admin failing to remove a user with --purge-data flag. I tried
to root cause the issue, and it turned out that incomplete multiparts
need to be aborted when doing bucket rm with --purge-data. Here is the
new PR (https://github.com/ceph/ceph/pull/15630) which handles
incomplete multiparts with behaviour as given below:

* radosgw-admin user/bucket rm with incomplete multiparts would return
bucket not empty error.
* radosgw-admin user/bucket rm --purge-data with incomplete multiparts
would abort the pending multiparts and then delete the bucket.
* S3 delete bucket API with incomplete multiparts would return bucket
not empty error. The expectation here is on the user to either
complete or cancel all pending multipart uploads before deleting the
bucket.

Requesting review on this PR.

PS : The check for an empty bucket index here [2] in the previous PR
[1] has been removed, as we found instances of inconsistent bucket
index with stale entries, without corresponding objects present in
data pool. This would have prevented the deletion of an empty bucket
with such inconsistent indexes. I am not sure on how to reproduce such
a scenario though.

[1] https://github.com/ceph/ceph/pull/10920
[2] https://github.com/ceph/ceph/pull/10920/files#diff-c30965955342b98393b7=
3be699f4e355R7349

Thanks
Abhishek

On Mon, Sep 12, 2016 at 4:23 AM, Praveen Kumar G T (Cloud Platform)
<praveen.gt@flipkart.com> wrote:
> Definitions
>
> Orphaned Objects: Orphaned objects are created when a Multipart upload ha=
s uploaded some or all of the parts but without executing multipart cancel =
or multipart complete. An incomplete Multipart upload is neither created no=
r destroyed, it is in orphan state
> Leaked Objects : Objects that are not deleted on the ceph cluster but ass=
umed to be deleted by s3 client. These objects cannot be accessed by s3 cli=
ents but still occupy space in the ceph cluster
>
> Problem
>
> A s3 bucket cannot be deleted when there are objects in it. The bucket de=
letion command will fail with error BucketNotEmpty. The objects in the buck=
ets can be listed using any of the s3 clients. In case if we have orphaned =
objects present in the bucket, they will not be listed via the normal listi=
ng operations of the s3 clients. If the bucket is deleted when there are or=
phaned objects in the bucket, they will end up being leaked. This ends of u=
sing space in the ceph cluster even though the objects are not accessed by =
any of the s3 clients. This space is not accounted under the radosgw user a=
ccount as well
>
> Tracker link
>
> http://tracker.ceph.com/issues/17164
>
> Fix
>
> The fix will avoid deletion of buckets even if there are Orphaned objects=
 in the bucket. So now bucket deletion command will return BucketNotEmpty  =
when there are orphaned objects as well.
>
> Pull request
>
> https://github.com/ceph/ceph/pull/10920
>
> Can somebody Please review the fix. We have already verified the fix loca=
lly.
>
> Regards,
> Praveen.
>
>
> --

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
