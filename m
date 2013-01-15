From: "Joshua J. Kugler" <joshua@azariah.com>
Subject: Re: CephFS issue
Date: Tue, 15 Jan 2013 00:35:11 -0900
Message-ID: <13344378.XMpKyabt7g@hosanna>
References: <CAEqYNSYaMvprh580HNosaQe7ahMmT-iB9irMsgA87tE2fwtCTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from buckelew.joyent.us ([72.2.114.101]:38047 "EHLO
	buckelew.joyent.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab3AOJmb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 04:42:31 -0500
In-Reply-To: <CAEqYNSYaMvprh580HNosaQe7ahMmT-iB9irMsgA87tE2fwtCTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexis =?ISO-8859-1?Q?G=DCNST?= HORN <alexis.gunsthorn@outscale.com>
Cc: ceph-devel@vger.kernel.org

On Monday, January 14, 2013 08:51:57 Alexis G=DCNST HORN wrote:
> At the end, the client mountpoint become unresponsive, and the only
> way is to force reboot.

I am going to throw this out there as I've seen something similar, but =
not=20
with ceph.  Back in 2005-ish I was experimenting with ATA over Ethernet=
=2E=20
Running bonnie++ against the targets or some such. During the tests, th=
ey=20
would just hang, and I couldn't kill the process, just had to reboot.

What it ended up being was the I/O (or bonnie++ ?) was using so much me=
mory=20
Linux wasn't allocating space for network buffers, killing network I/O.=
 Well,=20
since this was a network block file system, that was kind of crucial, a=
nd the=20
mount points would hang, and they wouldn't recover.

Again, I have no idea if this has anything to do with your issue, but t=
he=20
"lots of I/O followed by a hang requiring a reboot" rang bells...just m=
aybe=20
not the right ones. :)

j

--=20
Joshua J. Kugler - Fairbanks, Alaska
Azariah Enterprises - Programming and Website Design
joshua@azariah.com - Jabber: pedahzur@gmail.com
PGP Key: http://pgp.mit.edu/  ID 0x73B13B6A
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
