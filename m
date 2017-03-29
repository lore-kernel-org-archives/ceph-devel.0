From: Willem Jan Withagen <wjw@digiware.nl>
Subject: ceph-fuse is working on FreeBSD
Date: Wed, 29 Mar 2017 18:08:24 +0200
Message-ID: <2133312b-b225-0060-bad8-f8aab4f4fcf7@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:37904 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752482AbdC2QIa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 29 Mar 2017 12:08:30 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 322B13C5F0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 18:08:27 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I needed some more skills to actually get everythingin place to get it
working. But in essence I have ceph-fuse running...

wjw# df | grep fuse
/dev/fuse 9168256790 203540395 8964716395 2%    /zfs/home/wjw/mnt/zfs
/dev/fuse 8241876992  60174336 8181702656 1%    /zfs/home/wjw/mnt/cephf

wjw# ls ~/mnt/cephfs/
wjw# touch ~/mnt/cephfs//test
wjw# ~/mnt/cephfs/
test

So we are slowly getting there....

--WjW

