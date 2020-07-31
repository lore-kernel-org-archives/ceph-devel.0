From: Yanhu Cao <gmayyyha@gmail.com>
Subject: Re: [PATCH] ceph: use frag's MDS in either mode
Date: Fri, 31 Jul 2020 10:38:11 +0800
Message-ID: <CAB9OAC0-6o73af7xjYpGHyT-BS+BNda6jRFvkgDm7S06uH1i8A@mail.gmail.com>
References: <20200730112242.31648-1-gmayyyha@gmail.com> <e9c69117a1ce870c2a96565d2a2d64d066a6604f.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgGaCiY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2020 22:38:24 -0400
In-Reply-To: <e9c69117a1ce870c2a96565d2a2d64d066a6604f.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Jul 31, 2020 at 12:46 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2020-07-30 at 19:22 +0800, Yanhu Cao wrote:
> > if frag.mds != cap->session->s_mds, the client's req will be resent.
> >
> > e.g.
> >
> > file: mnt/cephfs/dir03/dir003 (0x10000000003)
> > ceph.dir.pin="1"
> >
> > echo 'aaa' > /mnt/cephfs/dir03/dir003/file29
> >
> > kernel: ceph:  __choose_mds 00000000ca362c7a is_hash=1 (0x7c768b89) mode 2
> > kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe frag 0 mds1 (auth)
> > kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe mds0 (auth cap 00000000679c38e2)
> > kernel: ceph:  __choose_mds using resend_mds mds1
> >
> > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > ---
> >  fs/ceph/mds_client.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
>
> I think you're right that there is a bug here, but this patch
> description is not terribly descriptive. Can you explain the problem and
> solution a bit better?

Sorry, just describing the steps to reproduce it.

The problem is when doing some tests with multiple mds, there are many
mds forwarding requests between them
and then the client request is resent. So I analyze how the client
chooses the target mds to send the request.

If the request is a modification operation and the mode is set to USE_AUTH_MDS.
Auth mds should be selected to handle the request, and if auth mds for
frag is already set, it can be returned directly without the logic
behind it.
But the current logic doesn't return directly because the condition
'mode == USE_AUTH_MDS',
and sometimes frag's mds is not equal to cap's session mds, which then
causes the request to be resent.


I'll resubmit PR.

Thanks.

>
> A good patch description should walk me through the problem and your
> reasoning to fix it. Why is this wrong now, and how does your change
> address it?
>
> Thanks,
> Jeff
>
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index a50497142e59..b2255a9be7c0 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -1103,8 +1103,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> >                                    frag.frag, mds);
> >                               if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
> >                                   CEPH_MDS_STATE_ACTIVE) {
> > -                                     if (mode == USE_ANY_MDS &&
> > -                                         !ceph_mdsmap_is_laggy(mdsc->mdsmap,
> > +                                     if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
> >                                                                 mds))
> >                                               goto out;
> >                               }
>
> --
> Jeff Layton <jlayton@kernel.org>
>
