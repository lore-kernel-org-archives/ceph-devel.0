From: Abhishek <abhishek@suse.com>
Subject: v12.1.4 Luminous (RC) released
Date: Tue, 15 Aug 2017 23:05:06 +0200
Message-ID: <062fdb6f788298b7458db9d07ead19d2@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32789 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751068AbdHOVFI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 15 Aug 2017 17:05:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This is the fifth release candidate for Luminous, the next long term
stable release. We’ve had to do this release as there was a bug in
the previous RC, which affected upgrades to Luminous.[1]

Please note that this is still a *release candidate* and
not the final release, we're expecting the final Luminous release in
a week's time, meanwhile, testing and feedback is very much welcom.

Ceph Luminous (v12.2.0) will be the foundation for the next long-term
stable release series. There have been major changes since Kraken
(v11.2.z) and Jewel (v10.2.z), and the upgrade process is non-trivial.
Please read these release notes carefully. Full details and changelog at
http://ceph.com/releases/v12-1-4-luminous-rc-released/

Notable Changes from 12.1.3
---------------------------
* core: Wip 20985 divergent handling luminous (issue#20985, pr#17001, 
Greg Farnum)
* qa/tasks/thrashosds-health.yaml: ignore MON_DOWN (issue#20910, 
pr#17003, Sage Weil)
* crush, mon: fix weight set vs crush device classes (issue#20939, Sage 
Weil)


Getting Ceph
------------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.1.4.tar.gz
* For packages, see 
http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see 
http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release sha1: a5f84b37668fc8e03165aaf5cbb380c78e4deba4

[1]: http://tracker.ceph.com/issues/20985


Best Regards
Abhishek

