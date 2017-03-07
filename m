From: Nathan Cutler <ncutler@suse.cz>
Subject: Untested PRs merged to jewel before 10.2.6 release?
Date: Tue, 7 Mar 2017 22:38:52 +0100
Message-ID: <713de223-60a8-7def-5e59-c6c09b52dc06@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58747 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933439AbdCHBOw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Mar 2017 20:14:52 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA3B9ABCD
        for <ceph-devel@vger.kernel.org>; Tue,  7 Mar 2017 21:38:53 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I noticed that the v10.2.6 tag was added today and, as far as I can 
tell, it was added to the tip of the jewel branch. That would be fine, 
except that the tip of the jewel branch at the time the tag was added 
(420a9a0796e327676cb704bc18b2020f9941d7b6) is several PRs ahead of the 
jewel SHA1 that underwent integration testing 
(d9eaab456ff45ae88e83bd633f0c4efb5902bf07).

$ git log --oneline --no-merges 
d9eaab456ff45ae88e83bd633f0c4efb5902bf07..420a9a0796e327676cb704bc18b2020f9941d7b6
88f4895 qa/suites/upgrade/hammer-x: Add some volumes
0c242d1 qa/suites/ceph-deploy: Drop OpenStack volume count
ccd0265 qa: replace centos 7.2 with centos 7.3
2cbec5b Removed dumplin test 13234.yaml as not needed anymore
771e1d9 qa/suites/rest: Openstack volumes
a18640f qa/suites/ceph-ansible: Openstack volumes
841688b qa/suites/fs: Add openstack volume configuration
9778743 qa/suites/samba: Openstack volume configuration
cd1e8ef qa/suites/hadoop: Openstack volume configuration
ac7add1 qa/suites/knfs: Add openstack volume configuration
ba35859 qa/suites/kcephfs: Openstack volume configuration
aced718 qa/suites/krbd: Add openstack volume configuration
94d5888 qa/suites/rgw: Add openstack volume configuration

Am I seeing that right? If so, that appears to potentially defeat the 
purpose of the integration testing we do. Maybe I'm overstating the 
danger here -- the commits look innocuous enough -- but it seems to set 
a rather dangerous precedent.

Nathan
