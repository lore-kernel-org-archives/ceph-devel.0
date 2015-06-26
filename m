From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Inline dedup/compression
Date: Fri, 26 Jun 2015 11:08:03 +0800
Message-ID: <CACJqLybMy1Tfr8baZMbv268gbmeBpG7uJuvbkrnQ9pjdn-AOvA@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33971 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbFZDID convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 23:08:03 -0400
Received: by pabvl15 with SMTP id vl15so60743879pab.1
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 20:08:03 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 26, 2015 at 6:01 AM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Cephers,
>     It is not easy to ask when Ceph is going to support inline dedup/compression across OSDs in RADOS because it is not easy task and answered. Ceph is providing replication and EC for performance and failure recovery. But we also lose the efficiency  of storage store and cost associate with it. It is kind of contradicted with each other. But I am curious how other Cephers think about this question.
>    Any plan for Cephers to do anything regarding to inline dedupe/compression except the features brought by local node itself like BRTFS?

Compression is easier to implement in rados than dedup. The most
important thing about compression is where we begin to compress,
client, pg or objectstore. Then we need to decide how much the
compress unit is. Of course, compress and dedup both like to use
keyvalue-alike storage api to use, but I think it's not difficult to
use existing objectstore api.

Dedup is more possible to implement in local osd instead of the whole
pool or cluster, and if we want to do dedup for the pool level, we
need to do dedup from client.

>
>   Regards,
>   James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
