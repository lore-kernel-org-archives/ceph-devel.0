From: Sage Weil <sage@newdream.net>
Subject: Re: service ceph vs. /etc/init.d/ceph
Date: Thu, 8 Jul 2010 11:06:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007081103110.32514@cobra.newdream.net>
References: <i14p03$hn$5@dough.gmane.org> <1278602038.2253.24.camel@wido-laptop.pcextreme.nl>
 <i14qoh$hn$7@dough.gmane.org> <AANLkTik1943swfYSA5qyzFCxU_1_RhCQFcCx4sfh3_EJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-489112051-1278612193=:32514"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35438 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab0GHSEw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jul 2010 14:04:52 -0400
In-Reply-To: <AANLkTik1943swfYSA5qyzFCxU_1_RhCQFcCx4sfh3_EJ@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1007081103190.32514@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Miguel F Mascarenhas Sousa Filipe <miguel.filipe@gmail.com>
Cc: Thomas Mueller <thomas@chaschperli.ch>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-489112051-1278612193=:32514
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1007081103191.32514@cobra.newdream.net>

On Thu, 8 Jul 2010, Miguel F Mascarenhas Sousa Filipe wrote:
> Regarding this, I had a problem with installing ceph from source on a
> non-debian derived, nor redhat derived distro (it's mandriva derived).
> make install doesn't seem to install any init/startup script.

The init.d script isn't installed by 'make install' for any distro.  Nor=20
is the logrotate.d file, and probably some other stuff I'm forgetting. =20
Startup/shutdown and log rotation vary between distributions and 'make=20
install' doesn't bother to try to figure it out...

sage



>=20
>=20
>=20
> On Thu, Jul 8, 2010 at 4:27 PM, Thomas Mueller <thomas@chaschperli.ch> wr=
ote:
> > Am Thu, 08 Jul 2010 17:13:58 +0200 schrieb Wido den Hollander:
> >
> >> Hi Thomas,
> >>
> >> About Debian, your right, the service command is not installed by
> >> default.
> >>
> >> RHEL, CentOS and Ubuntu all support the "service" command, which makes
> >> the Wiki usefull for those three distributions.
> >>
> >> I'm not sure what Debian's plan is with the service command, they also
> >> might install it.
> >>
> >> As far as i know the service command is a part of the Linux Standard
> >> Base (LSB), so using that would be a good idea.
> >>
> >> I'll change back the Debian specific page.
> >>
> >
> > hmm.. ok you're right. after lenny (5.0) it's in sysvinit-utils which i=
s
> > installed an every machine.
> >
> >
> > - Thomas
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
>=20
>=20
>=20
> --=20
> Miguel Mascarenhas Filipe
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-489112051-1278612193=:32514--
