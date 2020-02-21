From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v8 5/5] ceph: add global metadata perf metric support
Date: Fri, 21 Feb 2020 15:56:41 +0100
Message-ID: <CAOi1vP92XUaOfQ_xJFZDXuH4r9D07fW6ckEyd2csr7EhUSRkpg@mail.gmail.com>
References: <20200221070556.18922-1-xiubli@redhat.com> <20200221070556.18922-6-xiubli@redhat.com>
 <68e496bca563ed6439c16f0de04d7daeb17f718a.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-il1-f194.google.com ([209.85.166.194]:36429 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgBUO4P (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2020 09:56:15 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so1851076iln.3
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2020 06:56:15 -0800 (PST)
In-Reply-To: <68e496bca563ed6439c16f0de04d7daeb17f718a.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Xiubo Li <xiubli@redhat.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 21, 2020 at 1:03 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2020-02-21 at 02:05 -0500, xiubli@redhat.com wrote:
> > From: Xiubo Li <xiubli@redhat.com>
> >
> > It will calculate the latency for the metedata requests, which only
> > include the time cousumed by network and the ceph.
> >
>
> "and the ceph MDS" ?
>
> > item          total       sum_lat(us)     avg_lat(us)
> > -----------------------------------------------------
> > metadata      113         220000          1946
> >
> > URL: https://tracker.ceph.com/issues/43215
> > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > ---
> >  fs/ceph/debugfs.c    |  6 ++++++
> >  fs/ceph/mds_client.c | 20 ++++++++++++++++++++
> >  fs/ceph/metric.h     | 13 +++++++++++++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > index 464bfbdb970d..60f3e307fca1 100644
> > --- a/fs/ceph/debugfs.c
> > +++ b/fs/ceph/debugfs.c
> > @@ -146,6 +146,12 @@ static int metric_show(struct seq_file *s, void *p)
> >       avg = total ? sum / total : 0;
> >       seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "write", total, sum, avg);
> >
> > +     total = percpu_counter_sum(&mdsc->metric.total_metadatas);
> > +     sum = percpu_counter_sum(&mdsc->metric.metadata_latency_sum);
> > +     sum = jiffies_to_usecs(sum);
> > +     avg = total ? sum / total : 0;
> > +     seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "metadata", total, sum, avg);
> > +
> >       seq_printf(s, "\n");
> >       seq_printf(s, "item          total           miss            hit\n");
> >       seq_printf(s, "-------------------------------------------------\n");
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 0a3447966b26..3e792eca6af7 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3017,6 +3017,12 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
> >
> >       /* kick calling process */
> >       complete_request(mdsc, req);
> > +
> > +     if (!result || result == -ENOENT) {
> > +             s64 latency = jiffies - req->r_started;
> > +
> > +             ceph_update_metadata_latency(&mdsc->metric, latency);
> > +     }
>
> Should we add an r_end_stamp field to the mds request struct and use
> that to calculate this? Many jiffies may have passed between the reply
> coming in and this point. If you really want to measure the latency that
> would be more accurate, I think.

Yes, capturing it after invoking the callback is inconsistent
with what is done for OSD requests (the new r_end_stamp is set in
finish_request()).

It looks like this is the only place where MDS r_end_stamp would be
needed, so perhaps just move this before complete_request() call?

Thanks,

                Ilya
