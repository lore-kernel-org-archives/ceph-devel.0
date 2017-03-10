From: John Spray <jspray@redhat.com>
Subject: Re: Interpreting ceph osd pool stats output
Date: Fri, 10 Mar 2017 09:55:22 +0000
Message-ID: <CALe9h7f7Mspny1fx2aMiXunS2C8GJrWFsp7YKdnmhu42+EVPmA@mail.gmail.com>
References: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38494 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933855AbdCJJzt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Mar 2017 04:55:49 -0500
Received: by mail-wm0-f54.google.com with SMTP id t189so6596420wmt.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Mar 2017 01:55:48 -0800 (PST)
In-Reply-To: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Cuzner <pcuzner@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

The reason they're different is that they originate from separate
internal counters:
 * The client_io_rate bits come from
https://github.com/ceph/ceph/blob/jewel/src/mon/PGMap.cc#L1212
 * The recovery bits come from
https://github.com/ceph/ceph/blob/jewel/src/mon/PGMap.cc#L1146

Not sure what you mean about bytes_sec vs objects_sec: client io and
recovery rate both have both objects and bytes counters.

The empty dicts are something that annoys me too, some of the output
functions have an if() right at the start that drops the output when
none of the deltas are nonzero.  I doubt anyone would have a big
problem with changing these to output the zeros rather than skipping
the fields.

BTW I'm not sure it's smart to merge these in practice: would result
in showing users a "your cluster is doing 10GB/s" statistics while
their workload is crawling because all that IO is really recovery.
Confusing.

John


On Fri, Mar 10, 2017 at 2:37 AM, Paul Cuzner <pcuzner@redhat.com> wrote:
> Hi,
>
> I've been putting together a collectd plugin for ceph - since the old
> one's I could find no longer work. I'm gathering data from the mon's
> admin socket, merged with a couple of commands I issue through the
> rados mon_command interface.
>
> Nothing complicated, but the data has me a little confused
>
> When I run "osd pool stats" I get *two* different sets of metrics that
> describe client i/o and recovery i/o. Since the metrics are different
> I can't merge them to get a consistent view of what the cluster is
> doing as a whole at any given point in time. For example, client i/o
> reports in bytes_sec, but the recovery dict is empty and the
> recovery_rate is in objects_sec...
>
> i.e.
>
> }, {
> "pool_name": "rados-bench-cbt",
> "pool_id": 86,
> "recovery": {},
> "recovery_rate": {
> "recovering_objects_per_sec": 3530,
> "recovering_bytes_per_sec": 14462655,
> "recovering_keys_per_sec": 0,
> "num_objects_recovered": 7148,
> "num_bytes_recovered": 29278208,
> "num_keys_recovered": 0
> },
> "client_io_rate": {}
>
> This is running Jewel - 10.2.5-37.el7cp
>
> Is this a bug or a 'feature' :)
>
> Cheers,
>
> Paul C
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
