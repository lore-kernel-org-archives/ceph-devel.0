From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: ack vs commit
Date: Thu, 3 Dec 2015 21:45:59 -0500 (EST)
Message-ID: <1863447583.28691006.1449197159388.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1512031641060.20799@cobra.newdream.net> <CAJ4mKGbwikMiRsYasu3Fg1RcrCq_5zKV8f1b4Qo5CCTANzjHNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:37421 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbbLDCp7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 21:45:59 -0500
In-Reply-To: <CAJ4mKGbwikMiRsYasu3Fg1RcrCq_5zKV8f1b4Qo5CCTANzjHNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm not really comfortable with the characterization of consistency in =
either position articulated here, in particular as applied to non-Ceph =
protocols such as NFS, AFS, and DCE (to take just the three DFS designs=
 I have most experience with).  For example, the NFS concept of write s=
tability really means write stability, it is not satisfied by ack.  Mea=
nwhile, the NFS "close-to-open" consistency model isn't materially help=
ed by ack (and has always seemed to me a perverse amalgam of POSIX and =
'randomly relaxed' behavior to make servers appear faster), which may b=
e similar to your opinion about NFS.

In the first instance, I have a longstanding interest in exploring alte=
rnative consistency models, but in particular, I am interested in fine-=
grained consistency selection under application control.  I'm fairly ce=
rtain that the current, fixed, ack vs. commit distinction is not a suff=
icient set of protocol primitives on which to build all interesting con=
sistency models I could think of.  (I'm not even certain that it is rea=
lly an orthogonal primitive wrt consistency, as above, and per Sage's r=
emarks wrt CephFS).  The current ack+commit system, in other words, see=
ms like not capable of satisfying the requirements for assembly of an a=
ttractive range of consistency models.  The ack state is apparently use=
ful for committing the participants to Ceph's current strong ordering g=
uarantees, while not assuring the client that operations are durable.

I apologize in advance for errors in fact or logic :).  (Also for top-p=
osting, I wasn't sure where to snip.)

Matt

----- Original Message -----
> From: "Gregory Farnum" <gfarnum@redhat.com>
> To: "Sage Weil" <sweil@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, December 3, 2015 8:39:04 PM
> Subject: Re: ack vs commit
>=20
> On Thu, Dec 3, 2015 at 4:54 PM, Sage Weil <sweil@redhat.com> wrote:
> > From the beginning Ceph has had two kinds of acks for rados write/u=
pdate
> > operations: ack (indicating the operation is accepted, serialized, =
and
> > staged in the osd's buffer cache) and commit (indicating the write =
is
> > durable).  The client, if it saw a failure on the OSD before gettin=
g the
> > commit, would have to resend the write to the new or recovered OSD,
> > attaching the version it got with the original ack so that the
> > new/recovered OSD could preserve the order.  (This is what the
> > replay_window pool property is for.)
> >
> > The only user for this functionality is CephFS, and only when a fil=
e is
> > opened for write or read/write by multiple clients.  When that happ=
ens,
> > the clients do all read/write operations synchronously with the OSD=
s, and
> > effectively things are ordered there, at the object.  The idea is/w=
as to
> > avoid penalizing this sort of IO by waiting for commits when the cl=
ients
> > aren't actually asking for that--at least until they call f[data]sy=
nc, at
> > which point the client will block and wait for the second commit re=
plies
> > to arrive.
> >
> > In practice, this doesn't actually help: everybody runs the OSDs on=
 XFS,
> > and FileStore has to do write-ahead journaling, which means that th=
ese
> > operations are committed and durable before they are readable, and =
the
> > clients only ever see 'commit' (and not 'ack' followed by 'commit')
> > (commit implies ack too).   If you run the OSD on btrfs, you might =
see
> > some acks (journaling and writes to the file system/page cache are =
done in
> > parallel).
> >
> > With newstore/bluestore, the current implementation doesn't make an=
y
> > attempt to make a write readable before it is durable.  This could =
be
> > changed, but.. I'm not sure it's worth it.  For most workloads (RBD=
, RGW)
> > we only care about making writes durable as quickly as possible, an=
d all
> > of the OSD optimization efforts are focusing on making this as fast=
 as
> > possible.  Is there much marginal benefit to the initial ack?  It's=
 only
> > the CephFS clients with the same file open from multiple hosts that=
 might
> > see a small benefit.
> >
> > On the other hand, there is a bunch of code in the OSD and on the
> > client side to deal with the dual-ack behavior we could potentially=
 drop.
> > Also, we are generating lots of extra messages on the backend netwo=
rk for
> > both ack and commit, even though the librados users don't usually c=
are
> > (the clients don't get the dual acks unless they request them).
> >
> > Also, it is arguably Wrong and a Bad Thing that you could have clie=
nt A
> > write to file F, client B reads from file F and sees that data, the=
 OSD
> > and client A both fail, and when things recover client B re-reads t=
he same
> > portion of the file and sees the file content from before client A'=
s
> > change.  The MDS is extremely careful about this on the metadata si=
de: no
> > side-effects of one client are visible to any other client until th=
ey are
> > durable, so that a combination MDS and client failure will never ma=
ke
> > things appear to go back in time.
> >
> > Any opinions here?  My inclination is to remove the functionality (=
less
> > code, less complexity, more sane semantics), but we'd be closing th=
e door
> > on what might have been a half-decent idea (separating serializatio=
n from
> > durability when multiple clients have the same file open for
> > read/write)...
>=20
> I've considered this briefly in the past, but I'd really rather we ke=
ep it:
>=20
> 1) While we don't make much use of it right now, I think it's a usefu=
l
> feature for raw RADOS users
>=20
> 2) It's an incredibly useful protocol semantic for future performance
> work of the sort that makes Sam start to cry, but which I find very
> interesting. Consider a future when RBD treats the OSDs more like a
> disk with a cache, and is able to send out operations to get them out
> of local memory, without forcing them instantly to permanent storage.
> Similarly, I think as soon as we have a backend that lets us use a bi=
t
> of 3D Crosspoint in a system, we'll wish we had this functionality
> again.
> (Likewise with CephFS, where many many users will have different
> consistency expectations thanks to NFS and other parallel FSes which
> really aren't consistent.)
>=20
> Maybe we just think it's not worth it and we'd rather throw this out.
> But the only complexity this really lets us drop is the OSD replay
> stuff (which realistically I can't assess) =E2=80=94 the dual acks is=
 not hard
> to work with, and doesn't get changed much anyway. If we drop this no=
w
> and decide to bring back any similar semantic in the future I think
> that'll be a lot harder than simply carrying it, both in terms of
> banging it back into the code, and especially in terms of getting it
> deployed to all the clients in the world again.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
