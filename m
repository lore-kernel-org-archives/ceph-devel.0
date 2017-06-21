From: Jiaying Ren <mikulely@gmail.com>
Subject: RGW: Implement S3 storage class feature
Date: Wed, 21 Jun 2017 19:39:24 +0800
Message-ID: <CAF8OO3Mo3xFbxioTedym+rByF1Eu3kNhHayn9mx1V6N5h-LWbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:34487 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdFULj0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 07:39:26 -0400
Received: by mail-ot0-f174.google.com with SMTP id r67so109950774ota.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 04:39:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi~ Yehuda and Ceph developers:

We're prototyping S3 storage class feature [1]. It seems that we've
tried on this before[2]. I'd like to share the following as start for
anyone who interested about this feature; your comments are
appreciated.

* Storage Class Category

S3 current supported storage class types can be classified by whether
we can set storage class type during uploading or not:

+ Direct Storage Class (like Reduced Redundancy Storage, STANDARD,
  STANDARD_IA, we can specify during upload object)
+ Indirect Storage Class (like Glacier, we can only use this storage
  class type by lifecycle management)

we're going to talk about Direct Storage Class.

* Core Concept

Current rgw are using following concept to determine the bucket/object
placement:

+ placement rule - placement rule is key-value pair, the placement id
  as key, the placement info as value.
+ placement info - collect a bunch of rados pools.
+ placement target - placement target contains a placement id and a
  list of placement tags,that only used to determine whether the user
  can use the placement rule or not.

placement target can be manipulated only in the zonegroup, and
placement rule only in the zone.

* Feature Mapping

In order to make the S3 StorageClass/Swift Storage Policy orthogonal,
we can leverage current placement rule as underlying building block,
and mapping the dialect feature as:

+ Swift storage policy = per bucket placement rule
+ S3 storage class = per object placement rule

Each storage class is presented by a placement rule,that use different
data pools(like STANDARD use 3-replica data_pool, Reduced Redundancy
Storage use 2-replica data_pool), but we need to enforce that the
storage classes defined in the same zone should use the same
index_pool for bucket index and the same pool for object metadata.

* Priority of placement rule

Following structs:

+ zonegroup
+ user
+ bucket

need to contain a default placement rule, we need to determine the
placement rule used by bucket/object.

** bucket placement rule

The order of placement rule priority to determine the bucket default
placement rule:

request rule > user default rule > zonegroup default rule

The bucket default placement rule should not be empty after bucket
creation.

** object placement rule

The order of placement rule priority to determine the object default
placement rule:

request rule > bucket default rule

* Todo List

+ the head of rgw-object should only contains the metadata of
  rgw-object,the first chunk of rgw-object data should be stored in
  the same pool as the tail of rgw-object

* References

+ [1] (http://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html)
+ [2] http://tracker.ceph.com/issues/12907


--
mikulely
