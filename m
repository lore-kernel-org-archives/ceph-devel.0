From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: [ceph-users] v10.1.0 Jewel release candidate available
Date: Thu, 31 Mar 2016 15:20:36 +0800
Message-ID: <CAEYCsVLDodRJuDiAqvt0KAv5VF5=ujpM6r=48in9UGP4ebdenA@mail.gmail.com>
References: <alpine.DEB.2.11.1603281029290.6074@cpach.fuggernut.com>
	<aaegaupo3v.fsf@switch.ch>
	<CAEYCsVJPLv2X9Mj_eLzvFHvH6oZLwN80abCm-bM=-bCXcBJs_Q@mail.gmail.com>
	<CAC-Np1w8Lt+uPG9r7ZDGH7bC+ckRVmHTbGe5rG-ubkh=RNTNYg@mail.gmail.com>
	<CAEYCsVLxZTDuFx-9ZioDqk6ffG_wcciqiAADYKjiCi+79zAPkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33259 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcCaHUh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 03:20:37 -0400
Received: by mail-yw0-f194.google.com with SMTP id o63so10218348ywe.0
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 00:20:37 -0700 (PDT)
In-Reply-To: <CAEYCsVLxZTDuFx-9ZioDqk6ffG_wcciqiAADYKjiCi+79zAPkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Simon Leinen <simon.leinen@switch.ch>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

seems that was because the ceph-mds package doesn't get upgrade last
time(0.94.5 to 10.0.5)

root@slc5b03c-9efw:~# dpkg -l | grep ceph
ii  ceph                                   10.0.5-1trusty
     amd64        distributed storage and file system
ii  ceph-base                              10.0.5-1trusty
     amd64        common ceph daemon libraries and management tools
ii  ceph-common                            10.0.5-1trusty
     amd64        common utilities to mount and interact with a ceph
storage cluster
ii  ceph-fs-common                         10.0.5-1trusty
     amd64        common utilities to mount and interact with a ceph
file system
ii  ceph-fuse                              10.0.5-1trusty
     amd64        FUSE-based client for the Ceph distributed file
system
ii  ceph-mds                               0.94.5-1trusty
     amd64        metadata server for the ceph distributed file system
ii  ceph-mon                               10.0.5-1trusty
     amd64        monitor server for the ceph storage system
ii  ceph-osd                               10.0.5-1trusty
     amd64        OSD server for the ceph storage system
ii  libcephfs1                             10.0.5-1trusty
     amd64        Ceph distributed file system client library
ii  python-cephfs                          10.0.5-1trusty
     amd64        Python libraries for the Ceph libcephfs library

2016-03-31 15:08 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
> Thanks Alfredo.
>
> Upgrading from 10.0.5(2 weeks ago from 0.94.5 to 10.0.5, all looks
> good)  to 10.1.0 , getting error on apt-get upgrade ceph, seems like
> the cephfs-journal-tool conflict in "should be removed" 0.94.5 and
> 10.1.0
>
>
> Preparing to unpack .../ceph-common_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-common (10.1.0-1trusty) over (10.0.5-1trusty) ...
> dpkg: error processing archive
> /var/cache/apt/archives/ceph-common_10.1.0-1trusty_amd64.deb
> (--unpack):
>  trying to overwrite '/usr/bin/cephfs-journal-tool', which is also in
> package ceph-mds 0.94.5-1trusty
>
>
>
> full log is below
>
>
>
> oot@slc5b03c-1gtn:~# apt-get upgrade ceph
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> Calculating upgrade... Done
> The following packages were automatically installed and are no longer required:
>   linux-tools-3.13.0-59 linux-tools-3.13.0-59-generic
> Use 'apt-get autoremove' to remove them.
> The following NEW packages will be installed:
>   libfcgi0ldbl librgw2
> The following packages will be upgraded:
>   ceph ceph-base ceph-common ceph-fs-common ceph-fuse ceph-mds ceph-mon
>   ceph-osd libcephfs1 librados2 libradosstriper1 librbd1 python-cephfs
>   python-rados python-rbd
> 15 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
> Need to get 108 MB of archives.
> After this operation, 32.1 MB of additional disk space will be used.
> Do you want to continue? [Y/n] y
> Get:1 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main libradosstriper1 amd64 10.1.0-1trusty [2,693 kB]
> Get:2 http://installsvc.vip.slc.ebay.com/images/ubuntu/trusty-2016-01-20/
> trusty/main libfcgi0ldbl amd64 2.4.0-8.1ubuntu5 [161 kB]
> Get:3 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph-common amd64 10.1.0-1trusty [12.6 MB]
> Get:4 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main librbd1 amd64 10.1.0-1trusty [3,011 kB]
> Get:5 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main librados2 amd64 10.1.0-1trusty [2,619 kB]
> Get:6 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main librgw2 amd64 10.1.0-1trusty [3,616 kB]
> Get:7 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main python-rados amd64 10.1.0-1trusty [1,537 kB]
> Get:8 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main libcephfs1 amd64 10.1.0-1trusty [2,711 kB]
> Get:9 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main python-cephfs amd64 10.1.0-1trusty [1,171 kB]
> Get:10 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main python-rbd amd64 10.1.0-1trusty [1,184 kB]
> Get:11 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph-osd amd64 10.1.0-1trusty [10.9 MB]
> Get:12 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph-mon amd64 10.1.0-1trusty [3,553 kB]
> Get:13 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph-base amd64 10.1.0-1trusty [54.3 MB]
> Get:14 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph-mds amd64 10.1.0-1trusty [3,542 kB]
> Get:15 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph amd64 10.1.0-1trusty [975 kB]
> Get:16 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph-fs-common amd64 10.1.0-1trusty [996 kB]
> Get:17 http://installsvc.vip/images/ubuntu/ceph/debian-jewel/
> trusty/main ceph-fuse amd64 10.1.0-1trusty [2,698 kB]
> Fetched 108 MB in 1s (58.8 MB/s)
> (Reading database ... 139978 files and directories currently installed.)
> Preparing to unpack .../libradosstriper1_10.1.0-1trusty_amd64.deb ...
> Unpacking libradosstriper1 (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../ceph-common_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-common (10.1.0-1trusty) over (10.0.5-1trusty) ...
> dpkg: error processing archive
> /var/cache/apt/archives/ceph-common_10.1.0-1trusty_amd64.deb
> (--unpack):
>  trying to overwrite '/usr/bin/cephfs-journal-tool', which is also in
> package ceph-mds 0.94.5-1trusty
> dpkg-deb: error: subprocess paste was killed by signal (Broken pipe)
> Preparing to unpack .../librbd1_10.1.0-1trusty_amd64.deb ...
> Unpacking librbd1 (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../librados2_10.1.0-1trusty_amd64.deb ...
> Unpacking librados2 (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Selecting previously unselected package libfcgi0ldbl.
> Preparing to unpack .../libfcgi0ldbl_2.4.0-8.1ubuntu5_amd64.deb ...
> Unpacking libfcgi0ldbl (2.4.0-8.1ubuntu5) ...
> Selecting previously unselected package librgw2.
> Preparing to unpack .../librgw2_10.1.0-1trusty_amd64.deb ...
> Unpacking librgw2 (10.1.0-1trusty) ...
> Preparing to unpack .../python-rados_10.1.0-1trusty_amd64.deb ...
> Unpacking python-rados (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../libcephfs1_10.1.0-1trusty_amd64.deb ...
> Unpacking libcephfs1 (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../python-cephfs_10.1.0-1trusty_amd64.deb ...
> Unpacking python-cephfs (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../python-rbd_10.1.0-1trusty_amd64.deb ...
> Unpacking python-rbd (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../ceph-osd_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-osd (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../ceph-mon_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-mon (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../ceph-base_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-base (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../ceph-mds_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-mds (10.1.0-1trusty) over (0.94.5-1trusty) ...
> Preparing to unpack .../ceph_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../ceph-fs-common_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-fs-common (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Preparing to unpack .../ceph-fuse_10.1.0-1trusty_amd64.deb ...
> Unpacking ceph-fuse (10.1.0-1trusty) over (10.0.5-1trusty) ...
> Processing triggers for ureadahead (0.100.0-16) ...
> Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
> Errors were encountered while processing:
>  /var/cache/apt/archives/ceph-common_10.1.0-1trusty_amd64.deb
> E: Sub-process /usr/bin/dpkg returned an error code (1)
> You have new mail in /var/mail/root
>
> 2016-03-31 3:18 GMT+08:00 Alfredo Deza <adeza@redhat.com>:
>> On Wed, Mar 30, 2016 at 11:49 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>>> I am seeing package for precise in
>>> http://download.ceph.com/debian-jewel/dists/precise/,   is that
>>> by-accident or we plan to support precise for one more LTS?
>>
>> The configuration is there but there aren't any packages built for it:
>>
>> http://download.ceph.com/debian-jewel/pool/main/c/ceph/
>>
>> This is a side-effect of the readiness on our build system that will,
>> by default, allow other distros to be configured to get included
>> in the repo even if there aren't any actual binaries.
>>
>>
>>>
>>> Or, in other word, is it safe for user in precise to upgrade to jewel?
>>>
>>> 2016-03-29 0:24 GMT+08:00 Simon Leinen <simon.leinen@switch.ch>:
>>>> Sage Weil writes:
>>>>> The first release candidate for Jewel is now available!
>>>>
>>>> Cool!
>>>>
>>>> [...]
>>>>> Packages for aarch64 will also be posted shortly!
>>>>
>>>> According to the announcement, Ubuntu Xenial should now be supported
>>>> instead of Precise; but I don't see Xenial packages on
>>>> download.ceph.com.  Will those arrive, or should we get them from
>>>> Canonical's Xenial repo?
>>>> --
>>>> Simon.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
