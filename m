From: "peng.hse" <peng.hse@xtaotech.com>
Subject: problems to protect rbd from mutiple simultaneous mapping
Date: Mon, 6 Mar 2017 22:08:51 +0800
Message-ID: <58BD6D73.6040200@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:17389 "EHLO
        mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdCFOP7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 09:15:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, jdurgin@redhat.com, ceph-devel@vger.kernel.org

Hi Sage,

the recommended way to protect rbd from multiple simultaneous mapping is 
just as the follows:

- identify old rbd lock holder
- blacklist old owner
- break the old rbd lock through "rbd lock remove"
- map rbd image on new host

However, i am wondering how do we handle the situation as the below 
timeline sequences:

  1. node1 locks the rbd image, doing the IO request, the IO is 
outstanding in the osds and
      not commit and reply to client yet

  2. node2 takes over the corresponding IO service due to some network 
partition issue,
      add node1 into the blacklist to all osds successfully and resume 
the IO.

3. assuming the step-1 outstanding IO and step-2 IO targeted the same 
area of the fs metadata
     on the rbd devices. step-2 successfully persist the data and reply 
to client.
     then, the following laggy IO from step-1 might override and corrupt 
what we have written in step-2.

so, how do we prevent this kind of corruption happening?

