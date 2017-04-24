From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Ceph Package Repo on Ubuntu Precise(12.04) is broken
Date: Mon, 24 Apr 2017 11:35:46 +0800
Message-ID: <CAEYCsVL3SAwAr26nVFJcZqwXJM2skj5AztFSj15VRGQXvRrEvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:32921 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164478AbdDXDfs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Apr 2017 23:35:48 -0400
Received: by mail-yw0-f182.google.com with SMTP id 203so69121331ywe.0
        for <ceph-devel@vger.kernel.org>; Sun, 23 Apr 2017 20:35:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi,

     The 0.94.10 packages were not build for Ubuntu Precise, till now.
What is worse, the dist discription
(http://download.ceph.com/debian-hammer/dists/precise/main/binary-amd64/Packages)
 doesnt contains any ceph core pacages.

     It make Precise user unable provision their ceph cluster/client.
Could anyone pls help to fix it?

Xiaoxi
