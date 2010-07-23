From: Anton <anton.vazir@gmail.com>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs forever
Date: Fri, 23 Jul 2010 16:43:37 +0500
Message-ID: <201007231643.37780.anton.vazir@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.eastera.tj ([62.122.137.85]:44129 "EHLO mail.eastera.tj"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758730Ab0GWLvq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 23 Jul 2010 07:51:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-1?q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: ceph-devel@vger.kernel.org

Did you try an umount -l (lasy umount) - should just=20
disconnect the fs - as I experienced with other network FS -=20
like NFS or Gluster - you may always have difficulties with=20
any of them - so "-l" helps me. Not sure for CEPH though.

On Friday 23 July 2010, S=E9bastien Paolacci wrote:
> Hello Sage,
>=20
> I would like to emphasize that this issue is somewhat
> annoying, even for experiment purpose: I definitely
> expect my test server to not behave safely, crash, burn
> or whatever, but having a client side impact as deep as
> needed a (hard) reboot to solved a hanged ceph really
> prevent me from testing with real life payloads.
>=20
> I understand that it's not an easy point but a lot of my
> colleagues are not really whiling to sacrifice even
> their dev workstation to play during spare time... sad
> world ;)
>=20
> Sebastien
>=20
> On Wed, 16 Jun 2010, Peter Niemayer wrote:
> > Hi,
> >=20
> > trying to "umount" a formerly mounted ceph filesystem
> > that has become unavailable (osd crashed, then msd/mon
> > were shut down using /etc/init.d/ceph stop) results in
> > "umount" hanging forever in
> > "D" state.
> >=20
> > Strangely, "umount -f" started from another terminal
> > reports the ceph filesystem as not being mounted
> > anymore, which is consistent with what the mount-table
> > says.
> >=20
> > The kernel keeps emitting the following messages from=20
time to time:
> > > Jun 16 17:25:29 gitega kernel: ceph:  tid 211912
> > > timed out on osd0, will reset osd
> > > Jun 16 17:25:35 gitega kernel: ceph: mon0
> > > 10.166.166.1:6789 connection failed
> > > Jun 16 17:26:15 gitega last message repeated 4 times
> >=20
> > I would have expected the "umount" to terminate at
> > least after some generous timeout.
> >=20
> > Ceph should probably support something like the
> > "soft,intr" options of NFS, because if the only
> > supported way of mounting is one where a client is
> > more or less stuck-until-reboot when the service
> > fails, many potential test-configurations involving
> > Ceph are way too dangerous to try...
>=20
> Yeah, being able to force it to shut down when servers
> are unresponsive is definitely the intent.  'umount -f'
> should work.  It sounds like the problem is related to
> the initial 'umount' (which doesn't time out) followed
> by 'umount -f'.
>=20
> I'm hesitant to add a blanket umount timeout, as that
> could prevent proper writeout of cached data/metadata in
> some cases.  So I think the goal should be that if a
> normal umount hangs for some reason, you should be able
> to intervene to add the 'force' if things don't go well.
>=20
> sage
> --
> --
> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at=20
> http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
