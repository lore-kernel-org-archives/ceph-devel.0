From: Janne Grunau <j@jannau.net>
Subject: erasure code arm 32 and 64 bit neon optimisations
Date: Mon, 27 Oct 2014 19:20:31 +0100
Message-ID: <1414434036-29313-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59339 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbaJ0SUm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:20:42 -0400
Received: from coburn.home.jannau.net (55d44062.access.ecotel.net [85.212.64.98])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 323953E19D7
	for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 19:20:39 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

gf-complete has since last week optimisations using ARM's NEON SIMD
instruction set. This patch set adds a jerasure erasure code plugin
using the NEON optimisations.

Reed-Solomon-Vandermonde encoding for large block sizes (256k) is 2-8
times faster depending on the number of chunks and erasures (tested on
cortex-a9, coretex-a53 and cortex-a57). For smaller block size (4k) the
speed-up is smaller since the memory management overhead is larger than
encoding workload.

cheers Janne

