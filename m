From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: mon memory leak
Date: Wed, 13 Mar 2013 11:44:04 +0100
Message-ID: <51405874.6030506@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:46410 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab3CMKoL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 06:44:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

are there any known ceph-mon memory leaks in bobtail? Today i've seen a
ceph-mon process consuming 50GB Memory.

Stefan
