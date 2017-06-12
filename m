From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: rgw: leak with incomplete multiparts (was: Request for review)
Date: Mon, 12 Jun 2017 21:17:30 +0530
Message-ID: <CAP3mxSwbgTxzSL-d7-HxncV16JehvEuP+Pz-EmbQJvxT_G4HtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f173.google.com ([209.85.213.173]:33648 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754641AbdFLPrc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 11:47:32 -0400
Received: by mail-yb0-f173.google.com with SMTP id 202so27763132ybd.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 08:47:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

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
