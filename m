From: Martin Fick <mogulguy@yahoo.com>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 14:41:59 -0700 (PDT)
Message-ID: <784866.39317.qm@web36101.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.1005061430230.18563@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36101.mail.mud.yahoo.com ([66.163.179.215]:48840 "HELO
	web36101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752325Ab0EFVmB convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 17:42:01 -0400
In-Reply-To: <Pine.LNX.4.64.1005061430230.18563@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

--- On Thu, 5/6/10, Sage Weil <sage@newdream.net> wrote:
> On Thu, 6 May 2010, Cl=E1udio Martins
> wrote:
> > On Thu, 6 May 2010 14:02:40 -0700 (PDT) Martin Fick
> <mogulguy@yahoo.com>
> wrote:
> > > To put this in the perspective of OSD setups, if you=20
> > > already have stripping, using the replicas also may=20
> > > not make much of a difference, but I wonder how a two
> > > node OSD setup with double redundancy would fair?=A0=20
> > > With such a setup there will not really be any=20
> > > stripping will there?=A0 With such a setup (one that I=20
> > > can easily see being popular for simple/minimal RBD
> > > redundancy setups), perhaps replica "stripping"
> > > would help.=A0 A 'smart' RBD could detect non
> > > contiguous reads and spread the reads out in that
> > > case.
> >=20
> >=A0 Unless I understood wrongly the Ceph papers, the
> > current situation is not that bad.
> >=20
> >=A0 IIRC, a big file will be stripped over many
> > different objects. Each object ID will map to=20
> > its own primary replica, which will be vary from
> > object to object. Thus, given many clients reading
> > different chunks of that file, even 2 OSDs should
> > see a fairly equal amount of traffic. The same=20
> > should be true for small files. Unless you have
> > lots of clients all reading the same file.
>=20
> Yeah, you've got it right.=A0 The rbd image is striped
> over small objects, which are independently assigned=20
> to OSDs.=A0 The load should be very well distributed.


How can that be on a 2 OSD setup with double redundancy?
In this case, if all of a replicas smaller objects are
not on a single node, how will it recover from an OSD=20
failure? =20

The only way I see this possible is if file foo is=20
split into small objects A1 A2 A3 A4 and replicas B1=20
B2 B3 B4 and you spread those across 2 OSDs like this:

replica 1 (A1 B2 A3 B4)
replica 2 (B1 A2 B3 A4)

but then A1 has to know that it is the same as B1.  Is
that the case?  If so, cool, that would mean that=20
redundancy would already be providing some stripping
and thus, it would indeed seem harder to find a case
where more stripping/fanout is needed.

Ciao,

-Martin



     =20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
