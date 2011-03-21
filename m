From: Qian Wei <hzqianwei@gmail.com>
Subject: a problem about installion ceph on Centos 5.5
Date: Mon, 21 Mar 2011 15:25:17 +0800
Message-ID: <AANLkTimhLyAWkFJV8wZvNmQ+_fzb9fhkL6rFmLaa2oBL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53214 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1CUHZT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 03:25:19 -0400
Received: by vws1 with SMTP id 1so5002519vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 00:25:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

recently ,I install everyting about ceph on one centos-5.5 machine
meet a problem:

[root@ceph86 /]# mount -t ceph 10.65.1.86:/ /mnt/ceph
mount: wrong fs type, bad option, bad superblock on 10.65.1.86:/,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

[root@ceph86 /]# dmesg -c
libceph: no secret set (for auth_x protocol)
libceph: error -22 on auth protocol 2 init


about software version:

linux kernel is 2.6.37 , I choose build in btrfs and ceph in kernel
btrfs-progs-0.19.tar.gz
ceph-0.24
operation system is i386

Can you help me ?
