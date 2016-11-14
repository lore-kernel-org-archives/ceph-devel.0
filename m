From: Ramana Raja <rraja@redhat.com>
Subject: Re: help unblock CephFS/Manila CI
Date: Mon, 14 Nov 2016 04:55:30 -0500 (EST)
Message-ID: <1141294993.14930447.1479117330885.JavaMail.zimbra@redhat.com>
References: <2036507714.14884454.1479105588795.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:40288 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbcKNJzd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 04:55:33 -0500
Received: from zmail15.collab.prod.int.phx2.redhat.com (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
        by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uAE9tW6g046877
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 04:55:32 -0500
In-Reply-To: <2036507714.14884454.1479105588795.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Monday, November 14, 2016 Ramana Raja <rraja@redhat.com> wrote:
> Hi,
> 
> OpenStack Manila's cephfs-native driver CI is broken [1]
> due to http://tracker.ceph.com/issues/17816
> 
> The commit 427f357f0eed32c9ce17590ae9303a94e8b710e7 fixed the
> issue in Jewel four days ago. It's included in the latest Jewel
> packages created by  gitbuilder for trusty [2] but not for
> xenial [3], which is used by the cephfs-native driver CI [4].
> 
> Any help to include the fix in gitbuilder's Jewel packages
> for xenial to unblock the  CephFS/Manila CI would be great.
> Also, it'd be nice to know why gitbuilder picked up the fix
> for trusty packages but not for xenial.

Loic pointed out that the latest Jewel packages for xenial were
not being built by gitbuilder due to device running out of space.

Created an issue http://tracker.ceph.com/issues/17890 at
http://tracker.ceph.com/projects/lab

-Ramana

> 
> Thanks,
> Ramana
> 
> [1] https://bugs.launchpad.net/devstack-plugin-ceph/+bug/1640256
> [2] http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/ref/jewel/sha1
> [3] http://gitbuilder.ceph.com/ceph-deb-xenial-x86_64-basic/ref/jewel/sha1
> [4]
> http://logs.openstack.org/61/394961/3/check/gate-manila-tempest-dsvm-cephfs-native-ubuntu-xenial-nv/ed528f4/logs/devstacklog.txt.gz#_2016-11-13_13_19_35_327
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
