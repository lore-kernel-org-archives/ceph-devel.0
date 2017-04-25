From: David Zafman <dzafman@redhat.com>
Subject: Re: When is do_redundant_reads flag set?
Date: Tue, 25 Apr 2017 15:42:26 -0700
Message-ID: <5642a610-e299-4505-2302-e164325cde9a@redhat.com>
References: <CAA8xDw0KvsgYGC7utasZKpy5_960T3vDd4N_7TVecSey=f4X=g@mail.gmail.com>
 <alpine.DEB.2.11.1704211319500.6575@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945382AbdDYWm2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 25 Apr 2017 18:42:28 -0400
In-Reply-To: <alpine.DEB.2.11.1704211319500.6575@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Elita Lobo <loboelita@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Myna V <mynaramana@gmail.com>


Using the following command to enable the option will cause true to be 
passed for the do_redundant_reads arg.

To enable:

ceph osd pool set <poolname> fast_read 1

To disable:

ceph osd pool set <poolname> fast_read 0


David


On 4/21/17 6:20 AM, Sage Weil wrote:
> On Fri, 21 Apr 2017, Elita Lobo wrote:
>> Hi,
>>
>> We were going through get_min_avail_to_read_shards function and we had
>> a query regarding the same.
>>
>> int get_min_avail_to_read_shards(
>>      const hobject_t &hoid,     ///< [in] object
>>      const set<int> &want,      ///< [in] desired shards
>>      bool for_recovery,         ///< [in] true if we may use non-acting replicas
>>      bool do_redundant_reads,   ///< [in] true if we want to issue
>> redundant reads to reduce latency
>>      //set<pg_shard_t> *to_read   ///< [out] shards to read
>>      //); ///< @return error code, 0 on success
>>      map<pg_shard_t, list<pair<int,int>>> *to_read);
>>
>> In which all cases is do_redundant_reads flag set and what is the
>> purpose of this flag?
> The idea is that if you have a k+m code, you read all k+m shards (not just
> k of them), and use whatever replies come back first to assemble or
> recover the data block.  It helps reduce tail latency on EC pools by
> preventing the slowest responder from delaying the reply (as long as the
> slowest responder isn't the primary).
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

