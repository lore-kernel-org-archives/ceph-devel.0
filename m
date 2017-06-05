From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: How does rbd-mirror preserve the order of WRITE operations that
 finished on the primary cluster
Date: Mon, 5 Jun 2017 08:00:06 -0400
Message-ID: <CA+aFP1B=M97rVtGcY=v79zg_2rS=+NNcO5FTT32yLCZtky7N7g@mail.gmail.com>
References: <70c5c552.66e6.15c766dce68.Coremail.xxhdx1985126@163.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36124 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbdFEMAJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jun 2017 08:00:09 -0400
Received: by mail-yw0-f171.google.com with SMTP id l75so14337244ywc.3
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jun 2017 05:00:08 -0700 (PDT)
In-Reply-To: <70c5c552.66e6.15c766dce68.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The order of writes from a single client connection to a single OSD is
guaranteed. The rbd-mirror journal replay process handles one event at
a time and does not start processing the next event until the IO has
been started in-flight with librados. Therefore, even though the
replay process allows 50 - 100 IO requests to be in-flight, those IOs
are actually well-ordered in terms of updates to a single object.

Of course, such an IO request from the client application / VM would
be incorrect behavior if they didn't wait for the completion callback
before issuing the second update.

On Mon, Jun 5, 2017 at 12:05 AM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
> Hi, everyone.
>
>
> Recently, I've been reading the source code of rbd-mirror. I wonder how rbd-mirror preserves the order of WRITE operations that finished on the primary cluster. As far as I can understand the code, rbd-mirror fetches I/O operations from the journal on the primary cluster, and replay them on the slave cluster without checking whether there's already any I/O operations targeting the same object that has been issued to the slave cluster and not yet finished. Since concurrent operations may finish in a different order than that in which they arrived at the OSD, the order that the WRITE operations finish on the slave cluster may be different than that on the primay cluster. For example: on the primary cluster, there are two WRITE operation targeting the same object A which are, in the order t
 hey finish on the primary cluster, "WRITE A.off data1" and "WRITE A.off data2"; while when they are replayed on the slave cluster, the order may be "WRITE A.off data2" and "WRITE A.off data1", which means that the result of the two operations on the primary cluster is A.off=data2 while, on the slave cluster, the result is A.off=data1.
>
>
> Is this possible?
>
>
>



-- 
Jason
