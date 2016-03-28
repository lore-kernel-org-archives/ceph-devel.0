From: Loic Dachary <loic@dachary.org>
Subject: teuthology on arm64 for academics @ cloudlab.us
Date: Tue, 29 Mar 2016 00:53:12 +0200
Message-ID: <56F9B5D8.1030608@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59424 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbcC1WxX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2016 18:53:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Robert Ricci <ricci@cs.utah.edu>

Hi,

=46or people elligible to use cloudlab.us[1], a profile was created to =
enable teuthology on the arm64 cluster[2] hosted at the University of U=
tah.

https://www.cloudlab.us/show-profile.php?uuid=3D25be0ffc-f509-11e5-95f1=
-020cbce80001

In a nutshell, it will create an OpenStack cluster tailored for the nee=
ds of teuthology. Once it is up, teuthology-openstack can be used as it=
 would be against OVH or any other OpenStack cluster[3]. For instance:

source openrc.sh
teuthology-openstack --verbose --key-filename ~/.ceph-workbench/teuthol=
ogy-myself.pem --key-name teuthology-myself=20
   --ceph jewel --suite dummy

Cheers

[1] CloudLab Users http://docs.cloudlab.us/users.html
[2] The University of Utah https://www.cloudlab.us/hardware.php#utah
[3] OpenStack backend https://github.com/dachary/teuthology/tree/openst=
ack#openstack-backend
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
