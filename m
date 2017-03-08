From: Jiaying Ren <mikulely@gmail.com>
Subject: RGW: Implement S3 bucket logging feature
Date: Wed, 8 Mar 2017 16:21:18 +0800
Message-ID: <CAF8OO3P3UiP+23CLUY0doYJLJNroAm2m5fu5zap6ctr3uP9wtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35487 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdCHIWI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 03:22:08 -0500
Received: by mail-qk0-f174.google.com with SMTP id v125so51378814qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 00:21:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ysadehwe@redhat.com, ceph-devel@vger.kernel.org

Hi~ Yehuda and Ceph developers:

We're trying to implement S3 feature bucket
logging (http://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html).

Currently RGW didn't support bucket
logging(http://tracker.ceph.com/issues/3225),but has similar
functionality called opslog.

RGW opslog has its own CLI API,opslog can be accessed only by
radosgw-admin CLI API(radosgw-admin log list/show). In order to
compatible with S3, we're trying to adapt current opslog to support
S3 bucket logging HTTP API via RGW s3 endpoint. Does this make sense
for RGW? Caz I've found we tried to impl ops log HTTP API via admin
endpoint(https://github.com/ceph/ceph/pull/7859)

If the answer is yes,we'd like to share our plan.The basic idea to
impl bucket logging takes two steps:

1) Reuse current ops log (rgw_ops_log_rados)impl as a temp&durable
   storage(ops log be stored as a rados-object)
2) Add a new thread periodically upload opslog rados-object as rgw-object

more detailed steps:

1) impl bucket logging HTTP config API
   + GET bucket logging
   + PUT bucket logging
     + store bucket logging config into bucket attribute
     + add new entry(<bucket_name,bucket_logging_status>) to a sharded
       <bucket_logging.X> rados-object's omap in <.rgw.bl> pool
       (<bucket_logging.X>'s omap head store a marker to track
       progress)
   + ACL support Log Delivery Group
2) impl ops log deliver logic
   + upload rados-object as rgw-object(or to avoid extra data
     transfer,can we map a rados-obj to a rgw-object by editing its
     manifiest?)
   + (optional) trim opslog
3) impl bucket logging CLI API
   + radosgw-admin bl list // list all bucket logging progress
   + radosgw-admin bl deliver  // manually deliver ops log

Any comments are appreciated.Thx.

--
mikuley
