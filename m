From: Sage Weil <sage@newdream.net>
Subject: [IANA #826907] Application for a Port Number and/or Service Name
 "ceph" (Completed) (fwd)
Date: Fri, 10 Jul 2015 14:08:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507101406390.20547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-712007245-1436562524=:20547"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38013 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582AbbGJVIp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 17:08:45 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5D5C880060
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 14:08:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 30C3680060
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 14:08:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-712007245-1436562524=:20547
Content-Type: TEXT/PLAIN; charset=US-ASCII

It's official!  We have a new port number for the monitor:

	3300	(that's CE4h, or 0xCE4).

Sometime in the next cycle we'll need to make a transition plan to move 
from 6789.

sage
--557981400-712007245-1436562524=:20547
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1507101406391.20547@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <iana-shared@icann.org>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 9F43F813F9
	for <sage@cobra.newdream.net>; Mon, 29 Jun 2015 10:49:43 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 4F342120B02; Mon, 29 Jun 2015 10:49:43 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcbdj.dreamhost.com
	[208.97.132.139])
	by destro.newdream.net (Postfix) with ESMTP id 49DE512097B
	for <sage@newdream.net>; Mon, 29 Jun 2015 10:49:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id F3CB725C54A9
	for <sage@newdream.net>; Mon, 29 Jun 2015 10:49:42 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: -0.306
X-Spam-Level: 
X-Spam-Status: No, score=-0.306 tagged_above=-999 required=999
	tests=[BAYES_00=-1.5, MISSING_HEADERS=1.204, T_RP_MATCHES_RCVD=-0.01]
	autolearn=no
Received: from connor.dreamhost.com ([208.97.132.17])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id 1jVlaISUUWXm for <sage@newdream.net>;
	Mon, 29 Jun 2015 10:49:28 -0700 (PDT)
Received: from smtp1.lax.icann.org (smtp01.icann.org [192.0.33.81])
	by connor.dreamhost.com (Postfix) with ESMTP id 416532C981AD
	for <sage@newdream.net>; Mon, 29 Jun 2015 10:49:28 -0700 (PDT)
Received: from request3.lax.icann.org (request1.lax.icann.org [10.32.11.221])
	by smtp1.lax.icann.org (8.13.8/8.13.8) with ESMTP id t5THnR2x031300
	for <sage@newdream.net>; Mon, 29 Jun 2015 17:49:27 GMT
Received: by request3.lax.icann.org (Postfix, from userid 48)
	id CEDF0C2081D; Mon, 29 Jun 2015 17:49:27 +0000 (UTC)
RT-Owner: pearl.liang
Subject: [IANA #826907] Application for a Port Number and/or Service Name
	"ceph" (Completed)
From: "Pearl Liang via RT" <iana-ports@iana.org>
Reply-To: iana-ports@iana.org
In-Reply-To: <201506031911.t53JBukp008456@smtp1.lax.icann.org>
References: <RT-Ticket-826907@icann.org>
	<201506031911.t53JBukp008456@smtp1.lax.icann.org>
Message-ID: <rt-4.2.9-17164-1435600167-144.826907-7-0@icann.org>
X-RT-Loop-Prevention: IANA
X-RT-Ticket: IANA #826907
X-Managed-BY: RT 4.2.9 (http://www.bestpractical.com/rt/)
X-RT-Originator: pearl.liang@icann.org
CC: sage@newdream.net
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Precedence: bulk
Date: Mon, 29 Jun 2015 17:49:27 +0000
MIME-Version: 1.0
X-Spambayes-Classification: ham; 0.00
Content-Transfer-Encoding: quoted-printable


Dear Sage Weil:

Your request has been processed.  We have assigned the following=20
TCP port to ceph with you as the point of contact:

ceph	3300	tcp	Ceph monitor	[Sage_Weil]	[Sage_Weil]	2015-06-29			=09

[Sage_Weil]	Sage Weil	mailto:sage&newdream.net	2015-06-29

Note that the registry has noted known unauthorized use on 3300.

The expert review for this request was completed by: Kumiko Ono

See:=20
http://www.iana.org/assignments/service-names-port-numbers

Please notify IANA if there is any change in contact information by=20
completing the following template:

http://www.iana.org/cgi-bin/mod_portno.pl

This ticket [IANA #826907] is resolved.

Regards,

Pearl Liang
ICANN

***************************************************************
12025 Waterfront Drive, Suite 300
Los Angeles, CA 90094-2536
USA

Phone: +1 310 301 5800=20
FAX:   +1 310 823 8649
email: iana-ports@iana.org
***************************************************************


--557981400-712007245-1436562524=:20547--
