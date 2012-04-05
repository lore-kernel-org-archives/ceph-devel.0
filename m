From: Feiyi Wang <fwang2@gmail.com>
Subject: ceph build error on leveldb
Date: Thu, 5 Apr 2012 13:58:16 -0400
Message-ID: <CACqFU2nJD1BgvuRBsFU_MBkGuEdUrjw=0Vir0NwbtMOhDY82Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39302 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab2DER6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 13:58:38 -0400
Received: by iagz16 with SMTP id z16so2061439iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Apr 2012 10:58:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi all

I am new to ceph and is trying to give it a spin for testing:
on both master or stable branch, the configure script gives the
WARNING (CentOS 6)


config.status: executing depfiles commands
config.status: executing libtool commands
=== configuring in src/leveldb (/home/fwang2/ceph/src/leveldb)
configure: WARNING: no configuration information is in src/leveldb

and the following make fails:

Making all in leveldb
make[3]: Entering directory `/mnt/hgfs/f7b/ceph/src/leveldb'
make[3]: *** No rule to make target `all'.  Stop

I cannot find any hints from README on how leveldb is supposed to be
configured or disabled ... I'd appreciate any help.


thanks

Feiyi
