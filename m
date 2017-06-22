From: Willem Jan Withagen <wjw@digiware.nl>
Subject: FreeBSD: Fwd: Build failed in Jenkins: ceph-master #859
Date: Thu, 22 Jun 2017 11:34:01 +0200
Message-ID: <d9614ba9-0697-4973-2557-79728dce51cf@digiware.nl>
References: <579558013.5.1498120960452.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43485 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751999AbdFVJeL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Jun 2017 05:34:11 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 5B56037CBB
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jun 2017 11:33:58 +0200 (CEST)
In-Reply-To: <579558013.5.1498120960452.JavaMail.jenkins@cephdev.digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I'm tempted to say that I did not change any of this code in a while,
but that is always a dangerous thought.
None the less I'm getting repeatedly this error:
In osd-scrub-repair.sh:
====
/home/jenkins/workspace/ceph-master/qa/workunits/ceph-helpers.sh:680:
activate_osd:  CEPH_ARGS='--fsid=8b1d102e-5726-11e7-9fab-179ac8daec65
--auth-supported=none --mon-host=127.0.0.1:7107
--osd-failsafe-full-ratio=.99 --osd-journal-size=100
--osd-scrub-load-threshold=2000 --osd-data=td/osd-scrub-repair/0
--chdir=
--erasure-code-dir=/home/jenkins/workspace/ceph-master/build/lib
--plugin-dir=/home/jenkins/workspace/ceph-master/build/lib
--osd-class-dir=/home/jenkins/workspace/ceph-master/build/lib
--run-dir=td/osd-scrub-repair --debug-osd=20
--log-file=td/osd-scrub-repair/$name.log
--pid-file=td/osd-scrub-repair/$name.pid --osd-max-object-name-len 460
--osd-max-object-namespace-len 64 --osd-scrub-auto-repair=true
--osd-deep-scrub-interval=5 --osd-scrub-max-interval=5
--osd-scrub-min-interval=5 --osd-scrub-interval-randomize-ratio=0 '
/home/jenkins/workspace/ceph-master/qa/workunits/ceph-helpers.sh:680:
activate_osd:  ceph-disk --statedir=td/osd-scrub-repair
--sysconfdir=td/osd-scrub-repair --prepend-to-path= activate
--mark-init=none td/osd-scrub-repair/0
got monmap epoch 1
ceph-disk: Error: ['ceph-osd', '--cluster', 'ceph', '--mkfs', '--mkkey',
'-i', u'0', '--monmap', 'td/osd-scrub-repair/0/activate.monmap',
'--osd-data', 'td/osd-scrub-repair/0', '--osd-uuid',
u'ae31285a-6242-4357-9e06-c8592bafaf50', '--keyring',
'td/osd-scrub-repair/0/keyring', '--setuser', 'root', '--setgroup',
'root'] failed : ignoring --setuser root since I am not root
ignoring --setgroup root since I am not root
2017-06-22 10:42:40.061105 cb92000 -1 unable to create object store
====

And ceph-osd is correct:
It does not run as root, and should not start daemons for ceph as root.
In this case it should start then under the running process owner:
jenkins. (which cannot sudo, if only for security)

So anybody a clue on what might have changed?

--WjW


