From: Loic Dachary <loic@dachary.org>
Subject: paddles read-only mirror
Date: Wed, 23 Mar 2016 11:21:41 +0100
Message-ID: <56F26E35.8030802@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60766 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbcCWKVq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 06:21:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Zack,

It would be very convenient to have a read-only public copy of the padd=
les database. So that anyone can run a command like this:

paddles=3Dpaddles.front.sepia.ceph.com
run=3Dloic-2016-01-29_00:40:06-upgrade:hammer-hammer-backports---basic-=
vps
eval filter=3D$(curl --silent http://$paddles/runs/$run/ | jq '.jobs[] =
| select(.status =3D=3D "dead" or .status =3D=3D "fail") | .description=
' | while read description ; do echo -n $description, ; done | sed -e '=
s/,$//')

to schedule a run of failed jobs.

It could be done by activating continuous archiving of the pgsql wal (h=
ttp://www.postgresql.org/docs/9.4/static/continuous-archiving.html) whi=
ch can then be used to udpate the read-only copy. It is non intrusive f=
or the running paddles and there is plenty of space to keep these.

ubuntu@pulpito:~$ hostname --fqdn
pulpito.front.sepia.ceph.com
ubuntu@pulpito:~$ df -h /
=46ilesystem      Size  Used Avail Use% Mounted on
/dev/sda1       351G  5.6G  328G   2% /

Do you think that's something sensible ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
