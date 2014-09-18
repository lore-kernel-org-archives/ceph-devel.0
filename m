From: Janne Grunau <j@jannau.net>
Subject: v2 aligned buffer changes for erasure codes
Date: Thu, 18 Sep 2014 12:33:52 +0200
Message-ID: <1411036435-18860-1-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:44980 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379AbaIRKeE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 06:34:04 -0400
Received: from coburn.home.jannau.net (55d4585a.access.ecotel.net [85.212.88.90])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 225773E14AF
	for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 12:34:01 +0200 (CEST)
In-Reply-To: <1410796508-28711-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

following a is an updated patchset. It passes now make check in src

It has following changes:
 * use 32-byte alignment since the isa plugin use AVX2
   (src/erasure-code/isa/README claims it needs 16*k byte aligned buffers
   but I can't see a reason why it would need more than 32-bytes
 * ErasureCode::encode_prepare() handles more than one chunk with padding

cheers

Janne
