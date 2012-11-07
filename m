From: Stefan Priebe <s.priebe@profihost.ag>
Subject: extreme ceph-osd cpu load for rand. 4k write
Date: Wed, 07 Nov 2012 21:41:22 +0100
Message-ID: <509AC772.5010606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56911 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab2KGUl0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 15:41:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

whiling benchmarking i was wondering, why the ceph-osd load is so 
extreme high while having random 4k write i/o.

Here an example while benchmarking:

random 4k write: 16.000 iop/s 180% CPU Load in top from EACH ceph-osd 
process

random 4k read: 16.000 iop/s 19% CPU Load in top from EACH ceph-osd process

seq 4M write: 800MB/s 14% CPU Load in top from EACH ceph-osd process

seq 4M read: 1600MB/s 9% CPU Load in top from EACH ceph-osd process

I can't understand why in this single case the load is so EXTREMELY high.

Greets
Stefan
