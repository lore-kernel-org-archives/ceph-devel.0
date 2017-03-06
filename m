From: Vaibhav Bhembre <vaibhav@digitalocean.com>
Subject: RGW: Bucket Policies support
Date: Mon, 6 Mar 2017 14:54:58 -0500
Message-ID: <CADJota8vRLhZL8n9ofw_fn9t=XmiKALUQacqBWAwBw9aKy9g1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:33289 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932259AbdCFTz3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 14:55:29 -0500
Received: by mail-ot0-f175.google.com with SMTP id 19so50120423oti.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 11:55:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Cephers!

We know there is ongoing work that implements a certain subset of AWS
Security Token Service for RGW endpoints and were curious to know if it'd
include the ability to apply bucket-wide constraints as follows:

{  "Version":"2012-10-17",
   "Statement":[
    {
       "Sid":"AddCannedAcl",
       "Effect":"Allow",
       "Principal": {"AWS":
["arn:aws:iam::111122223333:root","arn:aws:iam::444455556666:root"]},
       "Action":["s3:PutObject","s3:PutObjectAcl"],
       "Resource":["arn:aws:s3:::examplebucket/*"],
    }
   ]
}

In lieu of such facility, presently the only way to update permissions of
all objects within a bucket is to apply those permissions on each object
individually, which isn't always practical.

It'd be quite helpful to have this feature in Luminous, if possible!

Thanks!

Regards,
Vaibhav
