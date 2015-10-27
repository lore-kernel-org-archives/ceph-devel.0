From: huang jun <hjwsm1989@gmail.com>
Subject: server unclear options of buckets stats info
Date: Tue, 27 Oct 2015 21:34:16 +0800
Message-ID: <CABAwU-b189oRUQ+B11bCVuz_G-d42CYjK+V9yMscM2t1CwOehA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36827 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbJ0NeS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Oct 2015 09:34:18 -0400
Received: by lbcao8 with SMTP id ao8so63456442lbc.3
        for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2015 06:34:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all
I am looking rgw storage object, when use the following command to
view the bucket information:
>>> radosgw-admin bucket stats --bucket = bk0
{"Bucket": "bk0",
   "pool": ".rgw.buckets",
   "index_pool": ".rgw.buckets.index",
   "id": "default.4958.1",
   "marker": "default.4958.1",
   "owner": "rgwtest",
   "ver": 15,
   "master_ver": 0,
   "mtime": 1445568223,
   "max_marker": "",
   "usage": {"rgw.main": {"size_kb": 36,
           "size_kb_actual": 40,
           "num_objects": 3}},
   "bucket_quota": {"enabled": false,
       "max_size_kb": -1,
       "max_objects": -1}}

but I don't understand the meaning of marker, master_ver, max_marker.
what are they stand for? Any tips are welcome.

Thank you!
