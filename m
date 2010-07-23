From: Sage Weil <sage@newdream.net>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs
 forever
Date: Fri, 23 Jul 2010 09:56:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007230947130.6095@cobra.newdream.net>
References: <AANLkTi=EgtWA6+jGODrsVreODwFgDrKkfWcrnL15_K32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1603976609-1279904171=:6095"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36102 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab0GWQxx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jul 2010 12:53:53 -0400
In-Reply-To: <AANLkTi=EgtWA6+jGODrsVreODwFgDrKkfWcrnL15_K32@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1603976609-1279904171=:6095
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Jul 2010, S=E9bastien Paolacci wrote:
> Hello Sage,
>=20
> I would like to emphasize that this issue is somewhat annoying, even
> for experiment purpose: I definitely expect my test server to not
> behave safely, crash, burn or whatever, but having a client side
> impact as deep as needed a (hard) reboot to solved a hanged ceph
> really prevent me from testing with real life payloads.

Maybe you can clarify for me exactly where the problem is.  'umount -f'=20
should work.  'umount -l' should do a lazy unmount (detach from=20
namespace), but the actual unmount code may currently hang.  It's=20
debateable how that can/should be solved, since it's the 'sync' stage that=
=20
hangs, and it's not clear we should ever 'give up' on that without an=20
administrator telling us to (*).

What problem do you actually see, though?  Why does it matter, or why do=20
you care, if the 'umount -l' leaves some kernel threads trying to umount? =
=20
Is it just annoying because it Shouldn't Do That, or does it actually=20
cause a problem for you?

It may be that if you try to remount the same fs, the old superblock gets=
=20
reused, and the mount fails somehow... I haven't tried that.  That would=20
be an easy fix, though.

Any clarification would be helpful!  Thanks-
sage


* Maybe a hook like /sys/kernel/debug/ceph/.../abort_sync that you can=20
echo 1 to would be sufficient to make it give up on a sync (in the umount=
=20
-l case, the sync prior to the actual unmount).


>=20
> I understand that it's not an easy point but a lot of my colleagues
> are not really whiling to sacrifice even their dev workstation to play
> during spare time... sad world ;)
>=20
> Sebastien
>=20
> On Wed, 16 Jun 2010, Peter Niemayer wrote:
> > Hi,
> >
> > trying to "umount" a formerly mounted ceph filesystem that has become
> > unavailable (osd crashed, then msd/mon were shut down using /etc/init.d=
/ceph
> > stop) results in "umount" hanging forever in
> > "D" state.
> >
> > Strangely, "umount -f" started from another terminal reports
> > the ceph filesystem as not being mounted anymore, which is consistent
> > with what the mount-table says.
> >
> > The kernel keeps emitting the following messages from time to time:
> > > Jun 16 17:25:29 gitega kernel: ceph:  tid 211912 timed out on osd0, w=
ill
> > > reset osd
> > > Jun 16 17:25:35 gitega kernel: ceph: mon0 10.166.166.1:6789 connectio=
n
> > > failed
> > > Jun 16 17:26:15 gitega last message repeated 4 times
> >
> > I would have expected the "umount" to terminate at least after some gen=
erous
> > timeout.
> >
> > Ceph should probably support something like the "soft,intr" options
> > of NFS, because if the only supported way of mounting is one where
> > a client is more or less stuck-until-reboot when the service fails,
> > many potential test-configurations involving Ceph are way too dangerous
> > to try...
>=20
> Yeah, being able to force it to shut down when servers are unresponsive i=
s
> definitely the intent.  'umount -f' should work.  It sounds like the
> problem is related to the initial 'umount' (which doesn't time out)
> followed by 'umount -f'.
>=20
> I'm hesitant to add a blanket umount timeout, as that could prevent prope=
r
> writeout of cached data/metadata in some cases.  So I think the goal
> should be that if a normal umount hangs for some reason, you should be
> able to intervene to add the 'force' if things don't go well.
>=20
> sage
> --
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1603976609-1279904171=:6095--
