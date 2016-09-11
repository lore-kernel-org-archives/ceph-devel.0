From: "Praveen Kumar G T (Cloud Platform)" <praveen.gt@flipkart.com>
Subject: Request for review
Date: Mon, 12 Sep 2016 04:23:58 +0530
Message-ID: <34EF87B5-6270-4F75-B763-D265A901660A@flipkart.com>
References: <7E451D9A-1426-47EA-8DA9-6BF9927CCCBB@flipkart.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33393 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbcIKWxm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Sep 2016 18:53:42 -0400
Received: by mail-pa0-f51.google.com with SMTP id cm16so44884060pac.0
        for <ceph-devel@vger.kernel.org>; Sun, 11 Sep 2016 15:53:42 -0700 (PDT)
Received: from [192.168.1.105] ([122.172.62.196])
        by smtp.gmail.com with ESMTPSA id y3sm19570711pfy.36.2016.09.11.15.53.40
        for <ceph-devel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Sep 2016 15:53:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Definitions

Orphaned Objects: Orphaned objects are created when a Multipart upload =
has uploaded some or all of the parts but without executing multipart =
cancel or multipart complete. An incomplete Multipart upload is neither =
created nor destroyed, it is in orphan state
Leaked Objects : Objects that are not deleted on the ceph cluster but =
assumed to be deleted by s3 client. These objects cannot be accessed by =
s3 clients but still occupy space in the ceph cluster

Problem

A s3 bucket cannot be deleted when there are objects in it. The bucket =
deletion command will fail with error BucketNotEmpty. The objects in the =
buckets can be listed using any of the s3 clients. In case if we have =
orphaned objects present in the bucket, they will not be listed via the =
normal listing operations of the s3 clients. If the bucket is deleted =
when there are orphaned objects in the bucket, they will end up being =
leaked. This ends of using space in the ceph cluster even though the =
objects are not accessed by any of the s3 clients. This space is not =
accounted under the radosgw user account as well

Tracker link

http://tracker.ceph.com/issues/17164

Fix

The fix will avoid deletion of buckets even if there are Orphaned =
objects in the bucket. So now bucket deletion command will return =
BucketNotEmpty  when there are orphaned objects as well.

Pull request

https://github.com/ceph/ceph/pull/10920=20

Can somebody Please review the fix. We have already verified the fix =
locally.

Regards,
Praveen.


