From: Thomas Mueller <thomas@chaschperli.ch>
Subject: PATCH: add dkms support
Date: Wed, 7 Jul 2010 09:17:36 +0000 (UTC)
Message-ID: <i11gng$mk1$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36497 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab0GGJRq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Jul 2010 05:17:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWQlF-0006Vr-11
	for ceph-devel@vger.kernel.org; Wed, 07 Jul 2010 11:17:45 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jul 2010 11:17:45 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jul 2010 11:17:45 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

i've added DKMS support to the ceph-client-standalone git repo.  DKMS 
enables drivers to be automatically rebuilt when a new kernel is 
installed. 

the patch is based on my other patch "link ceph-client version to kernel 
version"

Changes:
* rewrote hole debian/ dir based on ipeth-dkms package
* added dkms.conf
* added dkms/ dir with pre/post scripts
* fixed build_upload_debian_package.sh for the new package name

get patch here:
http://chaschperli.ch/debian/ceph-client-standalone-dkms.patch

- Thomas

