From: Sage Weil <sage@newdream.net>
Subject: Re: Monitoring ceph and prometheus
Date: Fri, 12 May 2017 01:07:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705120105010.18953@piezo.novalocal>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop> <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com> <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal> <CAF-wwdH_wVpyG0322=_gvgfzoiqdaZ_Q4ULm5cwYjyqZNUvzoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1765453748-1494551241=:18953"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43218 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756670AbdELBHZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 21:07:25 -0400
In-Reply-To: <CAF-wwdH_wVpyG0322=_gvgfzoiqdaZ_Q4ULm5cwYjyqZNUvzoQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1765453748-1494551241=:18953
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 12 May 2017, Brad Hubbard wrote:
> On Thu, May 11, 2017 at 10:47 PM, Sage Weil <sage@newdream.net> wrote:
> > On Thu, 11 May 2017, John Spray wrote:
> >> On Thu, May 11, 2017 at 12:52 PM, Jan Fajerski <jfajerski@suse.com> wrote:
> >> > Hi list,
> >> > I recently looked into Ceph monitoring with prometheus. There is already a
> >> > ceph exporter for this purpose here
> >> > https://github.com/digitalocean/ceph_exporter.
> >> >
> >> > Prometheus encourages software projects to instrument their code directly
> >> > and expose this data, instead of using an external piece of code. Several
> >> > libraries are provided for this purpose:
> >> > https://prometheus.io/docs/instrumenting/clientlibs/
> >> >
> >> > I think there are arguments for adding this instrumentation to Ceph
> >> > directly.  Generally speaking it should reduce overall complexity in the
> >> > code (no extra exporter component outside of ceph) and in operations (no
> >> > extra package and configuration).
> >> >
> >> > The direct instrumentation could happen in two places:
> >> > 1)
> >> > Directly in Cephs C++ code using https://github.com/jupp0r/prometheus-cpp.
> >> > This would mean daemons expose their metrics directly via the prometheus
> >> > http interface. This would be the most direct way of exposing metrics,
> >> > prometheus would simply poll all endpoints. Service discovery for scrape
> >> > targets, say added or removed OSDS, would however have to be handled
> >> > somewhere. For orchestration tools à la k8s, ansible, salt, ... either have
> >> > this feature already or it would be simple enough to add. Deployments not
> >> > using a tool like that need another approach. Prometheus offer various
> >> > mechanisms
> >> > (https://prometheus.io/docs/operating/configuration/#%3Cscrape_config%3E) or
> >> > a ceph component (say mon or mgr) could handle this.
> >> >
> >> > 2)
> >> > Add a ceph-mgr plugin that exposes the metrics available to ceph-mgr as a
> >> > prometheus scrape target (using
> >> > https://github.com/prometheus/client_python).  This would handle the service
> >> > discovery issue for ceph daemons out of the box (though not for the actual
> >> > mgr-daemon which is the scrape target). The code would also be in a central
> >> > location instead of being scattered in several places. It does however add a
> >> > (maybe pointless) level of indirection ($ceph_daemon -> ceph-mgr ->
> >> > prometheus) and adds the need for two different scrape intervals (assuming
> >> > mgr polls metrics from daemons).
> >>
> >> I would love to see a mgr module for prometheus integration!
> >
> > Me too!  It might make more sense to do it in C++ than python, though, for
> > performance reasons.
> 
> Can we define "metrics" here? What, specifically, are we planning to gather?
> 
> Let's start with an example from "ceph_exporter". It exposes a metric
> ApplyLatency which it obtains by connecting to the cluster via a rados client
> connection and running the "osd perf" command and gathering the apply_latency_ms
> result. I believe this stat is the equivalent of the apply_latency perf counters
> statistic.
> 
> Does the manager currently export the performance counters? If not option 1 is
> looking more viable for gathering these sorts (think "perf dump") of
> metrics unless the manager can proxy calls such as "osd perf" back to the MONs?

Right now all of the perfcounters are reported to ceph-mgr.  We shouldn't 
need to do 'osd perf' (which is just reporting those 2 metrics that the 
osds have historically reported to the mon).
 
> Part of the problem with gathering metrics from ceph is working out what set of
> metrics you want to collect from a large assortment available IMHO.

We could collect them all. Or, we recently introduced a 'priority' field 
so we can collect everything above a threshold (although then we have to 
go assign meaningful priorities to most of the counters).

BTW one of the cool things about prometheus is that it has a histogram 
type, which means we can take our 2d histogram data and report that 
(flattened into one or the other dimension).

sage
--8323329-1765453748-1494551241=:18953--
