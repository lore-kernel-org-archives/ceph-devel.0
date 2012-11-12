From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: improve speed with auth supported=none
Date: Mon, 12 Nov 2012 16:37:29 +0100
Message-ID: <50A117B9.4060804@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35382 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab2KLPhc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 10:37:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i'm still trying to improve ceph speed. Disable logging on host and rbd 
client gives me additional 5000 iop/s which is great.

But i also wanted to try disabling authentication using:
auth supported=none

How does this work? Do i just have to place this line under global 
section in ceph.conf?

Greets,
Stefan
