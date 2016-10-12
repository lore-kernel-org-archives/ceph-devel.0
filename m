From: Wido den Hollander <wido@42on.com>
Subject: Possible corruption with MSSQL on RBD
Date: Wed, 12 Oct 2016 15:57:13 +0200 (CEST)
Message-ID: <262972897.5995.1476280634060@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:40259 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbcJLOV3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2016 10:21:29 -0400
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 39E4F761E1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 15:57:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I filed a issue in the tracker, but I'm looking for some feedback to diagnose this a bit further: http://tracker.ceph.com/issues/17545

The situation is that with a Firefly or Hammer (haven't tested Jewel yet) a MSSQL server running on RBD will sometimes complain about corruption.

Using SQLioSim we can reproduce the issue on a small Proxmox + Ceph cluster and after an hour or so it will yield:

Expected FileId: 0x0
Received FileId: 0x0
Expected PageId: 0xCB19C
Received PageId: 0xCB19A (does not match expected)
Received CheckSum: 0x9F444071
Calculated CheckSum: 0x89603EC9 (does not match expected)
Received Buffer Length: 0x2000

The issue only seems to happen with RBD caching enabled. When disabling the RBD cache or using cache=directsync we were not able to reproduce the issue.

When using LVM/file based backends for Qemu the problem also didn't pop up.

So this seems to be either a librbd issue or the RBD driver inside Qemu.

Any hints on how to debug this further to find the root cause?

Wido
