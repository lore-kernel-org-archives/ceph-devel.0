From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: Recovery stuck and radosgateway not initializing
Date: Tue, 18 Dec 2012 14:08:01 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C54E089B3E@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <367CC0B0FC02EE47BF7482398BD623C54E087A4A@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:37349
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754979Ab2LROIH convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Dec 2012 09:08:07 -0500
Received: from mail6-ch1 (localhost [127.0.0.1])	by mail6-ch1-R.bigfish.com
 (Postfix) with ESMTP id 32B322A00C3	for <ceph-devel@vger.kernel.org>; Tue, 18
 Dec 2012 14:08:06 +0000 (UTC)
Received: from CH1EHSMHS037.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail6-ch1.bigfish.com (Postfix) with ESMTP id BAABA40006C
	for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 14:08:02 +0000 (UTC)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C54E087A4A@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Our configuration : 6 OSDs, 3 Mon.
Journal is on INTEL SSDSA2CW120G3 disk and Data is on Hitachi HUS724040=
ALE640 disk.

When OSD does recovery IO is high, and at some point the OSD is killed.
We set max active recovery to 1 and set filestore op thread suicide tim=
eout to 360.

What should I do in that case ?

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Yann ROBIN
Sent: mardi 18 d=E9cembre 2012 11:51
To: ceph-devel@vger.kernel.org
Subject: Recovery stuck and radosgateway not initializing

Hi,

We're using ceph v0.55, and last night we loste one node of our cluster=
=2E
When it came back, ceph start recovering but since then the radosgatewa=
y could not connect to the cluster.
The rados gateway timeout on initializtion (somewhere in the radosclien=
t connect).

The other problem (and I think it's related) is that the recovery isn't=
 working. Osd gets OSD Op thread timeout and sometimes some of the OSD =
crash (see stacktrace attached).
So it seems that our OSD aren't up long enough for the recovery to proc=
eed.

Any would be appreciated.

Thanks,

--=20
Yann


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
