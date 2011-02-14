From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: question about socket conection among osd,mds,mon
Date: Mon, 14 Feb 2011 09:12:49 -0800
Message-ID: <F7AC6D547FA64F7EB1230167F17B99A9@gmail.com>
References: <4D57DFFB.5080703@nadir-seen-fire.com>
 <Pine.LNX.4.64.1102131028450.27567@cobra.newdream.net>
 <D0C67741759ABD4BBD8D3A5CB815606E07E935@mail.cloud-valley.com.cn>
 <AANLkTikW4cmB5pDKGk=_W49NhTkgmY-0eP0ZGtfEWf=d@mail.gmail.com>
 <D0C67741759ABD4BBD8D3A5CB815606E07E986@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38597 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab1BNRNH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Feb 2011 12:13:07 -0500
Received: by gxk9 with SMTP id 9so2155198gxk.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Feb 2011 09:13:07 -0800 (PST)
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E986@mail.cloud-valley.com.cn>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org


On Monday, February 14, 2011 at 5:37 AM, Longguang Yue wrote:=20
> !!!! osd e35: 3 osds: 3 up, 3 in -- 2 blacklisted MDSes
>=20
> ceph can recover blacklisted osds by itself, but I want to recover bl=
acklist osds as soon as possible.
>=20
> How to use the command, 'ceph osd blacklist rm host:port' ????
>=20
> thanks
None of your OSDs have been blacklisted. 2 of your MDSes have been, but=
 that means that they either went down or were so laggy as to be useles=
s. If they were laggy, then they will eventually find out and restart t=
hemselves, at which point they will be identified as a different MDS an=
d won't be blacklisted.
This doesn't mean there's anything wrong with your OSDs, though!
-Greg=20

> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: rarecactus@gmail.com [mailto:rarecactus@=
gmail.com] =E4=BB=A3=E8=A1=A8 Colin McCabe
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2011=E5=B9=B42=E6=9C=8814=E6=97=
=A5 18:21
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Longguang Yue
> =E6=8A=84=E9=80=81: Sage Weil; ceph-devel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: question about socket conection among osd,mds=
,mon
>=20
> Hi Longguang,
>=20
> The blacklist stops MDSes from talking to OSDs. You cannot blacklist
> an OSD itself.
>=20
> What is it that you're trying to do?
>=20
> sincerely,
> Colin
>=20
>=20
> On Sun, Feb 13, 2011 at 7:13 PM, Longguang Yue
> <longguang_yue@tcloudcomputing.com> wrote:
> > 1.Netstat info:
> > 10.10.1.100:6800 <--- 10.10.1.106:34585, 10.10.1.98:46625
> > 10.10.1.100:6801 <--- 10.10.1.106:59284, 10.10.1.98:35101
> > When osd need 2(more) listen sockets? Why others osd connect as man=
y
> > times as its listen socket?
> >=20
> >=20
> > 2.how to deal with blacklist osds
> > osd e35: 3 osds: 3 up, 3 in -- 2 blacklisted MDSes
> >=20
> > according to 1 case, how to deal with blacklist.
> > If I need run 'ceph osd blacklist rm 10.10.1.106:34585 &&
> > 10.10.1.98:46625 ' ??????
> >=20
> > I think just only one osd listen socket exists!!!!!!
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> ??{.n?+???????+%??lzwm??b?=EB=A7=B2??r??y=C7=A9?=D7=AFzX????=DC=A8}??=
?=C6=A0z?&j:+v???????zZ+??+zf???h???~????i???z??w?????????&?)=DF=A2f?

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
