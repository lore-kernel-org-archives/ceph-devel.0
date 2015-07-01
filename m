From: Ning Yao <zay11022@gmail.com>
Subject: Re: Inline dedup/compression
Date: Wed, 1 Jul 2015 21:46:42 +0800
Message-ID: <CALZt5jxytLL3UENohR=vRiA5KshkCEw2biHh=JyVE8FZKTiubg@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLybMy1Tfr8baZMbv268gbmeBpG7uJuvbkrnQ9pjdn-AOvA@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B3198B4@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLyY2P0_O-MRs9MoH1oVg8jESc0EoAjSq4dYmVjH=K0a0mQ@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319BBA@SSIEXCH-MB3.ssi.samsung.com>
	<9E914F5BD7F48A4782456CEB550A422824E8F967@SACMBXIP02.sdcorp.global.sandisk.com>
	<7334B4281E425749B85E08CF7EC6F85343783D7B@SACMBXIP03.sdcorp.global.sandisk.com>
	<9E914F5BD7F48A4782456CEB550A422824E8FABA@SACMBXIP02.sdcorp.global.sandisk.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319E3E@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38685 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbbGANqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jul 2015 09:46:43 -0400
Received: by wibdq8 with SMTP id dq8so45978847wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jul 2015 06:46:42 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B319E3E@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

For compression, I prefer to implement it in ECpool, it is much easier
because objects in ECpool are already striped, which is what we have
already finished now(and in testing). And the only Append write
operation is allowed in EC, which is also lead us to implement it
conveniently. Moreover, as is mentioned by Haomai, it will induce
large read, write penalty and the data becomes fragment if compression
is used in Replicated Pool. Actually, the purpose we do compression is
to save storage and bandwidth, so the pros and cons is more related to
what service you provides. Like VDI case, which includes lots small
read_write, it is not a smart decision to do compression in Replicated
Pool so that we just apply the compression in EC. I think kv-store,
like rocksdb and leveldb, is much suitable for Replicated Pool if
compression is need to be done.
Implementation like:
Write:
      1) ECpool  copy_from() object  from HotPool
      2) Compress data by stripe and calculate hash_info for object as
well as compress_info (which maintains (off,lens) pair for compressed
object corresponding to the content for original object. And some
other info also need like compress alg and so on)
      3) encode compress_info into bufferlist and treat it as a
setattr transaction
READ:
may proxy read or promotion:
      Promotion:
          copy from whole compress object with compress_info to
ReplicatedPG and submitted promotion_write Transaction (just like
normal write Transaction, but need decompression before write to
FileStore)
      proxy read:
          may return compress_info and  read content to Replicated
Pool and decompress to content. Select out the required data and send
back to client.


Glad to hear a new idea to do the pool based dedup from Chaitanya. It
seems that the thought is to maintain the large number of manifest
objects just like current rados objects and distribute among all osds.
Am I right? It, though,  increases the request path, but reduce the
complexity. If introducing a centralized memory index server cluster,
it may become too complex and hard to maintain and scale. Finally, it
will become the second mds and cannot be done well with huge
complexity.
