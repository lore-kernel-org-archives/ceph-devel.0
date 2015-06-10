From: Harshal Gupta <harshal.gupta001@gmail.com>
Subject: Fwd: Response on duplicate bucket creation in rgw
Date: Wed, 10 Jun 2015 16:50:44 +0530
Message-ID: <CAPRac-aQj-ruq+s2MANnrSDTKovpR4ecJra=i0Q+U6i5eb_Pew@mail.gmail.com>
References: <CAPRac-aQJw6Yxn-JnEBYRt-bB99dVy9fx5Gg29d+jAHshfiJRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33613 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933134AbbFJLVG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 07:21:06 -0400
Received: by wiwd19 with SMTP id d19so44956999wiw.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 04:21:04 -0700 (PDT)
In-Reply-To: <CAPRac-aQJw6Yxn-JnEBYRt-bB99dVy9fx5Gg29d+jAHshfiJRQ@mail.gmail.com>
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

I am thinking to match the functionality of Ceph Rgw same as s3
(non-default regions), as the one given by S3 seems more appropriate.

For this, I have added a new error code "BucketAlreadyOwnedByYou"
which will be thrown in the above mentioned
case.

Please give your opinion about it.

Thanks

HARSHAL GUPTA
