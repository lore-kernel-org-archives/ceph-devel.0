From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: does ceph consider the device performance for distributing data?
Date: Wed, 12 Sep 2012 15:15:18 -0500
Message-ID: <CAB7xdinvp83eeXK+dDS6WZWX=FvYhLLWv2=SBP+x+kDOMu2Bbg@mail.gmail.com>
References: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
	<CADvuQRHWuFRqAs7w4D+mXEC24e5Sc5hpG5eXWGPMfZvkZE9gYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50166 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab2ILUPT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 16:15:19 -0400
Received: by ieje11 with SMTP id e11so3625445iej.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 13:15:18 -0700 (PDT)
In-Reply-To: <CADvuQRHWuFRqAs7w4D+mXEC24e5Sc5hpG5eXWGPMfZvkZE9gYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

may i ask which part of codes within ceph deal with the distribution
of workloads among the OSDs? i am interested in ceph's source codes
and want to understand that part of codes.

Thanks,
Sheng

On Tue, Sep 11, 2012 at 11:51 AM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Sep 10, 2012 at 8:54 PM, sheng qiu <herbert1984106@gmail.com> wrote:
>> i have a simple question.
>> for distribution workload among OSDs, does ceph do any online modeling
>> for OSDs, i.e. collect the online IO latency and try to distribute
>> more workloads to lower latency OSDs? or only based on
>> capacity/utilization balance?
>
> I've heard this question now several times. Ceph does not contain the
> logic to adjust OSD weights based on such measurements. Ceph will
> collect some measurements that are useful for this ("perf counters",
> mostly).
>
> For a holistic systems view, the metrics Ceph collects aren't enough.
> You also want to take into account things like CPU load, available
> memory, hardware temperature sensors, network link utilization,
> network error rate, etc. And once you start looking at that angle, you
> realize that this is a completely generic "machine health" indicator,
> where Ceph is just one of the data sources.
>
> Hence, I view this as something that ultimately consumes more
> information than just Ceph. Ceph should play nice, and both feed
> information into such a system, and let the system set OSD weights;
> but I do believe it belongs outside of Ceph core.



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
