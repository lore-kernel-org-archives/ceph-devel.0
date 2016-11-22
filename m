From: Igor Fedotov <ifedotov@mirantis.com>
Subject: uint32_t BlueStore::Extent::logical_offset?
Date: Tue, 22 Nov 2016 19:58:55 +0300
Message-ID: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35175 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbcKVQ67 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 11:58:59 -0500
Received: by mail-yw0-f181.google.com with SMTP id i145so19584669ywg.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 08:58:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,


I'm wondering why BlueStore::Extent::logical_offset is 32-bit wide.

IMHO it's to be uint64_t unless we limit onode size to 4Gb.

Looks like we have implicit truncate when doing set_lextent/new Extent 
at the moment and hence some issues with large onodes are possible.

Thanks,
Igor
