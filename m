From: Tommi Virtanen <tv@inktank.com>
Subject: Re: does ceph consider the device performance for distributing data?
Date: Tue, 11 Sep 2012 09:51:40 -0700
Message-ID: <CADvuQRHWuFRqAs7w4D+mXEC24e5Sc5hpG5eXWGPMfZvkZE9gYg@mail.gmail.com>
References: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42114 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792Ab2IKQwC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 12:52:02 -0400
Received: by vcbfy27 with SMTP id fy27so891657vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 09:52:01 -0700 (PDT)
In-Reply-To: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 10, 2012 at 8:54 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> i have a simple question.
> for distribution workload among OSDs, does ceph do any online modeling
> for OSDs, i.e. collect the online IO latency and try to distribute
> more workloads to lower latency OSDs? or only based on
> capacity/utilization balance?

I've heard this question now several times. Ceph does not contain the
logic to adjust OSD weights based on such measurements. Ceph will
collect some measurements that are useful for this ("perf counters",
mostly).

For a holistic systems view, the metrics Ceph collects aren't enough.
You also want to take into account things like CPU load, available
memory, hardware temperature sensors, network link utilization,
network error rate, etc. And once you start looking at that angle, you
realize that this is a completely generic "machine health" indicator,
where Ceph is just one of the data sources.

Hence, I view this as something that ultimately consumes more
information than just Ceph. Ceph should play nice, and both feed
information into such a system, and let the system set OSD weights;
but I do believe it belongs outside of Ceph core.
