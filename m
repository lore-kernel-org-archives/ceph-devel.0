From: Wido den Hollander <wido@42on.com>
Subject: Building Ceph statically linked
Date: Wed, 13 Nov 2013 21:22:21 +0100
Message-ID: <5283DF7D.9080203@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:49427 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab3KMUWX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Nov 2013 15:22:23 -0500
Received: from [79.99.132.145] (unknown [79.99.132.145])
	by websrv.42on.com (Postfix) with ESMTPSA id EE14CC0183
	for <ceph-devel@vger.kernel.org>; Wed, 13 Nov 2013 21:22:21 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

While doing some tests I'm trying to build Ceph statically. I have a 
bunch of machines where I run Ceph on for these test (mostly RGW now) 
and I'm running into some library issues when switching from branches.

To make my life a bit easier I tried compiling Ceph (especially RGW) 
statically linked, but somehow I keep ending up with a dynamically 
linked binary.

What I tried:

$ env CXXFLAGS="-static" ./configure --enable-static --disable-shared
$ make

Usually that should spit out a static binary, but 'radosgw' is still 
dynamic.

I'm not such a autoconf nor automake guru, so does anybody ever build 
static binaries with Ceph?

Yes, I'm aware they can become very large, but that's not my concern 
right now. I just want to upload a binary to a machine, run it and see 
if it does what I'm hoping it does and not having to worry about all the 
dependencies being there and being the right version.

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
