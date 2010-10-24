From: Thomas Mueller <thomas@chaschperli.ch>
Subject: new warning message "AC_INIT: not a literal"
Date: Sun, 24 Oct 2010 10:25:21 +0000 (UTC)
Message-ID: <ia11ih$mli$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:39165 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab0JXKZc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Oct 2010 06:25:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1P9xlZ-0000cI-3b
	for ceph-devel@vger.kernel.org; Sun, 24 Oct 2010 12:25:29 +0200
Received: from 46-127-100-83.dclient.hispeed.ch ([46.127.100.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 24 Oct 2010 12:25:29 +0200
Received: from thomas by 46-127-100-83.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 24 Oct 2010 12:25:29 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


rev#22bb21188d667eaa0eb3c070811173d5cdc55da7
on debian squeeze


chmod +x cdebugpack.tmp
chmod a-w cclass.tmp
chmod a-w cdebugpack.tmp
mv cclass.tmp cclass
mv cdebugpack.tmp cdebugpack
(CDPATH="${ZSH_VERSION+.}:" && cd .. && /bin/bash /.../ceph/missing --run autoheader)
 configure.ac:6: warning: AC_INIT: not a literal: Sage Weil <sage@newdream.net>
 rm -f stamp-h1
touch acconfig.h.in
cd .. && /bin/bash ./config.status src/acconfig.h
config.status: creating src/acconfig.h
config.status: src/acconfig.h is unchanged
/usr/bin/make  all-am


- Thomas

