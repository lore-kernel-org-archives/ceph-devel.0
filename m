From: xiaoyan li <wisher2003@gmail.com>
Subject: Plan of cache tiering?
Date: Thu, 30 Mar 2017 13:54:12 +0800
Message-ID: <CAERxPZJ=dE1PwzrZwkHDfBiZjRLDG4P84KY=ruD3by32OKFbXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:32792 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754808AbdC3FyO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Mar 2017 01:54:14 -0400
Received: by mail-wr0-f170.google.com with SMTP id w43so44319705wrb.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 22:54:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sage and all,

I am interested to do something in cache tiering.

As we know, the two model caching and tiering are different ways to use SSD.
In a tiering model, data is moved to the flash tier exclusively,
meaning it never exists on both flash(cache tier) and hard
disk(storage tier) drives. And in caching model, data is promoted to
cache tier when read/write, and hot data exists in both cache tier and
storage tier.
Current Ceph cache tiering use cache model. If data is missed in cache
tier, it needs to read from storage tier, and adding extra latency.
The average
latency is (latency of cahe tier)*percentage of cache hit + (latency
of cache tier + lantency of storage tier)*percentage of cache miss.

I am wondering how about we complete the feature with tiering model. The
following is my raw thought:
That is to say data in an image or object, hot data are put in cache tier, cold
data are put in storage tier. Ceph tracks statistics of every object/chunks,
and do promotion/demotion once every day or specified period.
Meanwhile, combine librbd. First time client read data from an image,
it can cache the real position(which pool data is) in client cache if
not promotion/demotion ongoing. Later client can read data directly
from cache tier or storage tier, no extra forward is needed.
As a result, most of time we can get (latency of cache tier)*percentage of
hot data + (latency of storage tier)*percentage of cold data.

At the same time, I noticed that Sage talked something about rados
tiering plan in following thread, could you please describe it more
clearly, Sage?
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-February/016305.html


-- 
Best wishes
Lisa
