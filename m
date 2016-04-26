From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: rgw : inefficient bucket listing with max-keys URL parameter
Date: Tue, 26 Apr 2016 15:48:10 +0530
Message-ID: <CAP3mxSw_SAjd9wCcFWyVbwP=QzGBJghSKVvayfM4DdP2h2zPbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36465 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbcDZKSN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2016 06:18:13 -0400
Received: by mail-yw0-f179.google.com with SMTP id o66so9694068ywc.3
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2016 03:18:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I came across an issue in rgw where bucket listing turns out to be
quite slow when a low value is specified to the URL parameter
<max-keys>. For example, the s3a hadoop connector species <max-keys>
parameter to be 1 for a certain operation [1]. The expectation of the
client here is to get result set with 1 value. Radosgw, in turn,
percolates this value down to rados and fetches a key one by one in
RGWRados::Bucket::List::list_objects function [2] before checking for
delimiter etc. This turns out to be highly inefficient and thus the
client faces time-outs.

It would have been better if a config option could be provided to
avoid such issues, like, a minimum readahead value for listing objects
from rados.

I have raised a PR for the above mentioned fix [3].

[1] https://github.com/apache/hadoop/blob/trunk/hadoop-tools/hadoop-aws/src/main/java/org/apache/hadoop/fs/s3a/S3AFileSystem.java#L1012
[2] https://github.com/ceph/ceph/blob/master/src/rgw/rgw_rados.cc#L4729
[3] https://github.com/ceph/ceph/pull/8756

Thanks
Abhishek
