From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 23:10:12 +0700
Message-ID: <56D46D64.1060909@dachary.org>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
 <CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
 <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
 <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
 <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
 <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
 <1456736629334.47610@croc.ru>
 <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
 <1456745435596.21796@croc.ru>
 <CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
 <56D45CCC.8010608@dachary.org> <56D46889.3000406@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40682 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbcB2QKV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 11:10:21 -0500
In-Reply-To: <56D46889.3000406@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Dan van der Ster <dan@vanderster.com>, Odintsov Vladislav <VlOdintsov@croc.ru>, Shinobu Kinjo <skinjo@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Franklin M. Siler" <me@franksiler.com>, Sage Weil <sage@redhat.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-users <ceph-users@ceph.com>

I've created a pad at http://pad.ceph.com/p/development-releases for th=
e next CDM ( see http://tracker.ceph.com/projects/ceph/wiki/Planning fo=
r details).

On 29/02/2016 22:49, Nathan Cutler wrote:
> The basic idea is to copy the packages that are build by gitbuilders =
or by the buildpackage teuthology task in a central place. Because thes=
e packages are built, for development versions as well as stable versio=
ns[2]. And they are tested via teuthology. The packages that are publis=
hed on http://ceph.com/ are rebuilt from scratch, using the process tha=
t Alfredo described. This is fine for the supported platforms and for t=
he stable releases. But for the development releases and the platforms =
that are no longer supported but still built by gibuilders, we could ju=
st copy the packages over.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
