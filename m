From: Sage Weil <sage@newdream.net>
Subject: Re: When is do_redundant_reads flag set?
Date: Fri, 21 Apr 2017 13:20:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704211319500.6575@piezo.novalocal>
References: <CAA8xDw0KvsgYGC7utasZKpy5_960T3vDd4N_7TVecSey=f4X=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58113 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1039719AbdDUNU7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Apr 2017 09:20:59 -0400
In-Reply-To: <CAA8xDw0KvsgYGC7utasZKpy5_960T3vDd4N_7TVecSey=f4X=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Myna V <mynaramana@gmail.com>

On Fri, 21 Apr 2017, Elita Lobo wrote:
> Hi,
> 
> We were going through get_min_avail_to_read_shards function and we had
> a query regarding the same.
> 
> int get_min_avail_to_read_shards(
>     const hobject_t &hoid,     ///< [in] object
>     const set<int> &want,      ///< [in] desired shards
>     bool for_recovery,         ///< [in] true if we may use non-acting replicas
>     bool do_redundant_reads,   ///< [in] true if we want to issue
> redundant reads to reduce latency
>     //set<pg_shard_t> *to_read   ///< [out] shards to read
>     //); ///< @return error code, 0 on success
>     map<pg_shard_t, list<pair<int,int>>> *to_read);
> 
> In which all cases is do_redundant_reads flag set and what is the
> purpose of this flag?

The idea is that if you have a k+m code, you read all k+m shards (not just 
k of them), and use whatever replies come back first to assemble or 
recover the data block.  It helps reduce tail latency on EC pools by 
preventing the slowest responder from delaying the reply (as long as the 
slowest responder isn't the primary).

sage

