From: Max Yehorov <myehorov@skytap.com>
Subject: rbd object map
Date: Thu, 6 Aug 2015 23:13:44 -0700
Message-ID: <CAJDfis=dmeWAnKCbK-jvoA2WHGAuzkUR_f2gLRuDOJKs=04U_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:32802 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbbHGGOP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 02:14:15 -0400
Received: by wijp15 with SMTP id p15so47680638wij.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 23:14:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Object map feature was added in hammer. It is possible to create and
delete an image with object map enabled using rbd, though it is not
possible to map the image which has object map or exclusive lock
features enabled, e.g.:

  ceph@ceph1:~$ rbd create foo --size=42 --image-format=2 --image-features=15
  ceph@ceph1:~$ sudo rbd map foo
  rbd: sysfs write failed
  rbd: map failed: (6) No such device or address


I checked rbd.c in linux/drivers/block/rbd.c, it looks like that it
only supports layering and striping as of kernel 4.1 branch.

  #define RBD_FEATURE_LAYERING    (1<<0)
  #define RBD_FEATURE_STRIPINGV2  (1<<1)
  #define RBD_FEATURES_ALL \
        (RBD_FEATURE_LAYERING | RBD_FEATURE_STRIPINGV2)

  /* Features supported by this (client software) implementation. */

  #define RBD_FEATURES_SUPPORTED  (RBD_FEATURES_ALL)

Is object map a partial feature in hammer? If so, will there be a
complete support of object map in some upcoming ceph release?
