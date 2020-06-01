From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 2/5] libceph: decode CRUSH device/bucket types and names
Date: Mon, 1 Jun 2020 13:14:15 +0200
Message-ID: <CAOi1vP8aKTGi10K0jz-PUBtTiHMS453DANhfZSLPg4vVKndceQ@mail.gmail.com>
References: <20200530153439.31312-1-idryomov@gmail.com> <20200530153439.31312-3-idryomov@gmail.com>
 <ce644470a74c0d7865ea92cdf29c13dbe609fca9.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgFALOK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2020 07:14:10 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3694C061A0E
        for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2020 04:14:10 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 18so8935590iln.9
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2020 04:14:10 -0700 (PDT)
In-Reply-To: <ce644470a74c0d7865ea92cdf29c13dbe609fca9.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 1, 2020 at 12:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sat, 2020-05-30 at 17:34 +0200, Ilya Dryomov wrote:
> > These would be matched with the provided client location to calculate
> > the locality value.
> >
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  include/linux/crush/crush.h |  6 +++
> >  net/ceph/crush/crush.c      |  3 ++
> >  net/ceph/osdmap.c           | 85 ++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 92 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
> > index 38b0e4d50ed9..29b0de2e202b 100644
> > --- a/include/linux/crush/crush.h
> > +++ b/include/linux/crush/crush.h
> > @@ -301,6 +301,12 @@ struct crush_map {
> >
> >       __u32 *choose_tries;
> >  #else
> > +     /* device/bucket type id -> type name (CrushWrapper::type_map) */
> > +     struct rb_root type_names;
> > +
> > +     /* device/bucket id -> name (CrushWrapper::name_map) */
> > +     struct rb_root names;
> > +
>
> I'm not as familiar with the OSD client-side code, but I don't see any
> mention of locking here. What protects these new rbtrees? From reading
> over the code, I'd assume the osdc->lock, but it might be nice to have a
> comment here that makes that clear.

Yes, everything osdmap and CRUSH (except for the actual invocation) is
protected by osdc->lock.  But these trees don't even need that -- they
are static and could be easily replaced with sorted arrays to save two
pointers per name.

Thanks,

                Ilya
