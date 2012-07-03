From: Wido den Hollander <wido@widodh.nl>
Subject: URL-safe base64 encoding for keys
Date: Tue, 03 Jul 2012 14:22:35 +0200
Message-ID: <4FF2E40B.8090705@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39773 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab2GCMWi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 08:22:38 -0400
Received: from [IPv6:2a00:f10:113:0:d488:14a9:7e34:7fbc] (unknown [IPv6:2a00:f10:113:0:d488:14a9:7e34:7fbc])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPA id 83C4776210
	for <ceph-devel@vger.kernel.org>; Tue,  3 Jul 2012 14:22:36 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

With my CloudStack integration I'm running into a problem with the cephx 
keys due to '/' being possible in the cephx keys.

CloudStack's API expects a URI to be passed when adding a storage pool, 
e.g.:

addStoragePool?uri=rbd://user:cephxkey@monitor.addr/poolname

If 'cephxkey' contains a / the URI parser in Java fails (java.net.URI) 
and splits the URI in the wrong place.

For base64 there is a specification [0] that describes the usage of - 
and _ instead of +  and /

Is there a way that we change the bits in src/common/armor.c and replace 
the + and / for - and _?

Thanks,

Wido

[0]: http://en.wikipedia.org/wiki/Base64#URL_applications
