From: Sage Weil <sweil@redhat.com>
Subject: c++11 merged in master
Date: Fri, 7 Aug 2015 10:52:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33914 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945906AbbHGRwI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Aug 2015 13:52:08 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 77FE1A58B3
	for <ceph-devel@vger.kernel.org>; Fri,  7 Aug 2015 17:52:08 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: adeza@redhat.com

Yay!  Thanks, Casey!

This initially breaks the precise and el6 builds on master.  I've fixed 
the precise gitbuilders with

sudo apt-get install python-software-properties
echo | sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -y g++-4.8
/srv/autobuild-ceph/gitbuilder.git/build/install-deps.sh
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.6
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8
echo 2 | sudo update-alternatives --config gcc
sudo restart autobuild-ceph

We'll need to do something similar on centos6 to get g++ 4.7 or 4.8 in 
place, and the jenkins slaves for release builds will also need to be 
updated.

Assuming this doesn't cause problems (e.g., runtime issues on vanilla 
precise) this will have no bearing on the previous discussion about 
whether we continue supporting old distros for future releases.

sage
