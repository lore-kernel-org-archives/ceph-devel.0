From: Niklas Goerke <niklas@niklasgoerke.de>
Subject: Missing Option to give amount of PGs on pool creation with librados
Date: Mon, 05 Aug 2013 16:14:08 +0200
Message-ID: <7717d2e3c2768d554dafe48cfe657778@niklasgoerke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from niklasgoerke.de ([46.38.232.61]:34626 "EHLO niklasgoerke.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724Ab3HEOOK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 10:14:10 -0400
Received: from mail.niklasgoerke.de (localhost.localdomain [127.0.0.1])
	by niklasgoerke.de (Postfix) with ESMTP id C926428DE004
	for <ceph-devel@vger.kernel.org>; Mon,  5 Aug 2013 14:14:08 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi there

The way I see it, there is no option to give the amount of PGs when 
creating a new pool using librados [1]. Thus any pool created using 
librados has 8 PGs (default). I don't see a reason for this behaviour. 
Is there any?

Otherwise I'll post a feature request for an option to give the amount 
of PGs.

Niklas

[1] http://ceph.com/docs/next/rados/api/librados/
