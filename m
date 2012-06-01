From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 07/13] libceph: embed ceph connection structure in
 mon_client
Date: Fri, 1 Jun 2012 09:20:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206010918020.9007@cobra.newdream.net>
References: <4FC673FC.3060004@inktank.com> <4FC67662.2060005@inktank.com>
 <Pine.LNX.4.64.1205312108540.2166@cobra.newdream.net> <4FC8B19D.2080204@inktank.com>
 <4FC8C410.3080703@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42874 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964978Ab2FAQUK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 12:20:10 -0400
In-Reply-To: <4FC8C410.3080703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Fri, 1 Jun 2012, Alex Elder wrote:
> On 06/01/2012 07:12 AM, Alex Elder wrote:
> > On 05/31/2012 11:24 PM, Sage Weil wrote:
> > > On Wed, 30 May 2012, Alex Elder wrote:
> > > > A monitor client has a pointer to a ceph connection structure in it.
> > > > This is the only one of the three ceph client types that do it this
> > > > way; the OSD and MDS clients embed the connection into their main
> > > > structures. There is always exactly one ceph connection for a
> > > > monitor client, so there is no need to allocate it separate from the
> > > > monitor client structure.
> > > > 
> > > > So switch the ceph_mon_client structure to embed its
> > > > ceph_connection structure.
> > > > 
> > > > Signed-off-by: Alex Elder<elder@inktank.com>
> 
> . . .
> 
> > > > /* authentication */
> > > > monc->auth = ceph_auth_init(cl->options->name,
> > > > cl->options->key);
> > > > if (IS_ERR(monc->auth)) {
> > > > err = PTR_ERR(monc->auth);
> > > > - goto out_con;
> > > > + goto out_monmap;
> > > > }
> > > > monc->auth->want_keys =
> > > > CEPH_ENTITY_TYPE_AUTH | CEPH_ENTITY_TYPE_MON |
> > > > @@ -824,8 +821,6 @@ out_subscribe_ack:
> > > > ceph_msg_put(monc->m_subscribe_ack);
> > > > out_auth:
> > > > ceph_auth_destroy(monc->auth);
> > > > -out_con:
> > > > - monc->con->ops->put(monc->con);
> > > 
> > > AH!
> > > 
> > > This reminds me, these connections need to be refcounted. There's a
> > > ->get() and ->put() op defined so that you can refcount the containing
> > > structure. That means that this patch needs to alo change
> 
> Looking at this again.  Why do they need to be refcounted?  If
> this patch is correct in embedding the connection into the
> containing structure, then the last reference to the containing
> structure is coincident with with the last reference to the
> connection.  And the other connections are already embedded into
> other containing structures.
> 
> So--again assuming it's OK to embed the connection--I would rather
> see the ->get and ->put methods for the connection go away entirely
> and have the containing structure take care of its own damned ref
> counting...

The problem is that socket events queue work, which can take a while, and 
race with, say, osd_client getting an osdmap and dropping it's 
struct ceph_osd.  The ->get and ->put ops just twiddle the containing 
struct's refcount, in that case, so the con_work will find the (now 
closed) ceph_connection and do nothing...

> This actually gets into another thing I wanted to do anyway (while
> digging through raw memory trying to figure out what's going on).
> I want every ceph_message to point back to the connection it is
> associated with.  That way there's no need for the OSD (for example)
> to keep track of the connection--a revoke is simply an operation
> on the message, which would already know the connection from which
> it is being revoked.
> 
> If you think the above approach is good I'll gladly do it now
> rather than later.  I think it might eliminate the need for
> any need to reference count the connections.

That sounds reasonable.. but i'm pretty sure the con refcounts can't go 
away :)

sage


> 
> Anyway, when I'm done (if I ever finish!) the state of the connection
> will tell you whether any legitimate uses of a connection remain.
> 
> 					-Alex
> 
> > > static const struct ceph_connection_operations mon_con_ops = {
> > > .get = ceph_con_get,
> > > .put = ceph_con_put,
> > > 
> > > in mon_client.c. Hopefully the mon_client itself is refcounted, *or* we
> > > can ensure that it won't go away before the msgr workqueue is drained and
> > > the get/put ops can turn to no-ops.
> > 
> > 
> > Earlier I looked at the ref counting stuff a bit and stopped myself
> > from going off on that tangent. But it didn't look like it was used
> > consistently and made a note to myself to revisit it.
> > 
> > > Also: when poking around, I noticed that ceph_con_get() and put() are
> > > called directly from osd_client.c... that's a bug! Those connections have
> > > a get and put op defined that twiddles the containing ceph_osd struct's
> > > ref count.
> > > 
> > > I pushed several patches to your latest (wip-messenger-2) branch that fix
> > > these issues. Compile tested only! The first should probably be folded
> > > into this one, the others follow.
> > 
> > I'll look at your patches and incorporate them as appropriate. But at
> > the moment I don't see them; whenever you are back online again perhaps
> > you'll send me a link.
> > 
> > -Alex
> > 
> > > 
> > > > out_monmap:
> > > > kfree(monc->monmap);
> > > > out:
> > > > @@ -841,9 +836,7 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
> > > > mutex_lock(&monc->mutex);
> > > > __close_session(monc);
> > > > 
> > > > - monc->con->private = NULL;
> > > > - monc->con->ops->put(monc->con);
> > > > - monc->con = NULL;
> > > > + monc->con.private = NULL;
> > > > 
> > > > mutex_unlock(&monc->mutex);
> > > > 
> > > > @@ -1021,7 +1014,7 @@ static void mon_fault(struct ceph_connection *con)
> > > > if (!monc->hunting)
> > > > pr_info("mon%d %s session lost, "
> > > > "hunting for new mon\n", monc->cur_mon,
> > > > - ceph_pr_addr(&monc->con->peer_addr.in_addr));
> > > > + ceph_pr_addr(&monc->con.peer_addr.in_addr));
> > > > 
> > > > __close_session(monc);
> > > > if (!monc->hunting) {
> > > > --
> > > > 1.7.5.4
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > 
> > > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
