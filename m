From: Stefan Priebe <s.priebe@profihost.ag>
Subject: rbd export speed limit
Date: Tue, 12 Feb 2013 21:22:19 +0100
Message-ID: <511AA47B.3020309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:52329 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab3BLUWX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 15:22:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

is there a speed limit option for rbd export? Right now i'm able to 
produce several SLOW requests from IMPORTANT valid requests while just 
exporting a snapshot which is not really important.

rbd export runs with 2400MB/s and each OSD with 250MB/s so it seems to 
block valid normal read / write operations.

Greets,
Stefan
