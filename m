From: saumay agrawal <saumay.agrawal@gmail.com>
Subject: Fwd: Ideas on the UI/UX improvement of ceph-mgr: Cluster Status Dashboard
Date: Wed, 23 Aug 2017 11:48:17 +0530
Message-ID: <CA+b5B09RWXJ+XarVeNLV7+taEB_EFoT0R7FHn0_3qyTthfFnig@mail.gmail.com>
References: <CA+b5B08h7CALL-mC=O3PtFNhWeFQ113CVdEj-TNneZzy8TRVJg@mail.gmail.com>
 <CA+b5B08Sf5jbqN4HqjL_yg8jtAV0DU2KqRhKG2ZGGBPTe2ci+w@mail.gmail.com>
 <CAL6sUZZH7rte2eoD-9wec8r1qg0asyYTP9nTRHbDoTAszZV-Ww@mail.gmail.com> <CA+b5B0-sAVrdxy+apb01oKrm7WhrgxBo1xn7emD3_SYu6Gz+QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36699 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWGSi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 02:18:38 -0400
Received: by mail-io0-f173.google.com with SMTP id p141so4072293iop.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 23:18:38 -0700 (PDT)
In-Reply-To: <CA+b5B0-sAVrdxy+apb01oKrm7WhrgxBo1xn7emD3_SYu6Gz+QA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

---------- Forwarded message ----------
From: saumay agrawal <saumay.agrawal@gmail.com>
Date: Wed, Aug 23, 2017 at 11:35 AM
Subject: Re: Ideas on the UI/UX improvement of ceph-mgr: Cluster
Status Dashboard
To: nagarrajan raghunathan <nagu.raghu99@gmail.com>,
ceph-users@ceph.com, Ceph Development <ceph-devel@vger.kernel.org>


Hi Nagarrajan,

For graph prototypes you can point your browser to
localhost:41000/perf_graph_prototypes/{perf counter}. In place of perf
counter you can pass osd.op_latency, osd.loadavg, etc. You can find
more of the perf counters at localhost:41000/get_perf_schema/ under
the osd objects. You will be able to find the perf counter and its
description there. These graphs work for the perf counters which give
a time sequence of values.

Also you can view the summary of how these graphs work, and how to
access them, along with their sample snapshots, in the comments of PR
https://github.com/ceph/ceph/pull/16621.

Regards,
Saumay.

On Aug 22, 2017 11:57 PM, "nagarrajan raghunathan"
<nagu.raghu99@gmail.com> wrote:

Hi Saumay,
            Could you please tell how to use this tool. For example
say if i have ceph cluster running how do monitor using this tool. Any
guideline would be great.

On Tue, Aug 22, 2017 at 5:15 AM, saumay agrawal
<saumay.agrawal@gmail.com> wrote:
>
> Hi,
>
> As a part of my project, I have been working on the visualisation of
> the OSD performance on the dashboard. Based on the community feedback
> I realised that the visualisation of perf counter values against the
> first few stdevs was the most needed feature for performance graphs,
> along with the visualisation of minimum and maximum values.
>
> For this, I have created a generalised prototype page, which shows the
> prototypes of various graphs for a given performance counter. I also
> added a separate page to the dashboard, which visualises the read and
> write latency distribution of a ceph cluster.
>
> As of now, this is a PR at https://github.com/ceph/ceph/pull/16621.
> Any suggestions are welcome.
>
> Thanks,
> Saumay
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Regards,
Nagarrajan Raghunathan
