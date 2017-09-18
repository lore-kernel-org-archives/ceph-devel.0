From: Jin Cai <caijin.laurence@gmail.com>
Subject: Ceph RDMA module memory leakage
Date: Mon, 18 Sep 2017 13:48:31 +0800
Message-ID: <CAGRcXKbz61aLVwBbVK5CU9JWi0JW1c4nGDDLbiiZ+gau7drB8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:53892 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdIRFsd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 01:48:33 -0400
Received: by mail-lf0-f42.google.com with SMTP id k9so6778180lfe.10
        for <ceph-devel@vger.kernel.org>; Sun, 17 Sep 2017 22:48:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, haomai@xsky.com, adirl@mellanox.com

Hi, cephers
    We are testing the RDMA ms type of Ceph.
    The OSDs and MONs are always marked down by their peers because
they don't have enough buffer to use in the memory buffer pool to
reply the heartbeat ping message from their peers.           The log
always shows "no enough buffer in worker" even though the whole
cluster is idle without any I/Os from external.
