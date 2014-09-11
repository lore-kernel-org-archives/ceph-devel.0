From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: do not return -ERANGE on auth failure
Date: Thu, 11 Sep 2014 20:17:56 +0400
Message-ID: <CALFYKtAH_9nQWWyOEcEectWzWQxsNBVHRSPVt_QbU8rfG1_YFA@mail.gmail.com>
References: <1410448246-6635-1-git-send-email-ilya.dryomov@inktank.com>
	<5411BE6F.1040202@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:60014 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808AbaIKQSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 12:18:02 -0400
Received: by mail-qc0-f169.google.com with SMTP id r5so2393858qcx.0
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 09:17:57 -0700 (PDT)
In-Reply-To: <5411BE6F.1040202@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 11, 2014 at 7:23 PM, Alex Elder <elder@ieee.org> wrote:
> On 09/11/2014 10:10 AM, Ilya Dryomov wrote:
>> Trying to map an image out of a pool for which we don't have an 'x'
>> permission bit fails with -ERANGE from ceph_extract_encoded_string()
>> due to an unsigned vs signed bug.  Fix it and get rid of the -ENIVAL
>> sink, thus exposing rbd::get_id cls method return value.  (I've seen
>> a bunch of unexplained -ERANGE reports, I bet this is it).
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>
> I often think people are annoyed by my explicit type casts
> all over the place.  This (missed) one matters a lot.
>
> I think the -EINVAL was to ensure an error code that was
> expected by a write() call would be returned.

Yeah, the way it's written it's possible in theory to get a positive
return value from rbd_dev_image_id().  Looking deeper, this sizeof() is
not needed at all - ceph_extract_encoded_string() deals with short
buffers as it should.  As for the ret == sizeof(u32) (i.e. an empty
string), neither userspace nor us check against empty strings in
similar cases (object prefix, snapshot name, etc).

With the above in mind, how about this?

From 3ded0a7fee82f2204c58b4fc00fc74f05331514d Mon Sep 17 00:00:00 2001
From: Ilya Dryomov <ilya.dryomov@inktank.com>
Date: Thu, 11 Sep 2014 18:49:18 +0400
Subject: [PATCH] rbd: do not return -ERANGE on auth failures

Trying to map an image out of a pool for which we don't have an 'x'
permission bit fails with -ERANGE from ceph_extract_encoded_string()
due to an unsigned vs signed bug.  Fix it and get rid of the -EINVAL
sink, thus propagating rbd::get_id cls method errors.  (I've seen
a bunch of unexplained -ERANGE reports, I bet this is it).

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4b97baf8afa3..ce457db5d847 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4924,7 +4924,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
                ret = image_id ? 0 : -ENOMEM;
                if (!ret)
                        rbd_dev->image_format = 1;
-       } else if (ret > sizeof (__le32)) {
+       } else if (ret >= 0) {
                void *p = response;

                image_id = ceph_extract_encoded_string(&p, p + ret,
@@ -4932,8 +4932,6 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
                ret = PTR_ERR_OR_ZERO(image_id);
                if (!ret)
                        rbd_dev->image_format = 2;
-       } else {
-               ret = -EINVAL;
        }

        if (!ret) {
-- 
1.7.10.4
