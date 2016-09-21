From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: cache tier on rgw index pool
Date: Wed, 21 Sep 2016 18:13:48 +0530
Message-ID: <CAP3mxSwSbn9YJyiffENP8nykXDzQZKBbneS83Pb5BEyRpqx0dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35260 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757333AbcIUMnt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 08:43:49 -0400
Received: by mail-yw0-f174.google.com with SMTP id u82so49863150ywc.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 05:43:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Users <ceph-users@lists.ceph.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I am evaluating on setting up a cache tier for the rgw index pool and
have a few questions regarding that. The rgw index pool is different
as it completely stores the data in leveldb. The 'rados df' command on
the existing index pool shows size in KB as 0 on a 1 PB cluster with
500 million objects running ceph 0.94.2.

Seeking clarifications on the following points:

1. How are the cache tier parameters like target_max_bytes,
cache_target_dirty_ratio and cache_target_full_ratio honoured given
the size of index pool is shown as 0 and how does flush/eviction take
place in this case? Is there any specific reason why the omap data is
not reflected in the size, as Sage mentions it here [1]

2. I found a mail archive in ceph-devel where Greg mentions that
"there's no cross-OSD LevelDB replication or communication" [2]. In
that case,  how does ceph handle re-balancing of leveldb instance data
in case of node failure?

3. Are there any surprises that can be expected on deploying a cache
tier for rgw index pool ?

[1] http://www.spinics.net/lists/ceph-devel/msg28635.html
[2] http://www.spinics.net/lists/ceph-devel/msg24990.html

Thanks
Abhishek Varshney
