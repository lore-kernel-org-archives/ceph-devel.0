From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: luminous OSD memory usage
Date: Wed, 30 Aug 2017 13:00:55 +0300
Message-ID: <d3b8007f-4bdf-65c5-f4e9-7d1d9c85e019@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:38115 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdH3KA6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 06:00:58 -0400
Received: by mail-lf0-f42.google.com with SMTP id d202so22585013lfd.5
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 03:00:57 -0700 (PDT)
Received: from [172.20.8.17] ([86.57.155.118])
        by smtp.gmail.com with ESMTPSA id s16sm1011987ljd.29.2017.08.30.03.00.55
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Aug 2017 03:00:56 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi.

I'm trying to synchronize osd daemons memory limits and bluestore cache 
settings.
For 12.1.4 we have hdd osds usage about 4G with default settings.
For ssds we have limit 6G and they are been oom killed periodically.

While
osd_op_num_threads_per_shard_hdd=1
osd_op_num_threads_per_shard_ssd=2
and
bluestore_cache_size_hdd=1G
bluestore_cache_size_ssd=3G
and
osd_op_num_shards_hdd=5
osd_op_num_shards_ssd=8

Does it mean that ssd osds will use 4G*2*3*8/5, or 3G*2*8/5, or other?
Does anybody have an idea about the equation for upper bound of memory 
consumption?
Can bluestore_cache_size be decreased safely for example to 2G, or to 1G?

I want to calculate the maximum expected size of bluestore metadata 
(that must be definitely fit into cache) using size of raw space, 
average size of objects, rocksdb space amplification.
I thought it should be something simple like 
raw_space/avg_obj_size*obj_overhead*rocksdb_space_amp.
For example if obj_overhead=1k, hdd size=1T, rocksdb space amplification 
is 2 and avg obj size=4M then 1T/4M*1k*2=500M so I need at least 512M 
for cache.
But wise guys said that I have to take into account number of extents also.
But bluestore_extent_map_shard_max_size=1200, I hope this number is not 
a multiplicator...
What would be correct approach for calculation of this minimum cache size?
What can be expected size of key-values stored in rocksdb per rados object?

Default bluestore_cache_kv_ratio*bluestore_cache_size_ssd=0.99*3G
while default bluestore_cache_kv_max=512M
Looks like BlueStore::_set_cache_sizes() will set cache_kv_ratio to 1/6 
in default case. Is 512M enough for bluestore metadata?


Thanks!
Aleksei
