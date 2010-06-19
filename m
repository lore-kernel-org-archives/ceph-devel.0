From: Thomas Mueller <thomas@chaschperli.ch>
Subject: creation of ./.snap/test creates something in ./subdir/.snap/
Date: Sat, 19 Jun 2010 07:27:32 +0000 (UTC)
Message-ID: <hvhrh3$n0a$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34729 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488Ab0FSH1o (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 19 Jun 2010 03:27:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPsSr-000471-4f
	for ceph-devel@vger.kernel.org; Sat, 19 Jun 2010 09:27:41 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jun 2010 09:27:41 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jun 2010 09:27:41 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

i was looking for a way to list all snapshots*.

then i discovered this:


mkdir ./.snap/test

then i found this:
./.snap/test
./subdir/.snap/_test_1099511630280


the subdir/.snap/_test_1099511630280 vanishes if i delete the ./.snap/
test.


kclient: ceph-client-standalone/unstable-backport
ceph:  ceph/unstable


- Thomas


* 

find ./ -type d -print0 | \
	xargs -0 -I% -n1 find %/.snap -mindepth 1 -maxdepth 1

