From: Wido den Hollander <wido@42on.com>
Subject: Re: osd_heartbeat_grace read by MON and OSD?
Date: Wed, 25 Jan 2017 13:13:52 +0100 (CET)
Message-ID: <506114243.8156.1485346432725@ox.pcextreme.nl>
References: <1359383871.8147.1485341465123@ox.pcextreme.nl>
 <CALe9h7cFVCgoS-u62Y3DysdqA+Gg3tW8LmnX91TZ7S5T6XvA4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:53303 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdAYMOA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2017 07:14:00 -0500
In-Reply-To: <CALe9h7cFVCgoS-u62Y3DysdqA+Gg3tW8LmnX91TZ7S5T6XvA4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 25 januari 2017 om 12:37 schreef John Spray <jspray@redhat.com>:
> 
> 
> On Wed, Jan 25, 2017 at 10:51 AM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > Looking at the code I see that the MON (mon/OSDMonitor.cc) and OSD (osd/OSD.cc) use the configuration setting osd_heartbeat_grace.
> >
> > The name *osd* suggest that it's only read by the OSDs, but according to the source it doesn't seem to be the case.
> >
> > bool OSDMonitor::check_failure(utime_t now, int target_osd, failure_info_t& fi)
> > {
> >   ...
> >   utime_t orig_grace(g_conf->osd_heartbeat_grace, 0);
> >   ...
> > }
> >
> > bool OSDMonitor::prepare_failure(MonOpRequestRef op)
> > {
> >   ...
> >   utime_t failed_since =
> >     m->get_recv_stamp() -
> >     utime_t(m->failed_for ? m->failed_for : g_conf->osd_heartbeat_grace, 0);
> >   ...
> > }
> >
> > Before I submit a PR to update the docs, am I reading the code correctly?
> 
> Yes -- we have a similar situation with mds_beacon_grace which is used
> from both sides of the mon-mds code.  For now we have to live with the
> fragility of needing these settings to be set uniformly across the
> cluster to avoid issues (and in the long run we should be storing
> config centrally).
> 

Thank you for the quick answer!

Submitted a PR for this: https://github.com/ceph/ceph/pull/13098

Wido

> John
> 
> >
> > Wido
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
