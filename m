From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: Recovery stuck and radosgateway not initializing
Date: Wed, 19 Dec 2012 15:12:41 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C54E08A233@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <367CC0B0FC02EE47BF7482398BD623C54E087A4A@DB3PRD0311MB416.eurprd03.prod.outlook.com>
 <367CC0B0FC02EE47BF7482398BD623C54E089B3E@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:23488
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750996Ab2LSPMw convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Dec 2012 10:12:52 -0500
Received: from mail188-co9 (localhost [127.0.0.1])	by
 mail188-co9-R.bigfish.com (Postfix) with ESMTP id 62A5F36017D	for
 <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 15:12:51 +0000 (UTC)
Received: from CO9EHSMHS013.bigfish.com (unknown [10.236.132.240])	by
 mail188-co9.bigfish.com (Postfix) with ESMTP id D1084AE004B	for
 <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 15:12:48 +0000 (UTC)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C54E089B3E@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We had a bunch of disk who failed. That's why ceph was having trouble k=
eeping OSD up.
And we found that during recovery the rados gateway failed to initializ=
e. The init_watch function timeout.
As it is only used when cache is activated, we disable cache (rgw cache=
 enable false) and the radosgateway started :) !

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Yann ROBIN
Sent: mardi 18 d=E9cembre 2012 15:08
To: ceph-devel@vger.kernel.org
Subject: RE: Recovery stuck and radosgateway not initializing

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


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
