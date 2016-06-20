From: Kevan Rehm <krehm@cray.com>
Subject: ceph-10.2.2.tar.gz on download.ceph.com doesn't compile --with xio
Date: Mon, 20 Jun 2016 13:25:53 +0000
Message-ID: <D38D5910.AC501%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from esa2.cray.iphmx.com ([68.232.143.164]:24864 "EHLO
	esa2.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbcFTNfF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 09:35:05 -0400
Content-Language: en-US
Content-ID: <3B4566933E3726428845D6CE4035ED6F@namprd11.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Greetings,

I did a 
        wget http://download.ceph.com/tarballs/ceph-10.2.2.tar.gz

and then tried to build rpms using "rpmbuild -ba --with xio ceph.spec" but
the build fails, the include file src/messages/MNop.h is missing in the
tarball.  I copied in a version from the ceph master on github, and it's
compiling now, but I don't know if the code will work when I install the
rpms.   Does anyone know?   Should I open an Issue for the missing file in
the tarball?

Thanks, Kevan

