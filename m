From: Yanhu Cao <gmayyyha@gmail.com>
Subject: Re: [v2] ceph: use frag's MDS in either mode
Date: Mon, 3 Aug 2020 09:25:13 +0800
Message-ID: <CAB9OAC2x-jTELNSqbmbC-x=VsGmUdHPJQL__vBC8K9PAwW14Mw@mail.gmail.com>
References: <20200731082513.11806-1-gmayyyha@gmail.com> <8e87954aa5d04dd25330afd68b396ef40ff53398.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e87954aa5d04dd25330afd68b396ef40ff53398.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jul 31, 2020 at 7:57 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2020-07-31 at 16:25 +0800, Yanhu Cao wrote:
> > When doing some tests with multiple mds, there are many
> > mds forwarding requests between them and then the client request
> > is resent.
> >
> > If the request is a modification operation and the mode is set to USE_AUTH_MDS.
> > Auth mds should be selected to handle the request, and if auth mds for
> > frag is already set, it can be returned directly without the logic behind it.
> >
> > But the current logic doesn't return directly because the condition
> > 'mode == USE_AUTH_MDS', and sometimes frag's mds is not equal to
> > cap's session mds, which then causes the request to be resent.
> >
> > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > ---
> >  fs/ceph/mds_client.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
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
>
> Much better! A good changelog is as important as the patch, esp in code
> like this that is quite non-obvious.
>
> Merged into testing branch. I did clean up the changelog a bit before I
> merged it. Please take a look when you have time and let me know if you
> think I got it wrong.
LGTM.

Thanks.
>
> Thanks!
> --
> Jeff Layton <jlayton@kernel.org>
>
