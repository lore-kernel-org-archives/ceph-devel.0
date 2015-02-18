From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore
 performance	comparison
Date: Wed, 18 Feb 2015 09:34:20 +0100 (CET)
Message-ID: <1298645585.1174612.1424248460594.JavaMail.zimbra@oxygem.tv>
References: <54E37C3D.5030702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46248 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbBRIeW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 03:34:22 -0500
In-Reply-To: <974800637.1174441.1424248449764.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Nice Work Mark !

I don't see any tuning about sharding in the config file sample

(osd_op_num_threads_per_shard,osd_op_num_shards,...)

as you only use 1 ssd for the bench, I think it should improve results =
for hammer ?



----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Cc: "ceph-users" <ceph-users@lists.ceph.com>
Envoy=C3=A9: Mardi 17 F=C3=A9vrier 2015 18:37:01
Objet: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore performan=
ce	comparison

Hi All,=20

I wrote up a short document describing some tests I ran recently to loo=
k=20
at how SSD backed OSD performance has changed across our LTS releases.=20
This is just looking at RADOS performance and not RBD or RGW. It also=20
doesn't offer any real explanations regarding the results. It's just a=20
first high level step toward understanding some of the behaviors folks=20
on the mailing list have reported over the last couple of releases. I=20
hope you find it useful.=20

Mark=20

_______________________________________________=20
ceph-users mailing list=20
ceph-users@lists.ceph.com=20
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
