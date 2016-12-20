From: John Spray <jspray@redhat.com>
Subject: Re: Feeding pool utilization data to time series for trending
Date: Tue, 20 Dec 2016 10:22:16 +0000
Message-ID: <CALe9h7d7WfK2F1fiU-N7Oi7KUgf_frnucXtwRRndkgNV0Yh3ig@mail.gmail.com>
References: <0dafd5ff-1ed6-cb05-05d3-dff3afb43c44@redhat.com>
 <c0ef7893-2bd2-d11f-b008-db566145ce84@redhat.com> <aa72804e-767e-aaba-a2a8-e6df0e0a0536@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34035 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754012AbcLTKWi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 05:22:38 -0500
Received: by mail-qt0-f178.google.com with SMTP id n6so172577878qtd.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 02:22:37 -0800 (PST)
In-Reply-To: <aa72804e-767e-aaba-a2a8-e6df0e0a0536@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shubhendu Tripathi <shtripat@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 20, 2016 at 4:19 AM, Shubhendu Tripathi <shtripat@redhat.com> wrote:
> Hi Team,
>
> Our team is currently working on project named "tendrl" [1][2].
> Tendrl is a management platform for software defined storage system like
> Ceph, Gluster etc.
>
> As part of tendrl we are integrating with collectd to collect performance
> data and we maintain the time series data in graphite.
>
> I have a question at this juncture regarding pool utilization data.
> As our thought process goes, we think of using output from command "ceph df"
> and parse it to figure out pool utilization data and push it to graphite
> using collectd.

From Kraken onwards it's simpler to write a ceph-mgr module that sends
the data straight to your time series store -- mgr plugins have access
to in-memory copies of this stuff without having to do any polling.

If you need to be backwards compatible with Jewel, you can do what the
existing stats collector does:
https://github.com/ceph/Diamond/blob/calamari/src/collectors/ceph/ceph.py

Note that the existing collector sends commands to the mons using
librados: no need to literally wrap the command line.

> The question here is what is/would be performance impact of running "ceph
> df" command on ceph nodes. We should be running this command only on mon
> nodes I feel.

The Ceph command line connects to mons over the network -- you can run
it from wherever you like.  However, you only actually need to run it
from one place: it's redundant to collect the same data from multiple
nodes.  The existing stats collector runs on all mons, but decides
whether to collect the cluster-wide data (such as free space) based on
whether its local mon is the leader or not (see
_collect_cluster_stats).

This problem goes away with ceph-mgr because it takes care of
instantiating your plugin in just one place.

> Wanted to verify with the team here if this thought process is in right
> direction and if so what ideally should be frequency of running the command
> "ceph df" from collectd.

No more frequently than the data is collected internally from OSDs
(osd_mon_report_interval_min, which is 5 seconds by default).

John

> This is just from our point of view and we are open to any other foolproof
> solution (if any).
>
> Kindly guide us.
>
> Regards,
> Shubhendu Tripathi
>
> [1] http://tendrl.org/
> [2] https://github.com/tendrl/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
