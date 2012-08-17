From: Wido den Hollander <wido@widodh.nl>
Subject: omap functions in librados.h
Date: Fri, 17 Aug 2012 21:36:36 +0200
Message-ID: <502E9D44.6010006@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54975 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab2HQTgj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 15:36:39 -0400
Received: from [IPv6:2a00:f10:11c:ab:e3:a30f:e13a:115] (unknown [IPv6:2a00:f10:11c:ab:e3:a30f:e13a:115])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id BD9454035B
	for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 21:36:36 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm looking for the omap functions in librados.h, but they only seem to 
be implemented in librados.hpp?

I want to store about 6000 objects in a RADOS pool, but I want to give 
them some attributes I can query for, this should be possible with the 
omap functionality, shouldn't it?

Do to this I want to use phprados, but that is using the C-functions, so 
that's why I'm asking.

Has this been forgotten or is there something blocking it?

Wido
