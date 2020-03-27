From: Jeff Layton <jlayton@redhat.com>
Subject: Re: reducing s_mutex coverage in kcephfs client
Date: Fri, 27 Mar 2020 15:47:24 -0400
Message-ID: <f4931c8940e982bd0bf0d4f02ed11b6867ece2ca.camel@redhat.com>
References: <d6e7fca9b7276f36f828182faceea92bdc254fb1.camel@redhat.com>
         <CAAM7YAk3AhWv0KKWAqAh3zP9Lbj7f9RSDMVXZ2A_1W8M6mSOSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56400 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgC0Trb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:47:31 -0400
Received: by mail-qv1-f69.google.com with SMTP id v88so8625702qvv.6
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2020 12:47:26 -0700 (PDT)
In-Reply-To: <CAAM7YAk3AhWv0KKWAqAh3zP9Lbj7f9RSDMVXZ2A_1W8M6mSOSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, Sage Weil <sage@redhat.com>

On Fri, 2020-03-27 at 22:31 +0800, Yan, Zheng wrote:
> On Fri, Mar 27, 2020 at 12:58 AM Jeff Layton <jlayton@redhat.com> wrote:
> > I had mentioned this in standup this morning, but it's a bit of a
> > complex topic and Zheng asked me to send email instead. I'm also cc'ing
> > ceph-devel for posterity...
> > 
> > The locking in the cap handling code is extremely hairy, with many
> > places where we need to take sleeping locks while we're in atomic
> > context (under spinlock, mostly). A lot of the problem is due to the
> > need to take the session->s_mutex.
> > 
> > For instance, there's this in ceph_check_caps:
> > 
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 1999)              if (session && session != cap->session) {
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2000)                      dout("oops, wrong session %p mutex\n", session);
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2001)                      mutex_unlock(&session->s_mutex);
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2002)                      session = NULL;
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2003)              }
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2004)              if (!session) {
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2005)                      session = cap->session;
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2006)                      if (mutex_trylock(&session->s_mutex) == 0) {
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2007)                              dout("inverting session/ino locks on %p\n",
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2008)                                   session);
> > be655596b3de5 (Sage Weil           2011-11-30 09:47:09 -0800 2009)                              spin_unlock(&ci->i_ceph_lock);
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2010)                              if (took_snap_rwsem) {
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2011)                                      up_read(&mdsc->snap_rwsem);
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2012)                                      took_snap_rwsem = 0;
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2013)                              }
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2014)                              mutex_lock(&session->s_mutex);
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2015)                              goto retry;
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2016)                      }
> > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2017)              }
> > 
> > At this point, we're walking the inode's caps rbtree, while holding the
> > inode->i_ceph_lock. We're eventually going to need to send a cap message
> > to the MDS for this cap, but that requires the cap->session->s_mutex. We
> > try to take it without blocking first, but if that fails, we have to
> > unwind all of the locking and start over. Gross. That also makes the
> > handling of snap_rwsem much more complex than it really should be too.
> > 
> > It does this, despite the fact that the cap message doesn't actually
> > need much from the session (just the session->s_con, mostly). Most of
> > the info in the message comes from the inode and cap objects.
> > 
> > My question is: What is the s_mutex guaranteeing at this point?
> > 
> > More to the point, is it strictly required that we hold that mutex as we
> > marshal up the outgoing request? It would be much cleaner to be able to
> > just drop the spinlock after getting the ceph_msg_args ready to send,
> > then take the session mutex and send the request.
> > 
> > The state of the MDS session is not checked in this codepath before the
> > send, so it doesn't seem like ordering vs. session state messages is
> > very important. This _is_ ordered vs. regular MDS requests, but a
> > per-session mutex seems like a very heavyweight way to do that.
> > 
> > If we're concerned about reordering cap messages that involve the same
> > inode, then there are other ways to ensure that ordering that don't
> > require a coarse-grained mutex.
> > 
> > It's just not clear to me what data this mutex is protecting in this
> > case.
> 
> I think it's mainly for message ordering. For example,  a request may
> release multiple inodes' caps (by ceph_encode_inode_release).  Before
> sending the request out, we need to prevent ceph_check_caps() from
> touch these inodes' caps and sending cap messages.

I don't get it.

AFAICT, ceph_encode_inode_release is called while holding the
mdsc->mutex, not the s_mutex. That is serialized on the i_ceph_lock, but
I don't think there's any guarantee what order (e.g.) a racing cap
update and release would be sent.

--
Jeff Layton <jlayton@redhat.com>
