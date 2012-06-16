From: Stefan Priebe <s.priebe@profihost.ag>
Subject: OSD crash
Date: Sat, 16 Jun 2012 14:57:30 +0200
Message-ID: <4FDC82BA.5030102@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35262 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab2FPM5b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jun 2012 08:57:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

today i got another osd crash ;-( Strangely the osd logs are all empty. 
It seems the logrotate hasn't reloaded the daemons but i still have the 
core dump file? What's next?

Stefan

