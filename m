From: Casey Bodley <cbodley@redhat.com>
Subject: design notes: rgw multisite and cleanup of deleted buckets
Date: Thu, 27 Jul 2017 14:39:51 -0400
Message-ID: <ad5b5ecf-84fc-3236-aa73-89525fdcb866@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35317 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdG0Sjy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jul 2017 14:39:54 -0400
Received: by mail-qk0-f169.google.com with SMTP id d145so101362717qkc.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jul 2017 11:39:54 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id z192sm13636289qka.46.2017.07.27.11.39.51
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jul 2017 11:39:52 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Motivation:
When buckets are removed on the master zone in a multisite 
configuration, the bucket instance and index objects are never removed 
(only the bucket entrypoint is removed, which makes the bucket 
unreachable). The reason we don't remove the instance/indices is because 
the peer zones may not have finished processing all of the object 
removal entries for that bucket, and they can't make progress with that 
if the master zone is unable to serve the bucket instance metadata or 
bucket index logs. This would result in leaked objects/data.

Tracker issue: http://tracker.ceph.com/issues/20802

Design:
In short, the master zone will actually delete its bucket instance and 
index objects in RGWRados::delete_bucket(), and peer zones will learn to 
deal with it during sync.

metadata sync:
When the master zone deletes a bucket instance, it writes that bucket 
instance to the metadata log. When another zone sees this entry during 
metadata sync, it will:
1) set a new 'remove-only' flag on each of its bucket index objects,
2) write an entry for each bucket index shard to a new 'bucket gc log' 
(described below), and
3) remove its local copy of the bucket instance.

bucket sync:
When bucket sync discovers that its bucket has been removed (either from 
getting ENOENT when trying to fetch the bucket instance metadata from 
the master zone, or from seeing the 'remove-only' flag on the local 
bucket index when trying to sync an object), it deletes its sync status 
object and stops processing that bucket (using similar logic to the 
'bucket sync disable' feature in development at 
https://github.com/ceph/ceph/pull/15801). If the data changes log 
triggers another attempt to sync this bucket shard, it will try to fetch 
its bucket instance metadata from the master zone and fail with ENOENT.

bucket gc:
Since we stop trying to sync deleted buckets, they may still contain 
objects. All objects need to be deleted before we can remove the bucket 
index objects themselves. This process is deferred to a background 
thread using a new 'bucket gc log'. Object deletion will keep the bucket 
index consistent so that it can resume its progress across radosgw 
restarts. The 'remove-only' flag on the bucket index will allow this 
deletion, while preventing bucket sync from adding new objects. Once all 
objects are removed from each bucket index, the bucket index object can 
be safely deleted and its entry trimmed from the bucket gc log. The 
bucket gc worker thread will process the first N entries in parallel, 
where N is configurable with a default of ~16. A rados lock on the log 
object will prevent other gateways in the zone from duplicating the work 
(similar to DataLogTrimPollCR for datalog trimming).

Casey
