From: Ramana Raja <rraja@redhat.com>
Subject: help unblock CephFS/Manila CI
Date: Mon, 14 Nov 2016 01:39:48 -0500 (EST)
Message-ID: <2036507714.14884454.1479105588795.JavaMail.zimbra@redhat.com>
References: <1636748406.14877195.1479103166505.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:49788 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbcKNGjt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 01:39:49 -0500
Received: from zmail15.collab.prod.int.phx2.redhat.com (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
        by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id uAE6dngR004683
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 01:39:49 -0500
In-Reply-To: <1636748406.14877195.1479103166505.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

OpenStack Manila's cephfs-native driver CI is broken [1]
due to http://tracker.ceph.com/issues/17816

The commit 427f357f0eed32c9ce17590ae9303a94e8b710e7 fixed the
issue in Jewel four days ago. It's included in the latest Jewel
packages created by  gitbuilder for trusty [2] but not for
xenial [3], which is used by the cephfs-native driver CI [4]. 

Any help to include the fix in gitbuilder's Jewel packages
for xenial to unblock the  CephFS/Manila CI would be great.
Also, it'd be nice to know why gitbuilder picked up the fix
for trusty packages but not for xenial.

Thanks,
Ramana

[1] https://bugs.launchpad.net/devstack-plugin-ceph/+bug/1640256
[2] http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/ref/jewel/sha1
[3] http://gitbuilder.ceph.com/ceph-deb-xenial-x86_64-basic/ref/jewel/sha1
[4] http://logs.openstack.org/61/394961/3/check/gate-manila-tempest-dsvm-cephfs-native-ubuntu-xenial-nv/ed528f4/logs/devstacklog.txt.gz#_2016-11-13_13_19_35_327
