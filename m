From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Debug kvm exit / stops
Date: Sat, 3 Nov 2012 19:21:26 +0100
Message-ID: <F948A2C5-458A-4625-9140-7C07E027EFC5@profihost.ag>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:33553 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2KCSVa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 14:21:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello List,

while benchmarking striped rbd format v2 my KVM process exits at the read tests. No segfault it just seems to finish.

Any idea how to debug?

Stefan