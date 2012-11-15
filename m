From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 12:18:21 +0100 (CET)
Message-ID: <7840e3d1-17b2-4618-ae1f-ff3dbdff71f6@mailpro>
References: <50A4CA65.2030508@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46727 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423250Ab2KOLSw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 06:18:52 -0500
In-Reply-To: <50A4CA65.2030508@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

cpu usage is same for read and write  ?


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 15 Novembre 2012 11:56:37=20
Objet: ceph-osd cpu usage=20

Hello list,=20

my main problem right now is that ceph does not scale for me (more vms=20
using rbd). It does not scale as the ceph-osd is using all my CPU core=20
all the time (8 cores) with just 4 SSDs. The SSDs are far away from=20
being loaded.=20

What is the best way to find out what the ceph-osd process is doing all=
=20
the time?=20

A gperf graph is attached.=20

Greets,=20
Stefan=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
