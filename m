From: Mauricio Garavaglia <mauricio@medallia.com>
Subject: Fwd: Prevent rbd mapping/mounting on multiple hosts workaround
Date: Fri, 5 Feb 2016 11:24:14 -0300
Message-ID: <CAAVaRixPMWYibHFmmZmVgYB3RjPWaO2-gEhoyTnCHpBkkZjbgQ@mail.gmail.com>
References: <CAAVaRixeAPiyK2Xx1=nXAZBD=8ckctgFV=6Ag2EyTsAGhPrPUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:32861 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcBEOYp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 09:24:45 -0500
Received: by mail-lb0-f172.google.com with SMTP id x4so51256217lbm.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 Feb 2016 06:24:44 -0800 (PST)
In-Reply-To: <CAAVaRixeAPiyK2Xx1=nXAZBD=8ckctgFV=6Ag2EyTsAGhPrPUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

In the January Tech Talk (PostgreSQL on Ceph under Mesos/Aurora with
Docker [https://youtu.be/OqlC7S3cUKs]) we presented a challenge we are
facing at Medallia when running databases on ceph under
mesos/aurora/docker; which is related to prevent mapping/mounting the
same rbd image in two hosts at the same time during network
partitions.

As a workaround it was mentioned that we are wrapping rbd in a shell
script that executes extra logic around certain operations:

- On Map; rbd lock add <image>
        - If no success; then
                - "rbd status <image>": check for Watchers, 3 times each 15 secs
                        - If found, ABORT the mapping. The image is
still in use in a host that is healthy
                - "ceph osd blacklist add <previous lock holder>".
Image locked without a watcher
                - steal the lock in <image>
        - map the image

- On Unmap;
        - rbd lock remove

- On reboot of server;
        - "ceph osd blacklist rm <self>"

I was wondering if this mechanism could be incorporated as part of the
rbd CLI, of course controlled by an option during map. We'll be happy
to work on it, but want to check the feasibility of having the patch
accepted.


Mauricio Garavaglia
mauricio@medallia.com
