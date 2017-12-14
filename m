From: Wido den Hollander <wido@42on.com>
Subject: Ceph Manager brag module
Date: Thu, 14 Dec 2017 10:24:24 +0100
Message-ID: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se07-out.mail.pcextreme.nl ([185.107.227.76]:42304 "EHLO
        se07-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750737AbdLNJYf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Dec 2017 04:24:35 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: lvaz@redhat.com

Hi,

After discussing with Sage I started to work [0] on a 'brag' module for 
Ceph Manager.

The intention of this module is to send (after a opt-in!) statistics 
about a Ceph cluster back to the project every few days.

My intention is to include:

- fsid (as identifier)
- number of MONs
- number of OSDs
- FileStore / BlueStore
- number of pools / PGs
- data used in bytes
- data free
- number of objects,
- version(s)

A admin can also say that the report is allowed to be 'public' where you 
can then visit (for example) https://brag.ceph.com/public/<fsid> and 
show off your Ceph cluster.

You could then add a description and we could compile top lists about 
Ceph systems.

How do people think about this? Would this be interesting?

I would try to convince most of my customers to send this information 
back to the project. The more information we get, the better Ceph can 
become.

Wido

[0]: https://github.com/wido/ceph/commits/mgr-brag
