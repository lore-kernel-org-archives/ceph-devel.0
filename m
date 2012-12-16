From: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Subject: RE: Slow requests
Date: Sun, 16 Dec 2012 21:46:01 +0000
Message-ID: <C4049E4484F13747B672D64B9C12C31328DADAC9@PWMAILM01.cscinfo.com>
References: <50CDD3DB.7000501@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.cscinfo.com ([165.160.9.57]:46721 "EHLO mx1.cscinfo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2LPVqE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Dec 2012 16:46:04 -0500
In-Reply-To: <50CDD3DB.7000501@mermaidconsulting.dk>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I heard the solution for this was to restart the osd's.  That fixed it =
for me.

-Chris

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Jens Kristian S=F8gaard
Sent: Sunday, December 16, 2012 9:00 AM
To: ceph-devel@vger.kernel.org
Subject: Slow requests

Hi,

My log is filling up with warnings about a single slow request that has=
 been around for a very long time:

osd.1 10.0.0.2:6800/900 162926 : [WRN] 1 slow requests, 1 included belo=
w; oldest blocked for > 84446.312051 secs

osd.1 10.0.0.2:6800/900 162927 : [WRN] slow request 84446.312051 second=
s old, received at 2012-12-15 15:27:56.891437:
osd_sub_op(client.4528.0:19602219 0.fe
3807b5fe/rb.0.11b7.4a933baa.00000008629e/head//0 [] v 53'185888 snapset=
=3D0=3D[]:[] snapc=3D0=3D[]) v7 currently started


How can I identify the cause of this and how can I cancel this request?

I'm running Ceph on Fedora 17 using the latest RPMs available from ceph=
=2Ecom (0.52-6).


Thanks in advance,
--
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

NOTICE: This e-mail and any attachments is intended only for use by the=
 addressee(s) named herein and may contain legally privileged, propriet=
ary or confidential information. If you are not the intended recipient =
of this e-mail, you are hereby notified that any dissemination, distrib=
ution or copying of this email, and any attachments thereto, is strictl=
y prohibited. If you receive this email in error please immediately not=
ify me via reply email or at (800) 927-9800 and permanently delete the =
original copy and any copy of any e-mail, and any printout.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
