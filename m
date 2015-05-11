From: Owen Synge <osynge@suse.com>
Subject: autodetecting init system.
Date: Mon, 11 May 2015 18:29:55 +0200
Message-ID: <5550D903.8000802@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:46868 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbEKQbU (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 11 May 2015 12:31:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear all,

Many init systems are used in linux now. Some ceph code needs to know
the init system. (I must admit I have not looked into Solaris, MacOS and
BSD and probably should have)

It would be nice to have one function that detects the init system

Since the init system can be specified in ceph and ceph-deploy
explicitly it seems to be its reasonable to fail clearly to detect init
system.

I see 4 ways I can see to detect init system.

(A) Check pid 1.
(B) Use a database of OS to init mapping / compile time.
(C) look for init manipulation tools and infure the init system from tools.

Comments:
~~~~~~~~

(A1) systmd can be detected easily with.

 grep -qs systemd /proc/1/comm

(A2) With init scripts such as its hard to know what the init system.

(B1) For operating systems like RHEL, SLE, CENTOS, Fedora and scientific
linux this works well.

(B2) FOr operating systems like newer debian and ubuntu releases more
than one init system can be installed and used on the OS, so making a
database / doing it at compile time are not practical on all OS's

(C1) This is fairly reliable.

(C2) sysV tools have compatibility scripts / programs on other platforms
so if you use a points system for each init system helper script you can
infure systemd over sysV if sytemctrl exists for example.

So to summarise this:
~~~~~~~~~~~~~~~~~~~~

(1) No one system is perfect in all cases.
(2) Combined these systesm can provide reliable init system detection.

My proposed approach.
~~~~~~~~~~~~~~~~~~~~

(I) Use all three approaches where each approach can provide and answer,
or fail to provide an answer.

(II) Should any approaches disagree -> fail to detect init system.

(III) Should all approaches agree -> then return init system.

(III) Should no approaches provide an init system -> fail to return init
system.

Comments
~~~~~~~~

This multi layered and comparing way of doing init systems may seem
complete overkill, or maybe its useful.

What do you guys think?

Best regards

Owen





