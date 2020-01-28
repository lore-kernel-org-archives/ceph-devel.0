From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v5 0/10] ceph: add perf metrics support
Date: Tue, 28 Jan 2020 15:16:37 +0100
Message-ID: <CAOi1vP-o+mNPprtFKjD-=ifEzHS6uMva2ZDf=LM6PCT4CJuPoA@mail.gmail.com>
References: <20200128130248.4266-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:40300 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgA1OQa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jan 2020 09:16:30 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so14380191iop.7
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jan 2020 06:16:30 -0800 (PST)
In-Reply-To: <20200128130248.4266-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 28, 2020 at 2:03 PM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Changed in V2:
> - add read/write/metadata latency metric support.
> - add and send client provided metric flags in client metadata
> - addressed the comments from Ilya and merged the 4/4 patch into 3/4.
> - addressed all the other comments in v1 series.
>
> Changed in V3:
> - addressed Jeff's comments and let's the callers do the metric
> counting.
> - with some small fixes for the read/write latency
> - tested based on the latest testing branch
>
> Changed in V4:
> - fix the lock issue
>
> Changed in V5:
> - add r_end_stamp for the osdc request
> - delete reset metric and move it to metric sysfs
> - move ceph_osdc_{read,write}pages to ceph.ko
> - use percpu counters instead for read/write/metadata latencies
>
> It will send the metrics to the MDSs every second if sending_metrics is enabled, disable as default.

Hi Xiubo,

What is this series based on?  "[PATCH v5 01/10] ceph: add caps perf
metric for each session" changes metric_show() in fs/ceph/debugfs.c,
but there is no such function upstream or in the testing branch.

Thanks,

                Ilya
