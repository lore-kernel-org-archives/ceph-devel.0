From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: cephx questions
Date: Sun, 1 Aug 2010 18:42:48 +0100
Message-ID: <20100801184248.24cec525.ctpm@ist.utl.pt>
References: <7083006A98B5314F86152D05FFB1B99814AAEF06FF@ICE-MBX-2.ice.nd.edu>
	<Pine.LNX.4.64.1007301553230.28085@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:48228 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215Ab0HARuO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 1 Aug 2010 13:50:14 -0400
In-Reply-To: <Pine.LNX.4.64.1007301553230.28085@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Nathan Regola <nregola@nd.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 30 Jul 2010 16:07:47 -0700 (PDT) Sage Weil <sage@newdream.net> =
wrote:
> On Fri, 30 Jul 2010, Nathan Regola wrote:
> > Hi,
> >=20
> > Thank you for this excellent project.=C2=A0 Are you still planning =
on=20
> > incorporating the code from the Maat paper at some time in the futu=
re?=20
> > As I'm sure you already know, access control lists on the storage=20
> > objects would be quite useful to store research data.=C2=A0
>=20
> We may.  The question is what granularity of security people really n=
eed. =20
> Maat essentially gives fine-grains access control on individual objec=
ts=20
> storing file data, based on the user you are logged in as on the clie=
nt. =20
> But in order for this to be very useful, you need some additional=20
> user-level distributed authentiation scheme like Kerberos, or else a=20
> misbehaving client can pose as any user on that host.  Currently, the=
=20
> kernel client authenticates to cephx and is given a capability to acc=
ess=20
> all objects in the file system object pool.. the same set of objects =
it=20
> can access by traversing the namespace as 'root'.  It doesn't get acc=
ess=20
> to other object pools in the distributed object store (e.g., metadata=
=20
> objects, rbd images, or other pools you may create).
>=20
> What kind of objects (or files?) do you want to protect with ACLs?  D=
o you=20
> need object granularity, or is pool granularity sufficient?
>=20

 Hi all,

 As far as I'm concerned, if we could get file granularity it would be
great. I think the NFSv4 ACL model, for example, would be an excellent
model for Ceph ACLs.
 Note that for realistic general purpose deployments (think big
enterprise workgroup or university campus) you will have to cope with
untrusted client machines. So you will end up using Kerberos or some
kerberos-like security mechanism. NFSv4 and AFS are attractive because
of this and I think that Ceph with file ACLs and Kerberos support would
be very appealing to those people (who already have a working Kerberos
setup, but may be looking for a more scalable/robust file storage
solution).

 I'd be glad to help test/debug any such features.

Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
