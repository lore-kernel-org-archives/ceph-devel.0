From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Quick comparison of Hammer & Infernalis on NVMe
Date: Thu, 26 Nov 2015 15:02:41 +0100 (CET)
Message-ID: <715619802.10399931.1448546561295.JavaMail.zimbra@oxygem.tv>
References: <3649A15A2562B54294DE14BCE5AC79120B8FD242@FMSMSX119.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52405 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbbKZOCo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Nov 2015 09:02:44 -0500
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120B8FD242@FMSMSX119.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Mark Nelson <mnelson@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>

Thanks for sharing !

Results are impressive, Great to see that write are finally improving.

I just wonder how much you could have with rbd_cache=3Dfalse.

Also, with such high load,

maybe using jemalloc on fio could help too (I have seen around 20% impr=
ovement on fio client)

LD_PRELOAD=3D${JEMALLOC_PATH}/lib/libjemalloc.so.1 fio ....


Regards,

Alexandre
----- Mail original -----
De: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "Sage Weil" <sweil@r=
edhat.com>, "Mark Nelson" <mnelson@redhat.com>, "Somnath Roy" <Somnath.=
Roy@sandisk.com>
Envoy=C3=A9: Mercredi 25 Novembre 2015 22:52:59
Objet: Quick comparison of Hammer & Infernalis on NVMe

(2nd time w/o HTML formatting)=20
As I mentioned today in the meeting we have a first pass set of numbers=
 from Infernalis. This is the same hardware, configuration (including c=
eph.conf), and clients as the previous data from this presentation: htt=
p://www.slideshare.net/Inktank_Ceph/accelerating-cassandra-workloads-on=
-ceph-with-allflash-pcie-ssds=20

The comparison data is here: https://www.docdroid.net/X0kJcIp/quick-ham=
mer-vs-infernalis-nvme-comparison.pdf.html=20

Reads are a bit slower than we measured before at higher QD, but roughl=
y the same up to 1M IOPS. Writes look a lot better! Also if you look at=
 the long-tail latency numbers (not graphed, in the backup slides) the =
long tail latency is much lower for writes and mixed workloads, by 1/3r=
d to 1/8th. We are doing analysis and building tools that are focusing =
on 80th/90th/95th/99th latency across workloads at various queue depths=
 now so we'll see if we can get any more insight.=20

We did at some point during the upgrade find that SELinux was set to 'e=
nforcing', and originally this gave us a much lower performance measure=
ment. We have some comparison data for that if anyone is interested.=20

If you're in the U.S, have a great holiday!=20

Thanks,=20

Stephen=20


--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
