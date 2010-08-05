From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: ceph.spec.in problem in unstable ceph
Date: Thu, 5 Aug 2010 10:01:12 +0000 (UTC)
Message-ID: <i3e258$mv$2@dough.gmane.org>
References: <AANLkTikzSGtffR3oZAwVNsa5RNtkFXx9HvazFBhf501L@mail.gmail.com>
	<Pine.LNX.4.64.1008040959130.16157@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57760 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab0HEKBW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Aug 2010 06:01:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OgxGL-0000Cm-Kj
	for ceph-devel@vger.kernel.org; Thu, 05 Aug 2010 12:01:21 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 05 Aug 2010 12:01:21 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 05 Aug 2010 12:01:21 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> I pushed a fix to the testing branch, but I don't have a Fedora VM handy
> to test it.  Can you let me know if it resolves the problem?
> 

on centos5 this problem is still there.

it seems that "$(docdir)" in the Makefile expands to "".

mkdir -p /var/tmp/ceph-0.22~rc-4el5-root-mockbuild/etc/ceph
mkdir -p /var/tmp/ceph-0.22~rc-4el5-root-mockbuild
/builddir/build/BUILD/ceph-0.22~rc/install-sh -c -m 0600 
sample.ceph.conf /var/tmp/ceph-0.22~rc-4el5-root-mockbuild/
sample.ceph.conf
/builddir/build/BUILD/ceph-0.22~rc/install-sh -c -m 0755 fetch_config /
var/tmp/ceph-0.22~rc-4el5-root-mockbuild/sample.fetch_config



googling for docdir and automake revealed 

http://old.nabble.com/%60docdir'-is-undefined-error-message-
td13941700.html

centos5 has automake 1.9.6 and autoconf 2.59.

- Thomas

