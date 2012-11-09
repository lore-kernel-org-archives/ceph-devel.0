From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: can't build the last master git (`configure.ac' or `configure.in' is required)
Date: Fri, 09 Nov 2012 11:53:51 +0100 (CET)
Message-ID: <7a0da62a-8758-47ad-b101-c6848a9d4a5e@mailpro>
References: <3388b731-bdbb-448e-89c4-d9d3661ea774@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46373 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab2KIKyV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 05:54:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id AF4591803686B
	for <ceph-devel@vger.kernel.org>; Fri,  9 Nov 2012 11:53:56 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NmvymA7SDwec for <ceph-devel@vger.kernel.org>;
	Fri,  9 Nov 2012 11:53:51 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 327D818027946
	for <ceph-devel@vger.kernel.org>; Fri,  9 Nov 2012 11:53:51 +0100 (CET)
In-Reply-To: <3388b731-bdbb-448e-89c4-d9d3661ea774@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,I need help to build last master git,
I was building fine before,

#git clone git://ceph.newdream.net/git/ceph.git
#git submodule init
#git module update
#dpkg-buildpackage

...
autoreconf: running: /usr/bin/autoconf --force
autoreconf: running: /usr/bin/autoheader --force
autoreconf: running: automake --add-missing --copy --force-missing
autoreconf: Leaving directory `.'
autoreconf: `configure.ac' or `configure.in' is required
make: *** [configure-stamp] Error 1
dpkg-buildpackage: error: debian/rules build gave error exit status 2


Any ideas ?
