From: Stefan Priebe <s.priebe@profihost.ag>
Subject: skip / disable journal
Date: Mon, 15 Apr 2013 22:24:10 +0200
Message-ID: <516C61EA.60507@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:40006 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3DOUYN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 16:24:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

is there a possibility to disable / skip the jornal? Stuff like 
FlashCache, BCache and others seem to work much better but sequential 
I/O becomes a bottleneck if the ceph journal is on a single ssd.

Greets,
Stefan
