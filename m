From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Nightlies and dumpling
Date: Fri, 8 May 2015 18:31:08 -0400 (EDT)
Message-ID: <1356087144.16584372.1431124268445.JavaMail.zimbra@redhat.com>
References: <554D2081.7040503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53428 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbbEHWcM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 18:32:12 -0400
In-Reply-To: <554D2081.7040503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alistair Israel <aisrael@gmail.com>

Loic

I will remove commented line, thanks for pointing out (having difficult=
ies deleting them :) )

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Alistair Israel" =
<aisrael@gmail.com>
Sent: Friday, May 8, 2015 1:45:53 PM
Subject: Nightlies and dumpling

Hi,

I was going through the checklist to retire a release, to verify nothin=
g was left behind for Dumpling

   http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_retire_a_s=
table_release

and from the nightlies crontab that you published, I found

http://tracker.ceph.com/projects/ceph-releases/wiki/Typica

10 18 * * 0,4 teuthology-suite -v -c giant -k distro -m typica -s upgra=
de/dumpling-firefly-x --filter ubuntu_

and

http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia

10 17 * * 2,4,7 teuthology-suite -v -c next -k distro -m plana,burnupi,=
mira -s upgrade/dumpling-firefly-x --filter ubuntu_

13 19 * * 7 teuthology-suite -v -c firefly -k distro -m vps -s upgrade/=
dumpling-x ~/vps.yaml

15 18 * * 3,6 teuthology-suite -v -c giant -k distro -m vps -s upgrade/=
dumpling-firefly-x ~/vps.yaml


You can also remove from Sepia the lines commented out:

#removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on v=
ps runs out of memory on hammer, YuriW 3/29/15
#15 17 * * 1,3 teuthology-suite -v -c hammer -k distro -m vps -s upgrad=
e/dumpling-firefly-x --suite-branch hammer ~/vps.yaml

#removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on v=
ps runs out of memory on next, YuriW 3/29/15
#15 17 * * 0,2,4,6 teuthology-suite -v -c next -k distro -m vps -s upgr=
ade/dumpling-firefly-x --suite-branch hammer ~/vps.yaml

Maybe there is a reason for scheduling them, even though Dumpling is re=
tired. But in case it was just overlooked, maybe you can save some comp=
uting power in the labs :-0

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
