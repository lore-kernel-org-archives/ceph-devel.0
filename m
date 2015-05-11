From: Samuel Just <sjust@redhat.com>
Subject: Re: rados and the next hammer release v0.94.2
Date: Mon, 11 May 2015 11:03:51 -0400 (EDT)
Message-ID: <1818662143.17375042.1431356631006.JavaMail.zimbra@redhat.com>
References: <55509FD1.8010704@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:46897 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbEKPE6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 11:04:58 -0400
In-Reply-To: <55509FD1.8010704@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

Looks good to me.
-Sam

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Samuel Just" <sjust@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <abhi=
shek.lekshmanan@gmail.com>
Sent: Monday, May 11, 2015 5:25:53 AM
Subject: rados and the next hammer release v0.94.2

Hi Sam,

The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed the rados suite (http://tracker.ceph.com/issues/11492#rado=
s). It includes https://github.com/ceph/ceph/pull/4559 which is the pul=
l request backporting the fix for "OSD::load_pgs: we need to handle the=
 case where an upgrade from earlier versions which ignored non-existent=
 pgs resurrects a pg with a prehistoric osdmap" http://tracker.ceph.com=
/issues/11429 to hammer (the corresponding ceph-qa-suite pull request h=
ttps://github.com/ceph/ceph-qa-suite/pull/432 has also been tested and =
merged).

Do you think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11492#Release-information has direc=
t links to the pull requests merged into hammer since v0.94.1 in case y=
ou need more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre













--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
