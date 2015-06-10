From: Harshal Gupta <harshal.gupta001@gmail.com>
Subject: Duplicate bucket creation Response in RGW
Date: Wed, 10 Jun 2015 17:52:51 +0530
Message-ID: <CAPRac-a9gp1B9J3L-_TjkkP3-M9ZkvF-HwQ505NvJaqhEC392w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33108 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbbFJMXN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 08:23:13 -0400
Received: by wiwd19 with SMTP id d19so46603611wiw.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 05:23:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I was comparing response of S3 and Ceph RGW for when we try to create
a bucket which already exists for the same account.

S3 (non-default region) throws an error with:
HTTP response code : 409 Conflict
error code : BucketAlreadyOwnedByYou

but on the other hand ceph gives a 200 OK while keeping the original
bucket as it is.

I am thinking to match the functionality of Ceph RGW same as s3
(non-default regions), as the one given by S3 seems more appropriate.

For this, I have added a new error code "BucketAlreadyOwnedByYou"
which will be thrown in the above mentioned
case.

Please give your opinion about it.

Thanks

-- 
HARSHAL GUPTA
