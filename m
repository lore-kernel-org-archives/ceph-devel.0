From: Elita Lobo <loboelita@gmail.com>
Subject: When is do_redundant_reads flag set?
Date: Fri, 21 Apr 2017 15:42:34 +0530
Message-ID: <CAA8xDw0KvsgYGC7utasZKpy5_960T3vDd4N_7TVecSey=f4X=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36367 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037795AbdDUKMf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Apr 2017 06:12:35 -0400
Received: by mail-wm0-f52.google.com with SMTP id o81so12111018wmb.1
        for <ceph-devel@vger.kernel.org>; Fri, 21 Apr 2017 03:12:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Myna V <mynaramana@gmail.com>

Hi,

We were going through get_min_avail_to_read_shards function and we had
a query regarding the same.

int get_min_avail_to_read_shards(
    const hobject_t &hoid,     ///< [in] object
    const set<int> &want,      ///< [in] desired shards
    bool for_recovery,         ///< [in] true if we may use non-acting replicas
    bool do_redundant_reads,   ///< [in] true if we want to issue
redundant reads to reduce latency
    //set<pg_shard_t> *to_read   ///< [out] shards to read
    //); ///< @return error code, 0 on success
    map<pg_shard_t, list<pair<int,int>>> *to_read);

In which all cases is do_redundant_reads flag set and what is the
purpose of this flag?



Thanking you,
Yours sincerely,
Elita Lobo
