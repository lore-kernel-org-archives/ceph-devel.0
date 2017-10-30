From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: CDM for: pg log, pg info, and dup ops data storage
Date: Mon, 30 Oct 2017 09:51:40 -0500
Message-ID: <fad6dd2f-2d81-c05a-46a6-8dca32574e31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:50994 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdJ3Ovm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Oct 2017 10:51:42 -0400
Received: by mail-io0-f174.google.com with SMTP id 97so27730245iok.7
        for <ceph-devel@vger.kernel.org>; Mon, 30 Oct 2017 07:51:42 -0700 (PDT)
Received: from [192.168.1.103] (c-68-46-79-22.hsd1.mn.comcast.net. [68.46.79.22])
        by smtp.gmail.com with ESMTPSA id b185sm6396216ioa.24.2017.10.30.07.51.41
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2017 07:51:41 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Folks,

I had a really good conversation with Josh Durgin on Friday and I wanted 
to write it down before I forgot everything.  I figured I might as well 
post it here too since folks might be interested or come up with even 
better ideas.

Background: Recently I've been looking into how much work RocksDB is 
doing in Bluestore dealing with the creation and deletion of pg log, pg 
info, and dup op key/value pairs.  Now that we are separating OMAP data 
into it's own column family, it is possible to look at OMAP statistics 
independently of bluestore metadata:

- ~1 hour 4K random overwrites to RBD on 1 NVMe OSD
- 128 PGs
- stats are sloppy since they only appear every ~10 mins
- [D] CF = onodes, etc
- [M] CF = pglog/dup_ops/pginfo
- [L] CF = defered IO

First the default:

min_pg_log_entries = 1500, trim = default, iops = 26.6K

[D] CF - Size:  65.63MB, KeyIn:  22M, KeyDrop:  17M, Flush:  7.858GB
[M] CF - Size: 118.09MB, KeyIn: 302M, KeyDrop: 269M, Flush: 15.847GB
[L] CF - Size:   1.00MB, KeyIn: 181K, KeyDrop:  80K, Flush:  0.320GB

With dup ops code path disabled by increasing the min pglog entries:

min_pg_log_entries = 3000, trim = default iops = 28.3K
[D] CF - Size:  23.13MB, KeyIn:  25M, KeyDrop:  19M, Flush:  8.762GB
[M] CF - Size: 159.97MB, KeyIn: 202M, KeyDrop: 175M, Flush: 16.890GB
[L] CF - Size:   0.86MB, KeyIn: 201K, KeyDrop:  89K, Flush:  0.355GB

Notice the large drop in KeyIn and KeyDrop records!

And now adding a hack to remove pginfo:

min_pg_log_entries = 3000, trim = default, pginfo hack, iops = 27.8K

[D] CF - Size:  23.15MB, KeyIn:  24M, KeyDrop:  19M, Flush:  8.662GB
[M] CF - Size: 159.97MB, KeyIn: 162M, KeyDrop: 139M, Flush: 10.335GB
[L] CF - Size:   1.39MB, KeyIn: 201K, KeyDrop:  89K, Flush:  0.355GB

There's still 162M KeyIn and 139M keyDrop events for pglog remaining!

So as a result of this I started thinking that there must be a better 
way to deal with this kind of data than constantly writing and deleting 
key/value pairs from the database, at least for dup ops and pg log. 
Based on my conversation with Josh it sounds like we are already reusing 
pginfo keys which might explain why hacking it out didn't result in a 
33% drop in key inserts and deletes.

For pg log and dup ops, my first thought was to simply create a simple 
on-disk ring-buffer for pglog and dup ops.  The idea being that instead 
of specifying a "min" and "max" number of pglog entries, the user would 
just assign a portion of the disk (in Bluestore perhaps a portion of the 
DB device) that would be reserved for the ring buffer and we'd fill it 
with as many pglog and dup op entries as we could.

Josh keenly pointed out that we want to make sure that inactive PG logs 
don't get overwritten by active ones.  To deal with this, I proposed a 
modification: use a series of logs and reference count the per-pg links. 
  You'd never delete an old log until all references to it are removed. 
The problem here is that potentially if you had a lot of inactive PGs 
you could end up with pretty big space amplification.

Advantages:

1) Avoid key creation/deletion
2) sequential appends only
3) Write once (no direct write amplification)

Disadvantages:

1) potential for large space amp when PGs are inactive
2) lots of new code
3) potential for thrashing with the RocksDB WAL and other writes

Josh pointed out another potential option: create a ring buffer in 
RocksDB with sequentially ordered keys.  The key names themselves are 
not particularly important: some prefix along with say an 8byte index. 
In this scenario we'd still end up writing to the WAL first and 
potentially compacting into an SST file, but the overhead should be less 
(far less?) than the current behavior.  We could also make it general 
enough that we could have per-pg ring buffers for pglog data and a 
global ringbuffer for dup-ops (which is sort of the best case scenario 
for both sitautions)

Advantages:

1) Reuse the KeyValueDB interface (and all of the optimized RocksDB code!)
2) Still avoid new key creation/deletion
3) WAL writes are still sequentially laid out and compaction overhead 
may not be too bad
4) Shared WAL means less thrashing on spinning disks than multiple 
independent WALs.
4) Space amp potentially less bad than on-disk ring-buffer approach.

Disadvantages:

1) still has compaction overhead
2) less control over what RocksDB does
3) shared WAL means implications for global KV traffic, even with 
independent column families.

No matter what we do, I think we need to get away from the current 
behavior for pglog and dup ops.  Unless I'm missing something (and I 
could be!) I don't think we need to be creating and deleting keys 
constantly like we currently are doing.  I suspect that either of the 
above approaches would improve the situation dramatically.

Mark
