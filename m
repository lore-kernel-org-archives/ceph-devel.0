From: Yanhu Cao <gmayyyha@gmail.com>
Subject: Re: [v2] ceph: if we are blacklisted, __do_request returns directly
Date: Fri, 17 Apr 2020 19:03:02 +0800
Message-ID: <CAB9OAC3++ALF3RPt=S9m2+DS8t=1obM70OdL9Uar=qKj_BhqPA@mail.gmail.com>
References: <20200417093626.10892-1-gmayyyha@gmail.com> <faaf27530cafc9b00e81de58fb4ad153a1687622.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <faaf27530cafc9b00e81de58fb4ad153a1687622.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Yeah, patch the next commit.

On Fri, Apr 17, 2020 at 6:41 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2020-04-17 at 17:36 +0800, Yanhu Cao wrote:
> > If we mount cephfs by the recover_session option,
> > __do_request can return directly until the client automatically reconnects.
> >
> > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > ---
> >  fs/ceph/mds_client.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 486f91f9685b..e6cda256b136 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2708,6 +2708,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
> >
> >       put_request_session(req);
> >
> > +     if (mdsc->fsc->blacklisted &&
> > +         ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
> > +             err = -EACCES;
> > +             goto finish;
> > +     }
> > +
> >       mds = __choose_mds(mdsc, req, &random);
> >       if (mds < 0 ||
> >           ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {
>
> We do have an EBLACKLISTED error defined, which is the same as
> ESHUTDOWN. The read and write code can return that when the client is
> blacklisted. Same for cap handling (in __ceph_pool_perm_get. Should this
> return -EBLACKLISTED instead?
>
> --
> Jeff Layton <jlayton@kernel.org>
>
