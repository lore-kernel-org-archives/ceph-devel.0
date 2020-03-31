From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [PATCH] ceph: request expedited service when flushing caps
Date: Tue, 31 Mar 2020 07:00:39 -0700
Message-ID: <CAJ4mKGbMgoQ6tgsiQchR2QirxOW_oPOuNo5X26YKpy66yHD+FA@mail.gmail.com>
References: <20200331105223.9610-1-jlayton@kernel.org> <CAAM7YAmzyYrREBtmX+JrEQMMuo9LhZ2J2c-PyahQaAiVVEn2fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44728 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730818AbgCaOBA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Mar 2020 10:01:00 -0400
Received: by mail-qt1-f198.google.com with SMTP id f7so18016471qtq.3
        for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2020 07:00:55 -0700 (PDT)
In-Reply-To: <CAAM7YAmzyYrREBtmX+JrEQMMuo9LhZ2J2c-PyahQaAiVVEn2fQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Jan Fajerski <jfajerski@suse.com>, "Yan, Zheng" <ukernel@gmail.com>

On Tue, Mar 31, 2020 at 6:49 AM Yan, Zheng <ukernel@gmail.com> wrote:
>
> On Tue, Mar 31, 2020 at 6:52 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > Jan noticed some long stalls when flushing caps using sync() after
> > doing small file creates. For instance, running this:
> >
> >     $ time for i in $(seq -w 11 30); do echo "Hello World" > hello-$i.txt; sync -f ./hello-$i.txt; done
> >
> > Could take more than 90s in some cases. The sync() will flush out caps,
> > but doesn't tell the MDS that it's waiting synchronously on the
> > replies.
> >
> > When ceph_check_caps finds that CHECK_CAPS_FLUSH is set, then set the
> > CEPH_CLIENT_CAPS_SYNC bit in the cap update request. This clues the MDS
> > into that fact and it can then expedite the reply.
> >
> > URL: https://tracker.ceph.com/issues/44744
> > Reported-and-Tested-by: Jan Fajerski <jfajerski@suse.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/caps.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 61808793e0c0..6403178f2376 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -2111,8 +2111,11 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
> >
> >                 mds = cap->mds;  /* remember mds, so we don't repeat */
> >
> > -               __prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE, 0, cap_used, want,
> > -                          retain, flushing, flush_tid, oldest_flush_tid);
> > +               __prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE,
> > +                          (flags & CHECK_CAPS_FLUSH) ?
> > +                           CEPH_CLIENT_CAPS_SYNC : 0,
> > +                          cap_used, want, retain, flushing, flush_tid,
> > +                          oldest_flush_tid);
> >                 spin_unlock(&ci->i_ceph_lock);
> >
>
> this is too expensive for syncfs case. mds needs to flush journal for
> each dirty inode.  we'd better to track dirty inodes by session, and
> only set the flag when flushing the last inode in session dirty list.

Yeah, see the userspace Client::_sync_fs() where we have an internal
flags argument which is set on the last cap in the dirty set and tells
the actual cap message flushing code to set FLAG_SYNC on the
MClientCaps message. I presume the kernel is operating on a similar
principle here?
-Greg


>
>
> >                 __send_cap(mdsc, &arg, ci);
> > --
> > 2.25.1
> >
>
