From: Stefan Priebe <s.priebe@profihost.ag>
Subject: ceph osd create XX
Date: Wed, 12 Dec 2012 22:31:24 +0100
Message-ID: <50C8F7AC.9070600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37241 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab2LLVb0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 16:31:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello List,

ceph osd create $NUM

does not seem to work anymore ;-(

# ceph osd createosd. 62
unknown command createosd

Crushmap is already changed and imported ceph.conf is altered and reloaded.

Greets
Stefan
