From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Slow requests
Date: Sun, 16 Dec 2012 14:59:55 +0100
Message-ID: <50CDD3DB.7000501@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.stofanet.dk ([212.10.10.13]:48580 "EHLO mx03.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab2LPOPy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 16 Dec 2012 09:15:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

My log is filling up with warnings about a single slow request that has=
=20
been around for a very long time:

osd.1 10.0.0.2:6800/900 162926 : [WRN] 1 slow requests, 1 included=20
below; oldest blocked for > 84446.312051 secs

osd.1 10.0.0.2:6800/900 162927 : [WRN] slow request 84446.312051 second=
s=20
old, received at 2012-12-15 15:27:56.891437:=20
osd_sub_op(client.4528.0:19602219 0.fe=20
3807b5fe/rb.0.11b7.4a933baa.00000008629e/head//0 [] v 53'185888=20
snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7 currently started


How can I identify the cause of this and how can I cancel this request?

I'm running Ceph on Fedora 17 using the latest RPMs available from=20
ceph.com (0.52-6).


Thanks in advance,
--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
