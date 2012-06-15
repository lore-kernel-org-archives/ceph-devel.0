From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: mon disk access pattern
Date: Fri, 15 Jun 2012 07:52:16 +0200
Message-ID: <4FDACD90.2080807@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37140 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab2FOFwY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 01:52:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i read somewhere that the mon has "special" disk access patterns - even 
though it does not write much data.

I'm using a patched debian squeeze with syncfs support (thanks to amon). 
Are there any recommandations where to put the mon data? (SSD? Raid? 
Which FS?)

Greets,
Stefan
