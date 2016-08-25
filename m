From: Haomai Wang <haomai@xsky.com>
Subject: Re: parallel transaction submit
Date: Thu, 25 Aug 2016 15:55:16 +0800
Message-ID: <CACJqLyY7YZ=O_do0OD8d28cmNiknDcMm957qYidA_zGoQ5O+gw@mail.gmail.com>
References: <FC753468179C1C4EB15768F212C46AF266329D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0105.outbound.protection.outlook.com ([104.47.125.105]:18880
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751731AbcHYILW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Aug 2016 04:11:22 -0400
Received: by mail-ua0-f173.google.com with SMTP id n59so70732588uan.2
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 00:55:20 -0700 (PDT)
In-Reply-To: <FC753468179C1C4EB15768F212C46AF266329D@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Tang, Haodong" <haodong.tang@intel.com>
Cc: "sweil@redhat.com" <sweil@redhat.com>, "varada.kari@sandisk.com" <varada.kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

looks very litlle improvements. rocksdb result meet my expectation
because rocksdb internal has lock for multi sync write. But memdb
improments is a little confusing.

On Thu, Aug 25, 2016 at 3:45 PM, Tang, Haodong <haodong.tang@intel.com> wrote:
> Hi Sage, Varada
>
> Noticed you are making parallel transaction submits, we also worked out a prototype that looks similar, here is the link for the implementation: https://github.com/ceph/ceph/pull/10856
>
> Background:
> From the perf counter we added, found it spent a lot time in kv_queue, that is, single thread transaction submits is not competent to handle the transaction from OSD.
>
> Implementation:
> The key thought is to use multiple thread and assign each TransContext to one of the processing threads. In order to parallelize transaction submit, add different kv_locks and kv_conds for each thread.
>
> Performance evaluation:
> Test ENV:
>         4 x server, 4 x client, 16 x Intel S3700 as block device, and 4 x Intel P3600 as Rocksdb/WAL device.
> Performance:
> We also did several quick tests to verify the performance benefit, the results showed that parallel transaction submission will brought 10% performance improvement if using memdb, but little performance improvement with rocksdb.
>
> What's more, without parallel transaction submits, we also see performance boost if just changing to MemDB, but a little.
>
> Test summary:
> QD Scaling Test - 4k Random Write:
>                                                                                   QD = 1      QD = 16     QD = 32      QD = 64      QD = 128
> With rocksdb (IOPS)                                              682            173000       190000        203000       204000
> With memdb (IOPS)                                              704            180000       194000        206000       218000
> With rocksdb+multiple_kv_thread(IOPS)          /                164243        167037        180961      201752
> With memdb+multiple_kv_thread(IOPS)          /                 176000       200000        221000      227000
>
>
> It seems single thread of transaction submits will be a bottleneck if using MemDB.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
