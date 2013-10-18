From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: issues when bucket index deep-scrubbing
Date: Fri, 18 Oct 2013 13:01:54 +0200
Message-ID: <CAMNMNTyRDoQX=ytzF-jporD3uTpaUiJqTXEzqYGetqUerJ5=-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47]:37409 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3JRLBz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Oct 2013 07:01:55 -0400
Received: by mail-qe0-f47.google.com with SMTP id b4so1624152qen.6
        for <ceph-devel@vger.kernel.org>; Fri, 18 Oct 2013 04:01:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I plan to shard my largest bucket because of issues of deep-scrubbing
(when PG which index for this bucket is stored on is deep-scrubbed, it
appears many slow requests and OSD grows in memory - after latest
scrub it grows up to 9G).

I trying to found why large bucket index make issues when it is scrubbed.
On test cluster:
radosgw-admin bucket stats --bucket=test1-XX
{ "bucket": "test1-XX",
  "pool": ".rgw.buckets",
  "index_pool": ".rgw.buckets",
  "id": "default.4211.2",
...

I guess index is in object .dir.default.4211.2. (pool: .rgw.buckets)

rados -p .rgw.buckets get .dir.default.4211.2 -
<empty>

But:
rados -p .rgw.buckets listomapkeys .dir.default.4211.2
test_file_2.txt
test_file_2_11.txt
test_file_3.txt
test_file_4.txt
test_file_5.txt

I guess that list of files are stored in leveldb not in one large file.
'omap' files are stored in {osd_dir}/current/omap/, the largest file
that i found in this directory (on production) have 8.8M.

I'm a little confused.

How list of files (for bucket) is stored?
If list of objects in bucket is splitted on many small files in
leveldb that large bucket (with many files) should not cause larger
latency in PUT new object.
Scrubbing also should not be a problem i think ...

What you think about using a sharding to split big buckets into the
smalest one to avoid the problems with big indexes?

--
Regards
Dominik
