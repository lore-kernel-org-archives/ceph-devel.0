From: Konstantin Danilov <kdanilov@mirantis.com>
Subject: Block storage performance test tool - would like to merge into cbt
Date: Sat, 11 Jul 2015 11:02:51 +0300
Message-ID: <CACxKWazeKFOoebysNJ4XajwEmBf2kk6Asw0WVAAKLo=hCp32sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35005 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbbGKICw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jul 2015 04:02:52 -0400
Received: by labgy5 with SMTP id gy5so124610857lab.2
        for <ceph-devel@vger.kernel.org>; Sat, 11 Jul 2015 01:02:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

We(Mirantis ceph team) have a tool for block storage performance test,
called 'wally' -
https://github.com/Mirantis/disk_perf_test_tool.

It has some nice features, like:

* Openstack and FUEL integration (can spawn VM for tests, gather HW info, etc)
* Set of tests, joined into suit, which measures different performnce
aspects and
creates joined report, as example -
http://koder-ua.github.io/6.1GA/cinder_volume_iscsi.html,
VM running on ceph drives report example -
http://koder-ua.github.io/random/ceph_example.html
* Data postrocessing - confidence intervals, etc

We would like to merge our code into cbt. Do you interesting in it?
Can we discuss a way to merge?

Thanks

-- 
Kostiantyn Danilov aka koder.ua
Principal software engineer, Mirantis

skype:koder.ua
http://koder-ua.blogspot.com/
http://mirantis.com
