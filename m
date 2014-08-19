From: Yehuda Sadeh <yehuda@redhat.com>
Subject: rgw object expiration
Date: Tue, 19 Aug 2014 15:51:25 -0700
Message-ID: <CABBk=J-F7H75rA2Gt3HYb5a6+Y9ns0vuSjmAV4vhTFoVpJCS9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37190 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbaHSWv1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 18:51:27 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so10255304pde.18
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 15:51:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, Neil Levine <nlevine@redhat.com>

We've discussed this feature briefly in the past, and it might be time
to look at the design a bit. The S3 and Swift features differ quite a
bit, so let's have a look at both:
S3:

Object expiration is part of a larger bucket lifecycle management
feature. This allows setting rules on a bucket that specify what to do
with specific objects (that have a specified prefix), after an amount
of time. Objects can either be removed, or transferred into a
secondary storage. The objects can either be current and expire, or
(in the case of versioned buckets) can be non-current. Bucket
lifecycle rules can be added, and removed, and they affect *all*
objects in the bucket, including objects created before the rules were
created. An interesting property is that users are not billed for
expired objects, even if the (async) removal process has not removed
them yet.

Swift:

The Swift objects expiration is set at the object level. It is
possible to set a specific header that will set expiration time for
the object. An async process will then garbage collect the object. An
expired object cannot be read anymore (although it is possible that it
can be listed, and removed by the user).

Looking at both features, it is possible to define a superset. That
is, provide both the S3 bucket-level lifecycle management, and the
swift object-level expiration scheme.

rgw implementation:

Object level expiration, a'la Swift:

 - A new maintenance thread, similar to the garbage collector will be
created. The thread will be used to apply deferred operations.
 - A new maintenance log will be created. The log will be sharded, and
entries there will be indexed by both timestamp, and

maintenance thread will work as follows: try to lock a shard, read
shard, operate, unlock

 - an object could be assigned with an expiration timestamp

When an object is set to expire, we'll update the maintenance log with
its id, and the timestamp. Note that we'll also keep note of the
object instance's tag, so that if the object is overwritten, we won't
remove the new instance. When updating the maintenance log, we'll
remove any existing entry for the same object.

 - when reading an object, we'll check to see if it's expired so that
we return a proper response
 - maintenance log will read entries, up until current timestamp, and
issue object removal for each of these entries

The S3 object expiration is much more complicated. It will still use
the same maintenance thread. Now, we'll need to decide whether we want
to provide a strong accounting functionality similar to S3 (objects
are not accounted if need to expire, even if were not garbage
collected yet), as it will affect the implementation.

Relaxed accounting:
 - Bucket rules list will be versioned. Each rule change will bump up
this version. Each rule will have the version in which it was created.
 - When adding a rule on a bucket, create a maintenance job that will
add relevant objects in this bucket to the list, and the rule (and
version) it applies to
 - When removing objects that apply to a specific rule, the
maintenance thread will verify that this rule+version is still active
 - Adding an object within a bucket, will add an appropriate entry in
the maintenance log, if applicable

Strict accounting:
 - Do we really want this?
 - bucket index will need to add accounting adjustments (by timestmap)
 - an object that is set to expire, will be added to the adjustments
record (by the timestamp). When the object is removed, it'll be
deducted from that record
 - when getting bucket's stats, we'll also get the adjustment
accounting (up until the relevant timestamp)
 - open question: how to update the quota


Let me know if this makes any sense.

Yehuda
