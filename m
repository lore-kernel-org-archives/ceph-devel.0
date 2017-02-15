From: Wido den Hollander <wido@42on.com>
Subject: Supplying ID to ceph-disk when creating OSD
Date: Wed, 15 Feb 2017 17:59:16 +0100 (CET)
Message-ID: <1907009558.10080.1487177956475@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:41215 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdBOQ70 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 11:59:26 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id CDB2D3FD03
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 17:59:16 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Currently we can supply a OSD UUID to 'ceph-disk prepare', but we can't provide a OSD ID.

With BlueStore coming I think the use-case for this is becoming very valid:

1. Stop OSD
2. Zap disk
3. Re-create OSD with same ID and UUID (with BlueStore)
4. Start OSD

This allows for a in-place update of the OSD without modifying the CRUSHMap. For the cluster's point of view the OSD goes down and comes back up empty.

There were some drawbacks around this and some dangers, so before I start working on a PR for this, any gotcaches which might be a problem?

The idea is that users have a very simple way to re-format a OSD in-place while keeping the same CRUSH location, ID and UUID.

Wido
