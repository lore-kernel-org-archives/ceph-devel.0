From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: distributed point-in-time consistency report
Date: Fri, 3 Nov 2017 12:57:01 +0800
Message-ID: <CAJACTufg2H_sjG0V3iuVCXi3Q6kjY7fpTm8L=CU1NfwStSiWZQ@mail.gmail.com>
References: <alpine.DEB.2.11.1709070119530.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:45484 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdKCE5D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Nov 2017 00:57:03 -0400
Received: by mail-ot0-f176.google.com with SMTP id q99so1512771ota.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 21:57:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709070119530.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, sage and other cephers.

Thanks for sharing your tech report:-), and so sorry for not
responding for so long. I was "offline" for the passed two months due
to some personal reasons, and I missed the passed two CDMs also.

I just made some modifications according to your advice, and discussed
the "original op journal" processing in some detail as responding to
Greg's question:-).
I don't know if the high level design in this document is sufficient
to accomplish the replication task, if it does, I can go on to make
modifications to the details of my original design and discuss with
you.

My document is at:
        https://drive.google.com/file/d/12BXq0I3FCetHehqHC8w_r1Dh2_RZjBUS/view?usp=sharing

Thanks:-)


On 7 September 2017 at 09:34, Sage Weil <sweil@redhat.com> wrote:
> Hi Xuehan,
>
> Thanks for presenting during CDM!  The final report I mentioned for the
> Red Hat / Harvey Mudd clinic that looked at the point-in-time consistency
> and time sync problem is at
>
>         http://newdream.net/~sage/RedHatFinalReport%2014-15.pdf
>
> If I understood correctly, this is essentially what you are proposing,
> except that the delay is done on the OSD instead of the client.  I think
> this improves a few things:
>
>  - fewer OSDs, fewer clocks to sync
>  - in most deployments, OSD to OSD latency will be lower
>  - clock error bound will be smaller
>  - fewer nodes whose clocks might jitter at the wrong time and invalidate
> the checkpoint
>
> Also, I *think* we can simply delay the OSD replies, preventing any causal
> link with a subsequent operation; new requests can still be
> processed, and hopefully the impact on overall workload will be
> very small.
>
> Does that simplify your approach or make it more complex?  I couldn't tell
> if there were other reasons or advantages to doing it on the client.
>
> Thanks!
> sage
