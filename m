From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: trying to import crushmap results in max_devices > osdmap max_osd
Date: Wed, 07 Nov 2012 16:28:12 +0100
Message-ID: <509A7E0C.9040606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47524 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab2KGP2S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 10:28:18 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

i've added two nodes with 4 devices each and modified the crushmap.

But importing the new map results in:
crushmap max_devices 55 > osdmap max_osd 35

What's wrong?

Greets
Stefan
