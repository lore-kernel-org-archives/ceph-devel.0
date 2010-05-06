From: Martin Fick <mogulguy@yahoo.com>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 15:28:42 -0700 (PDT)
Message-ID: <719233.66260.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36101.mail.mud.yahoo.com ([66.163.179.215]:47192 "HELO
	web36101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753703Ab0EFW2n convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 18:28:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?iso-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>, ceph-devel@vger.kernel.org

--- On Thu, 5/6/10, Sage Weil <sage@newdream.net> wrote:
> The image is striped over objects, _then_ the objects are
> replicated across OSDs.=A0 Objects themselves aren't striped.
>=20
> For example, if an image is striped over objects A B C D E
> F, each 4MB, you might end up with
>=20
> osd0: A=A0 B' C=A0 D=A0 E' F'
> osd1: A' B=A0 C' D' E=A0 F
>=20
> where A is the primary copy, A' is the replica, etc.

Yes, I see now, much clearer, thanks.

So, as long as each object has one copy on each OSD it=20
should be safe.  And there might be some hash based=20
extra non-perfect stripping as a benefit.  Then, yeah,
it does seem like it would be hard to find a very=20
unbalanced workload on a heterogeneous OSD (even with=20
a 2 node cluster).  Cool.

Thanks,

-Martin



     =20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
