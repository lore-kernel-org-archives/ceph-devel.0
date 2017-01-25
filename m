From: John Spray <jspray@redhat.com>
Subject: Re: osd_heartbeat_grace read by MON and OSD?
Date: Wed, 25 Jan 2017 11:37:52 +0000
Message-ID: <CALe9h7cFVCgoS-u62Y3DysdqA+Gg3tW8LmnX91TZ7S5T6XvA4A@mail.gmail.com>
References: <1359383871.8147.1485341465123@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:36009 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdAYLiO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2017 06:38:14 -0500
Received: by mail-ot0-f181.google.com with SMTP id 104so149617303otd.3
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jan 2017 03:38:13 -0800 (PST)
In-Reply-To: <1359383871.8147.1485341465123@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 25, 2017 at 10:51 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Looking at the code I see that the MON (mon/OSDMonitor.cc) and OSD (osd/OSD.cc) use the configuration setting osd_heartbeat_grace.
>
> The name *osd* suggest that it's only read by the OSDs, but according to the source it doesn't seem to be the case.
>
> bool OSDMonitor::check_failure(utime_t now, int target_osd, failure_info_t& fi)
> {
>   ...
>   utime_t orig_grace(g_conf->osd_heartbeat_grace, 0);
>   ...
> }
>
> bool OSDMonitor::prepare_failure(MonOpRequestRef op)
> {
>   ...
>   utime_t failed_since =
>     m->get_recv_stamp() -
>     utime_t(m->failed_for ? m->failed_for : g_conf->osd_heartbeat_grace, 0);
>   ...
> }
>
> Before I submit a PR to update the docs, am I reading the code correctly?

Yes -- we have a similar situation with mds_beacon_grace which is used
from both sides of the mon-mds code.  For now we have to live with the
fragility of needing these settings to be set uniformly across the
cluster to avoid issues (and in the long run we should be storing
config centrally).

John

>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
