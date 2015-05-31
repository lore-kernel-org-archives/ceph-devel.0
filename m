From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Sun, 31 May 2015 15:48:23 -0400 (EDT)
Message-ID: <1075864657.6869209.1433101703417.JavaMail.zimbra@redhat.com>
References: <5559DE24.4010601@dachary.org> <322852770.9958799.1433026361754.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:54812 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbEaTtc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 15:49:32 -0400
In-Reply-To: <322852770.9958799.1433026361754.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>, Alfredo Deza <adeza@redhat.com>, Loic Dachary <ldachary@redhat.com>, Sage Weil <sweil@redhat.com>, Ian Colle <icolle@redhat.com>

----- Original Message -----
> From: "Yuri Weinstein" <yweinste@redhat.com>
> To: "Loic Dachary" <loic@dachary.org>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <ab=
hishek.lekshmanan@gmail.com>, "Alfredo Deza"
> <adeza@redhat.com>, "Loic Dachary" <ldachary@redhat.com>, "Gregory Fa=
rnum" <gfarnum@redhat.com>, "Sage Weil"
> <sweil@redhat.com>, "Ian Colle" <icolle@redhat.com>
> Sent: Saturday, May 30, 2015 3:52:41 PM
> Subject: Re: hammer branch for v0.94.2 ready for QE
>=20
> QE validation is complete and this release is ready for publishing.
>=20
> (Greg, I assumed that you approved this release with failures in knfs=
 suite
> re: unresolved #11789, marked for v0.94.3 backport)

Yeah...So I have no idea what we could have changed to cause these, and=
 I bet it's some kind of environment issue (or perhaps a change in the =
kernel?). Nonetheless we've not seen them previously and I am uncomfort=
able doing a release with them =E2=80=94 if something like this happene=
d in RADOS I would not approve it. But given CephFS' current status and=
 the fact that I don't know of anybody who's actually using knfs on top=
 it's probably okay.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
