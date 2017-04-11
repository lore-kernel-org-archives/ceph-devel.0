From: qi Shi <m13913886148@gmail.com>
Subject: How to understand Collection in Bluestore, is it a folder?
Date: Tue, 11 Apr 2017 17:53:58 +0800
Message-ID: <CAN=xyVWyju7wrjvwf+pU6+atWOh2smiujATwLNx+C2n1GT-xrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35108 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdDKJyA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Apr 2017 05:54:00 -0400
Received: by mail-io0-f177.google.com with SMTP id r16so72631115ioi.2
        for <ceph-devel@vger.kernel.org>; Tue, 11 Apr 2017 02:54:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  struct Collection : public CollectionImpl {
    BlueStore *store;
    Cache *cache;       ///< our cache shard
    coll_t cid;
    bluestore_cnode_t cnode;
    RWLock lock;

    bool exists;

    SharedBlobSet shared_blob_set;      ///< open SharedBlobs

    // cache onodes on a per-collection basis to avoid lock
    // contention.
    OnodeSpace onode_map;

    //pool options
    pool_opts_t pool_opts;
