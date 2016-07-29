From: Rajat Garg <rajatgarg.iitr@gmail.com>
Subject: Bucket Access Logging Feature
Date: Fri, 29 Jul 2016 17:01:24 +0530
Message-ID: <CAAkT=OFez++OMSb47JmNvRUx5ONk9nCBdehYEXREd89i9WtoLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33454 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcG2Lb0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 07:31:26 -0400
Received: by mail-vk0-f48.google.com with SMTP id x130so52290243vkc.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 04:31:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi cephers,

I am trying to think of a scalable design on how to store bucket logs
in respective target buckets in every one hour. I had some queries and
confirmations with the design.

I know that at the moment, radosgw only provides a GetLogging stub
which returns logging as disabled for a particular bucket. So some
changes in the following files-:

rgw/rgw_common.h
      rgw/rgw_log.cc
      rgw/rgw_main.cc
       rgw/rgw_op.cc
    rgw/rgw_op.h
    rgw/rgw_rest_s3.cc
    rgw/rgw_rest_s3.h

will enable me to set the the target_bucket for a particular bucket,
where I can put the operations logs of a particular bucket.

This can be easily done by enabling the "rgw_enable_ops_log" option.
This logs the bucket ops log to usage_map of rgw_log.cc. Also, there
is a rados object created corresponding to every bucket every hour for
the ops.

Since, I also have to report the logs in the target bucket hourly, I
am planning to write a callback (with the help of timer function) in
rgw_log.cc which will be called every 1 hour. This callback will read
all log objects (through log_list_next call of rgw_rados) and parse
these objects in a certain file and will then upload this file in the
target_bucket as radosgw object.
The callback would look something like-:

http://pastie.org/private/j4d2vihk1tvuzgmzig5ldw


After studying the code, I have some questions and design decisions to make-:
1. Would writing the callback inside rgw_log.cc and then calling the
PutObj functions for putting the object in the target bucket, inside
the callback, work? Or, callback be put in rgw_op.cc (somewhere else)
would be better?

2. One more question I have is on on putting the file object in the
target_bucket, would calling the RGWPutObj::*(pre_exec(),
verify_permissions(), execute()) be a good way. Or, is there a better
way to do this.

My main question is where to put this callback (because this callback
should work like garbage collector (I don't know much about the
garbage collector implementation details) because if I have a cluster
of 5 radosgw server, I would want to put the log object in the
target_bucket only once ),


Please let me know if your thoughts on this and give suggestions.

Thanks,
Rajat
