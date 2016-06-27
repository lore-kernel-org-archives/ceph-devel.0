From: Sage Weil <sweil@redhat.com>
Subject: cmake
Date: Mon, 27 Jun 2016 17:50:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44195 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcF0Rur (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Jun 2016 13:50:47 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 092417F6A5
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 17:50:47 +0000 (UTC)
Received: from ovpn-112-100.phx2.redhat.com (ovpn-112-100.phx2.redhat.com [10.3.112.100])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5RHojgp025724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 13:50:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We are switching from autotools to cmake on the master branch. Any 
builds done post-jewel will be cmake and not autotools based.  Jewel and 
older releases will still be built with autotools the old way.

The README.md in the master branch has been updated with new developer 
build instructions.  Please take a look:

	https://github.com/ceph/ceph/blob/master/README.md

If you are doing development, please switch to using cmake (i.e., 
run do_cmake.sh) now.  Running vstart.sh is a little different and it 
takes some getting used to.

If there is anything that doesn't work that is part of your developer 
workflow, we need to fix it now, before the autotools support is removed 
and you're unable to work!  This is hopefully a week or two away.

Current status:

 - gitbuilders mostly using make-dist instead of 'make dist' 
   (autotools) to generate release tarballs
 - wip-cmake-debian building debs with cmake
 - rpm coming shortly
 - release build tool update last, followed by a 11.0.0 release.

Thank you!
sage
