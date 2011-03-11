From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: Another question about PG::do_peer
Date: Fri, 11 Mar 2011 10:36:32 +0800
Message-ID: <AANLkTi=Q0iFNMagR=2-dmfW441dp=s6U_NEEfS09cT-8@mail.gmail.com>
References: <AANLkTikWHRrOJom30_CFi2jqdZ3YP41AZqCE4_nM4Jk_@mail.gmail.com>
	<Pine.LNX.4.64.1103101006030.986@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60391 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1CKCgc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 21:36:32 -0500
Received: by gyh20 with SMTP id 20so920768gyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 18:36:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1103101006030.986@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

> Yeah, this is definitely broken, but I think it's broken even beyond =
that
> specific case. =C2=A0It looks like it's just an ill-conceived optimiz=
ation.
> The problem is that peer_missing needs to have missing in terms of th=
e
> master log (on the primary), not the peer's log, and in order to
> calculate that we need pull the log+missing. =C2=A0(In the
> last_update=3D=3Dlast_complete case I was trying to optimize, the mis=
sing set
> will just be empty.) =C2=A0The current code missing the case where th=
e replica
> has a divergent log or and older last_update (even one > log.tail).
>
> I think this shortcut _only_ makes sense when the replica is perfectl=
y up
> to date, i.e.
>
> =C2=A0 =C2=A0 =C2=A0if (pi.last_update =3D=3D pi.last_complete &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pi.last_update =3D=3D info.last_upd=
ate) {
>
> Does that sound right?

Yeah, thanks for the clarification. :)

--=20
Henry Chang
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
