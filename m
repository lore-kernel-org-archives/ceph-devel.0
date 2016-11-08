From: Igor Fedotov <ifedotov@mirantis.com>
Subject: A way to reduce compression overhead
Date: Tue, 8 Nov 2016 20:28:19 +0300
Message-ID: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34802 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbcKHR21 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 12:28:27 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so225528205qke.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 09:28:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage, et al.

Let me share some ideas about possible compression burden reduction on 
the cluster.

As known we perform block compression at BlueStore level for each 
replica independently. This triples compression CPU overhead for the 
cluster. Looks like significant CPU resource waste IMHO.

We can probably eliminate this overhead by introduction write request 
preprocessing performed at ObjectStore level synchronously. This 
preprocessing parses transaction, detects write requests and transforms 
them into different ones aligned with current store allocation unit. At 
the same time resulting extents that span more than single AU are 
compressed if needed. I.e. preprocessing do some of the job performed at 
BlueStore::_do_write_data that splits write request into 
_do_write_small/_do_write_big calls. But after the split and big blob 
compression preprocessor simply updates the transaction with new write 
requests.

E.g.

with AU = 0x1000

Write Request (1~0xffff) is transformed into the following sequence:

WriteX 1~0xfff (uncompressed)

WriteX 0x1000~E000 (compressed if needed)

WriteX 0xf000~0xfff (uncompressed)

Then updated transaction is passed to all replicas including the master 
one using regular apply_/queue_transaction mechanics.


As a bonus one receives automatic payload compression when transporting 
request to remote store replicas.
Regular write request path should be preserved for EC pools and other 
needs as well.

Please note that almost no latency is introduced for request handling. 
Replicas receive modified transaction later but they do not spend time 
on doing split/compress stuff.

There is a potential conflict with the current garbage collection stuff 
though - we can't perform GC during preprocessing due to possible race 
with preceding unfinished transactions and consequently we're unable to 
merge and compress merged data. Well, we can do that when applying 
transaction but this will produce a sequence like this at each replica:

decompress original request + decompress data to merge -> compress 
merged  data.

Probably this limitation isn't that bad - IMHO it's better to have 
compressed blobs aligned with original write requests.

Moreover I have some ideas how to get rid of blob_depth notion that 
makes life a bit easier. Will share shortly.

Any thought/comments?

Thanks,
Igor


