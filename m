From: Dave Spano <dspano@optogenics.com>
Subject: Re: OSD memory leaks?
Date: Wed, 9 Jan 2013 16:42:59 -0500 (EST)
Message-ID: <2054641.97.1357767776178.JavaMail.dspano@it1>
References: <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rrcs-24-103-221-203.nys.biz.rr.com ([24.103.221.203]:38864 "EHLO
	mail.optogenics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933157Ab3AIVnI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 16:43:08 -0500
In-Reply-To: <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

That's very good to know. I'll be restarting ceph-osd right now! Thanks=
 for the heads up!=20

Dave Spano=20
Optogenics=20
Systems Administrator=20



----- Original Message -----=20

=46rom: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
To: "Dave Spano" <dspano@optogenics.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel Just" <sam.just@=
inktank.com>=20
Sent: Wednesday, January 9, 2013 11:35:13 AM=20
Subject: Re: OSD memory leaks?=20

If you wait too long, the system will trigger OOM killer :D, I already=20
experienced that unfortunately...=20

Sam?=20

On Wed, Jan 9, 2013 at 5:10 PM, Dave Spano <dspano@optogenics.com> wrot=
e:=20
> OOM killer=20



--=20
Regards,=20
S=C3=A9bastien Han.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
