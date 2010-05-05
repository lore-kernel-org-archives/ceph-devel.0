From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Replacing DRBD use with RBD
Date: Wed, 5 May 2010 13:00:38 -0700
Message-ID: <n2ua37615151005051300h955afea6tc515d48be0d1bb9d@mail.gmail.com>
References: <801672.55708.qm@web36106.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63471 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552Ab0EEUAj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 May 2010 16:00:39 -0400
Received: by vws12 with SMTP id 12so1334342vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 May 2010 13:00:38 -0700 (PDT)
In-Reply-To: <801672.55708.qm@web36106.mail.mud.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Fick <mogulguy@yahoo.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 4, 2010 at 4:46 PM, Martin Fick <mogulguy@yahoo.com> wrote:
> Hello,

Hi!

>
> I have a questions with respect to RADOS and RBD and the cluster moni=
tor daemons.
>
> 1) Is there any chance that the cluster monitor protocol will be enha=
nced to work practically with only 2 monitor daemons?=A0 I ask since th=
is seems like it would allow a 2 node RBD based device to effectively r=
eplace a DRBD based device and yet be much more easily expandable to mo=
re nodes than DRBD.=A0 Many HA systems (say telco racks) only have two =
nodes and it seems silly to miss out on the opportunity to be able to u=
se RBD in those systems.

The problem is that the ceph monitors require a quorum in order to
decide on the cluster state. The way the system works right now, a
2-way monitor setup would be less stable than a system with a single
monitor since it wouldn't work whenever any of the two monitors
crashes. A possible workaround would be to have a special case for a
2-way mon clusters, where it'd require a single mon for getting a
majority. I'm not sure whether this is actually feasible. As usual,
the devil is in the details.

>
> One suggestion I have would be to do this would be to use some of the=
 same techniques that heartbeat uses to determine whether a node has go=
ne down or if instead there is network segregation: a serial port conne=
ction, common ping nodes (such as a router)...
There is a heartbeat mechanism withing the mon cluster, and it's being
used for the monitors to keep track of their peer status. It might be
a good idea to add different configurable types of heartbeats.

>
> I suspect that if reliable 2 node operation were designed into RBD, i=
t would eventually replace some of the uses of DRBD.
>
>
> 2) Is there any way of preventing two users of an RBD device from usi=
ng the device concurrently?=A0 Is there someway to create "locks" with =
RADOS that would die if a node dies?=A0 If so, this would allow an RBD =
device to be safely mounted as a non distributed FS such as ext3 exclus=
ively on one of many hosts.=A0 This would open up the use of RBD device=
s for linux containers or linux vservers which could run on any machine=
 in a cluster (similar to the idea of using it with kvm/qemu).

We were just thinking about the proper solution to this problem
ourselves. There are a few options. One is to add some kinds of
locking mechanism to the osd, which would allow doing just that. E.g.,
a client would take a lock, do whatever it needs to do, a second
client would try to get the lock but will be able to hold it only
after the first one has released it. Another option would be to have
the clients handle the mutual exclusion themselves (hence not enforced
by the osd) by setting flags and leases on the rbd header. There are
other options, but the latter would be much easier to implement and
we'll start from there.

>
> Thanks, I look forward to playing with RBD and ceph!
>

Thank you!

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
