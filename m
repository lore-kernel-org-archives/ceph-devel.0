From: Stefan Priebe <s.priebe@profihost.ag>
Subject: still cuttlefish recovery problems
Date: Sat, 22 Jun 2013 10:34:10 +0200
Message-ID: <51C56182.5050606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:55959 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab3FVIeF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Jun 2013 04:34:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

since the peering problems are gone with 0.61.4 (Bug 5232) i'm still 
having heavy problems with recovering after OSD or host restart.

I'm seeing a lot of slow requests and stucked I/O from clients.

I've opened i bug report here:
http://tracker.ceph.com/issues/5401

I really would like to know if i'm the only one.

Should i update to 0.66?

Greets,
Stefan
