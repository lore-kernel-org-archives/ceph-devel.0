From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Monitoring ceph and prometheus
Date: Fri, 12 May 2017 11:03:27 +1000
Message-ID: <CAF-wwdH_wVpyG0322=_gvgfzoiqdaZ_Q4ULm5cwYjyqZNUvzoQ@mail.gmail.com>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
 <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com>
 <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34709 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757211AbdELBDj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 21:03:39 -0400
Received: by mail-pg0-f46.google.com with SMTP id u28so22373330pgn.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 May 2017 18:03:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



On Thu, May 11, 2017 at 10:47 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 11 May 2017, John Spray wrote:
>> On Thu, May 11, 2017 at 12:52 PM, Jan Fajerski <jfajerski@suse.com> wrote:
>> > Hi list,
>> > I recently looked into Ceph monitoring with prometheus. There is already a
>> > ceph exporter for this purpose here
>> > https://github.com/digitalocean/ceph_exporter.
>> >
>> > Prometheus encourages software projects to instrument their code directly
>> > and expose this data, instead of using an external piece of code. Several
>> > libraries are provided for this purpose:
>> > https://prometheus.io/docs/instrumenting/clientlibs/
>> >
>> > I think there are arguments for adding this instrumentation to Ceph
>> > directly.  Generally speaking it should reduce overall complexity in the
>> > code (no extra exporter component outside of ceph) and in operations (no
>> > extra package and configuration).
>> >
>> > The direct instrumentation could happen in two places:
>> > 1)
>> > Directly in Cephs C++ code using https://github.com/jupp0r/prometheus-cpp.
>> > This would mean daemons expose their metrics directly via the prometheus
>> > http interface. This would be the most direct way of exposing metrics,
>> > prometheus would simply poll all endpoints. Service discovery for scrape
>> > targets, say added or removed OSDS, would however have to be handled
>> > somewhere. For orchestration tools à la k8s, ansible, salt, ... either have
>> > this feature already or it would be simple enough to add. Deployments not
>> > using a tool like that need another approach. Prometheus offer various
>> > mechanisms
>> > (https://prometheus.io/docs/operating/configuration/#%3Cscrape_config%3E) or
>> > a ceph component (say mon or mgr) could handle this.
>> >
>> > 2)
>> > Add a ceph-mgr plugin that exposes the metrics available to ceph-mgr as a
>> > prometheus scrape target (using
>> > https://github.com/prometheus/client_python).  This would handle the service
>> > discovery issue for ceph daemons out of the box (though not for the actual
>> > mgr-daemon which is the scrape target). The code would also be in a central
>> > location instead of being scattered in several places. It does however add a
>> > (maybe pointless) level of indirection ($ceph_daemon -> ceph-mgr ->
>> > prometheus) and adds the need for two different scrape intervals (assuming
>> > mgr polls metrics from daemons).
>>
>> I would love to see a mgr module for prometheus integration!
>
> Me too!  It might make more sense to do it in C++ than python, though, for
> performance reasons.

Can we define "metrics" here? What, specifically, are we planning to gather?

Let's start with an example from "ceph_exporter". It exposes a metric
ApplyLatency which it obtains by connecting to the cluster via a rados client
connection and running the "osd perf" command and gathering the apply_latency_ms
result. I believe this stat is the equivalent of the apply_latency perf counters
statistic.

Does the manager currently export the performance counters? If not option 1 is
looking more viable for gathering these sorts (think "perf dump") of
metrics unless the manager can proxy calls such as "osd perf" back to the MONs?

Part of the problem with gathering metrics from ceph is working out what set of
metrics you want to collect from a large assortment available IMHO.

>
> sage



-- 
Cheers,
Brad
