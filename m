From: Yasin Celik <yasincelik27@gmail.com>
Subject: Question about Storage Engine
Date: Thu, 31 Mar 2016 12:15:41 -0400
Message-ID: <CAK8MWPZjAcKZzbw1iMZbHAO2xctmfLhoeVmb_a=nvooZZv6-6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36510 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbcCaQQM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 12:16:12 -0400
Received: by mail-oi0-f48.google.com with SMTP id r187so67164920oih.3
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 09:16:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Team,

I want to use Ceph's Storage Engine Deamon or API. I am working on a
storage system in which I handle all the inode management,
replication, failure detection, management, and recover. I want to use
Ceph only as a tier between my system and physical hard drive. Is this
possible with ceph? Can I use it or part of it as only for storage? My
system is coded in Java, so I will be using Java API. I do not know it
this is the correct place to start:

master /api /libcephfs-java

Any comment, help is appreciated.

Thanks
Celik
