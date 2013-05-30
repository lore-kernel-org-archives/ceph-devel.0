From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: ceph gets stopped but never started...
Date: Thu, 30 May 2013 13:30:05 +0200
Message-ID: <51A7383D.4060309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:49333 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3E3LaK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 07:30:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

since commit 85fb422a084785176af3b694882964841e02195d in cuttle fish
cherry-picked from 2f193fb931ed09d921e6fa5a985ab87aa4874589 ceph gets
stopped on debian while upgrading but it never gets started again??

Does this really makes sense?

Should the admin handle the stop / start / restart on upgrade?

Stefan
