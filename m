From: Niklas Goerke <niklas@niklasgoerke.de>
Subject: Rados Protocoll
Date: Thu, 01 Aug 2013 22:01:03 +0200
Message-ID: <51FABE7F.90200@niklasgoerke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from niklasgoerke.de ([46.38.232.61]:42778 "EHLO niklasgoerke.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab3HAUK5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Aug 2013 16:10:57 -0400
Received: from [0.0.0.0] (niklasgoerke.de [46.38.232.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by niklasgoerke.de (Postfix) with ESMTPS id BBE2E28DE004
	for <ceph-devel@vger.kernel.org>; Thu,  1 Aug 2013 20:01:04 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was wondering why there is no native Java implementation of librados. 
I'm thinking about creating one and I'm thus looking for a documentation 
of the RADOS protocol.
Also the way I see it librados implements the crush algorithm. Is there 
a documentation for it?
Also an educated guess about whether the RADOS Protocol is due to 
changes would be very much appreciated.

Thank you in advance

Niklas
