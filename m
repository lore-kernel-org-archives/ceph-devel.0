From: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Subject: Strange about radosgw-admin bucket link/unlink
Date: Fri, 10 Aug 2012 14:28:55 +0800
Message-ID: <CAKG+gh8OygctHM6aHzfXD-mnGOs-ftyfpo35sTZGQJSd4QQHRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61324 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab2HJG24 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 02:28:56 -0400
Received: by eaac11 with SMTP id c11so386361eaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 23:28:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Is it a bug or my usage is wrong?
When I link a bucket to another specified user, all bucket's contents
are cleaned,
on the other hand, after unlinking a bucket, original user still can
access the bucket contents.

+My original bucket:
$ sudo radosgw-admin bucket stats --bucket 456
{ "bucket": "456",
  "pool": ".rgw.buckets",
  "id": "4731.1",
  "marker": "4731.1",
  "owner": "707ceba699b54cde9a4cff854bea9fde",
  "usage": { "rgw.main": { "size_kb": 856,
          "size_kb_actual": 856,
          "num_objects": 1}}}

+Unlink it, the owner doesn't change,
+although I can't see it in bucket list, I can access the contents in it:
$ sudo radosgw-admin bucket unlink --bucket 456 --uid
"707ceba699b54cde9a4cff854bea9fde"
$ sudo radosgw-admin bucket stats --bucket 456
{ "bucket": "456",
  "pool": ".rgw.buckets",
  "id": "4731.1",
  "marker": "4731.1",
  "owner": "707ceba699b54cde9a4cff854bea9fde",
  "usage": { "rgw.main": { "size_kb": 856,
          "size_kb_actual": 856,
          "num_objects": 1}}}

+ When link to another user, usage change to {},
+ and all files in bucket have losed
$ sudo radosgw-admin bucket link --bucket 456 --uid admin
$ sudo radosgw-admin bucket stats --bucket 456
{ "bucket": "456",
  "pool": ".rgw.buckets",
  "id": "4934.1",
  "marker": "4934.1",
  "owner": "admin",
  "usage": {}}

And just one more question,
is there a way to link a bucket to multiple users?


Thanks.
-- 
Chuanyu Tsai
