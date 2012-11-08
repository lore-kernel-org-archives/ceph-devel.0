From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: clock syncronisation
Date: Thu, 08 Nov 2012 10:04:21 +0100
Message-ID: <509B7595.1010809@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35360 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab2KHJE3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 04:04:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

is there any prefered way to use clock syncronisation?

I've tried running openntpd and ntpd on all servers but i'm still getting:
2012-11-08 09:55:38.255928 mon.0 [WRN] message from mon.2 was stamped 
0.063136s in the future, clocks not synchronized
2012-11-08 09:55:39.328639 mon.0 [WRN] message from mon.2 was stamped 
0.063285s in the future, clocks not synchronized
2012-11-08 09:55:39.328833 mon.0 [WRN] message from mon.2 was stamped 
0.063301s in the future, clocks not synchronized
2012-11-08 09:55:40.819975 mon.0 [WRN] message from mon.2 was stamped 
0.063360s in the future, clocks not synchronized

Stefan
