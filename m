From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 7/9] ceph: close old con before reopening on mds
 reconnect
Date: Mon, 30 Jul 2012 16:11:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207301611010.31602@cobra.newdream.net>
References: <1342831308-18815-1-git-send-email-sage@inktank.com> <1342831308-18815-8-git-send-email-sage@inktank.com> <CAC-hyiHfbYof7mXjLOFh=QDBYDmSHfEeoBMaic0SKUkzjmzkhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48538 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab2G3XLH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:11:07 -0400
In-Reply-To: <CAC-hyiHfbYof7mXjLOFh=QDBYDmSHfEeoBMaic0SKUkzjmzkhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 24 Jul 2012, Yehuda Sadeh wrote:
> On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> > When we detect a mds session reset, close the old ceph_connection before
> > reopening it.  This ensures we clean up the old socket properly and keep
> > the ceph_connection state correct.
> >
> > Signed-off-by: Sage Weil <sage@inktank.com>
> > ---
> >  fs/ceph/mds_client.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 39b76d6..a5a7354 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2518,6 +2518,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
> >         session->s_state = CEPH_MDS_SESSION_RECONNECTING;
> >         session->s_seq = 0;
> >
> > +       ceph_con_close(&session->s_con);
> >         ceph_con_open(&session->s_con,
> 
> Should we also BUG_ON in ceph_con_open if connection is not closed?

Yeah, adding that.

> 
> >                       CEPH_ENTITY_TYPE_MDS, mds,
> >                       ceph_mdsmap_get_addr(mdsc->mdsmap, mds));
> > --
> > 1.7.9
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
