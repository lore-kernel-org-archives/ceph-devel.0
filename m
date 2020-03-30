From: Jeff Layton <jlayton@redhat.com>
Subject: Re: reducing s_mutex coverage in kcephfs client
Date: Mon, 30 Mar 2020 14:59:24 -0400
Message-ID: <6ce0032223cf8a9e4e1693d4d7730b1525813bf1.camel@redhat.com>
References: <d6e7fca9b7276f36f828182faceea92bdc254fb1.camel@redhat.com>
         <CAAM7YAk3AhWv0KKWAqAh3zP9Lbj7f9RSDMVXZ2A_1W8M6mSOSA@mail.gmail.com>
         <f4931c8940e982bd0bf0d4f02ed11b6867ece2ca.camel@redhat.com>
         <CAAM7YA=VtkVoXDe8FUocw9zi0OMn1p6+sYa+EK-g7c77ndDCxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40221 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbgC3S7a (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:59:30 -0400
Received: by mail-qk1-f199.google.com with SMTP id h186so15861336qkc.22
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2020 11:59:26 -0700 (PDT)
In-Reply-To: <CAAM7YA=VtkVoXDe8FUocw9zi0OMn1p6+sYa+EK-g7c77ndDCxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, Sage Weil <sage@redhat.com>

On Sun, 2020-03-29 at 23:10 +0800, Yan, Zheng wrote:
> On Sat, Mar 28, 2020 at 3:47 AM Jeff Layton <jlayton@redhat.com> wrote:
> > On Fri, 2020-03-27 at 22:31 +0800, Yan, Zheng wrote:
> > > On Fri, Mar 27, 2020 at 12:58 AM Jeff Layton <jlayton@redhat.com> wrote:
> > > > I had mentioned this in standup this morning, but it's a bit of a
> > > > complex topic and Zheng asked me to send email instead. I'm also cc'ing
> > > > ceph-devel for posterity...
> > > > 
> > > > The locking in the cap handling code is extremely hairy, with many
> > > > places where we need to take sleeping locks while we're in atomic
> > > > context (under spinlock, mostly). A lot of the problem is due to the
> > > > need to take the session->s_mutex.
> > > > 
> > > > For instance, there's this in ceph_check_caps:
> > > > 
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 1999)              if (session && session != cap->session) {
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2000)                      dout("oops, wrong session %p mutex\n", session);
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2001)                      mutex_unlock(&session->s_mutex);
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2002)                      session = NULL;
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2003)              }
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2004)              if (!session) {
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2005)                      session = cap->session;
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2006)                      if (mutex_trylock(&session->s_mutex) == 0) {
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2007)                              dout("inverting session/ino locks on %p\n",
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2008)                                   session);
> > > > be655596b3de5 (Sage Weil           2011-11-30 09:47:09 -0800 2009)                              spin_unlock(&ci->i_ceph_lock);
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2010)                              if (took_snap_rwsem) {
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2011)                                      up_read(&mdsc->snap_rwsem);
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2012)                                      took_snap_rwsem = 0;
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2013)                              }
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2014)                              mutex_lock(&session->s_mutex);
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2015)                              goto retry;
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2016)                      }
> > > > a8599bd821d08 (Sage Weil           2009-10-06 11:31:12 -0700 2017)              }
> > > > 
> > > > At this point, we're walking the inode's caps rbtree, while holding the
> > > > inode->i_ceph_lock. We're eventually going to need to send a cap message
> > > > to the MDS for this cap, but that requires the cap->session->s_mutex. We
> > > > try to take it without blocking first, but if that fails, we have to
> > > > unwind all of the locking and start over. Gross. That also makes the
> > > > handling of snap_rwsem much more complex than it really should be too.
> > > > 
> > > > It does this, despite the fact that the cap message doesn't actually
> > > > need much from the session (just the session->s_con, mostly). Most of
> > > > the info in the message comes from the inode and cap objects.
> > > > 
> > > > My question is: What is the s_mutex guaranteeing at this point?
> > > > 
> > > > More to the point, is it strictly required that we hold that mutex as we
> > > > marshal up the outgoing request? It would be much cleaner to be able to
> > > > just drop the spinlock after getting the ceph_msg_args ready to send,
> > > > then take the session mutex and send the request.
> > > > 
> > > > The state of the MDS session is not checked in this codepath before the
> > > > send, so it doesn't seem like ordering vs. session state messages is
> > > > very important. This _is_ ordered vs. regular MDS requests, but a
> > > > per-session mutex seems like a very heavyweight way to do that.
> > > > 
> > > > If we're concerned about reordering cap messages that involve the same
> > > > inode, then there are other ways to ensure that ordering that don't
> > > > require a coarse-grained mutex.
> > > > 
> > > > It's just not clear to me what data this mutex is protecting in this
> > > > case.
> > > 
> > > I think it's mainly for message ordering. For example,  a request may
> > > release multiple inodes' caps (by ceph_encode_inode_release).  Before
> > > sending the request out, we need to prevent ceph_check_caps() from
> > > touch these inodes' caps and sending cap messages.
> > 
> > I don't get it.
> > 
> > AFAICT, ceph_encode_inode_release is called while holding the
> > mdsc->mutex, not the s_mutex. That is serialized on the i_ceph_lock, but
> > I don't think there's any guarantee what order (e.g.) a racing cap
> > update and release would be sent.
> > 
> 
> You are right. cap messages can be slight out-of-order in above case.
> 

Thanks for confirming it.

> I checked the code again.  I think s_mutex is mainly for:
> 
> - cap message senders use s_mutex to ensure session does not get
> closed by CEPH_SESSION_CLOSE. For example __mark_caps_flushing() may
> race with remove_session_caps()

Ok, we should definitely try to prevent that race.

> - some functions such as ceph_iterate_session_caps are not reentrant.
> s_mutex is used for protecting these functions.

Good point. I'll have a look at that.

> - send_mds_reconnect() use s_mutex to prevent other threads from
> modifying cap states while it composing the reconnect message.
> 

Ok. I think we can reduce the coverage of the s_mutex somewhat, and
leave it in place for some of the more rare, heavyweight operations.

I think at this point, I realize that most of the cap message setup can
(and probably should) be done under the i_ceph_lock. It's only the
sending of the message the seems to require the s_mutex....which is a
shame, because the con has its own mutex, which could also be used to
ensure ordering.

Ideally, the queueing of outgoing messages to not require a mutex at
all, so we could queue them up under atomic context. That would do a lot
to simplify the cap handling, and it would probably be a lot more
efficient to boot.

It also stands out to me that most if not all of the operations under
ceph_con_send won't block. It doesn't seem like queueing up a message
and kicking the workqueue ought to require a mutex.
-- 
Jeff Layton <jlayton@redhat.com>
