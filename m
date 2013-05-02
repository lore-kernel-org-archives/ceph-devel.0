From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Version compatibility between Ceph Kernel and Userland
Date: Thu, 2 May 2013 11:26:45 +0200
Message-ID: <20130502092645.GB28701@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:55182 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab3EBJ1k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 05:27:40 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Kasper Dieter <Dieter.Kasper@ts.fujitsu.com>

Sage,

can you please create and foster a compatibility matrix
between Ceph Kernel-components and the Ceph Userland-components ?
Also the naming of restrictions and/or additional features for specific combinations
would be very much appreciated.
e.g.

Ceph Kernel	3.0 | 3.1 | ... | 3.7 | 3.8 | 3.9 |
Ceph 0.48.x	 ?  | (1) | ... |  ?  |  ?  |  ?  |
Ceph 0.56.x	 ?  |  ?  | ... |  ?  |  ?  |  ?  |
     0.57-0.60	 ?  |  ?  | ... |  ?  |  ?  |  ?  |
Ceph 0.61.x	 ?  |  ?  | ... |  ?  | (2) |  ?  |
     0.62-0.66	 ?  |  ?  | ... |  ?  |  ?  |  ?  |
Ceph 0.67.x	 ?  |  ?  | ... |  ?  |  ?  |  ?  |

just examples ...
(1) no support of ceph.ko
(2) support OSD format-2


Thanks,
-Dieter
