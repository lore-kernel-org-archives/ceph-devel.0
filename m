From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Need CRYPTO_CXXFLAGS with latest master?
Date: Wed, 31 Oct 2012 18:27:14 -0700
Message-ID: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53168 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756931Ab2KAB1P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 21:27:15 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so2209565vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 18:27:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

Pushed changes to Makefile.am in branch:

   wip-make-crypto-flags

Several changes to Makefile.am that add CRYPTO_CXXFLAGS to various
test targets. I needed these to build after updating to master this
afternoon.

Not sure if there is something else going on in my environment..

Thanks,
Noah
