From: Martin Fick <mogulguy@yahoo.com>
Subject: Re: Replacing DRBD use with RBD
Date: Wed, 5 May 2010 13:34:08 -0700 (PDT)
Message-ID: <582033.76293.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36101.mail.mud.yahoo.com ([66.163.179.215]:20608 "HELO
	web36101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753302Ab0EEUeK convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 May 2010 16:34:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

--- On Wed, 5/5/10, Yehuda Sadeh Weinraub <yehudasa@gmail.com> wrote:
> The problem is that the ceph monitors require a quorum in
> order to decide on the cluster state. The way the system=20
> works right now, a 2-way monitor setup would be less stable=20
> than a system with a single monitor since it wouldn't work
> whenever any of the two monitors crashes.=20

Right, that is indeed not nice. :)

> A possible workaround would be to have a special case for a
> 2-way mon clusters, where it'd require a single mon for
> getting a majority. I'm not sure whether this is actually=20
> feasible. As usual, the devil is in the details.

Yes. One simple way is to use a ping node.=A0 If a node can
reach the ping node, but not its peer, it should be able
to assume "lone operation" and thus effectively degrade to
a single monitor situation temporarily. I guess my question
is, "is this something that the ceph project is=20
potentially willing to support for OSDs?"

I suspect that also supporting dynamic reconfiguration:
http://en.wikipedia.org/wiki/Paxos_algorithm#Cheap_Paxos
would also help a great deal to make clusters more
adaptable.


> > One suggestion I have would be to do this would be to
> > use some of the same techniques that heartbeat uses to
> > determine whether a node has gone down or if instead there
> > is network segregation: a serial port connection, common
> > ping nodes (such as a router)...

> There is a heartbeat mechanism withing the mon cluster, and
> it's being used for the monitors to keep track of their peer
> status. It might be a good idea to add different configurable=20
> types of heartbeats.

Yes, specifically, I meant by using some of the techniques
that the heartbeat project uses:

http://www.linux-ha.org/wiki/Heartbeat

Ideally (my suggestion,) they would make some of them=20
available in a library so that other projects like=20
RADOS could use them independently without having to=20
rewrite them from scratch.



> > 2) Is there any way of preventing two users of an RBD
> > device from using the device concurrently?=A0 ...
>=20
> We were just thinking about the proper solution to this
> problem ourselves. There are a few options. One is to=20
> add some kinds of locking mechanism to the osd, which
> would allow doing just that. E.g., a client would take=20
> a lock, do whatever it needs to do, a second client=20
> would try to get the lock but will be able to hold it only
> after the first one has released it. Another option would
> be to have the clients handle the mutual exclusion=20
> themselves (hence not enforced by the osd) by setting=20
> flags and leases on the rbd header.

I'm curious, do you mean a scheme such as writing the
name of the node "locking" the image along with a=20
timestamp regularly to the header as a heartbeat?=A0=20
Along with some lock acquisition logic?

Thanks for the replies!

-Martin



     =20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
