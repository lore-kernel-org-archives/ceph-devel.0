From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: btrfs big metadata
Date: Mon, 02 Jul 2012 08:56:29 +0200
Message-ID: <4FF1461D.9060304@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42279 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2GBG4b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 02:56:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i found several people who use big metadata -n 64k -l 64k for ceph. But 
i haven't found any ceph doc or info why to use this?

What's the reason to use big metadata feature with ceph?

Greets,
Stefan
