From: Andrey Korolyov <andrey@xdel.ru>
Subject: Paxos and long-lasting deleted data
Date: Thu, 31 Jan 2013 21:17:44 +0300
Message-ID: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:46055 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab3AaSSG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 13:18:06 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so3030137oag.1
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 10:18:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Please take a look, this data remains for days and seems not to be
deleted in future too:

pool name       category                 KB      objects       clones
   degraded      unfound           rd        rd KB           wr
wr KB
data            -                          0            0            0
           0           0            0            0            0
    0
install         -                   15736833         3856            0
           0           0           16            3       464648
60970390
metadata        -                          0            0            0
           0           0            0            0            0
    0
prod-rack0      -                  364027905        88895            0
           0           0           32            0       267626
689034186
rbd             -                    4194305         1027            0
           0           0            4            1        11269
25165828
  total used      6900914368        93778
  total avail    18335469376
  total space    25236383744

for pool in $(rados lspools) ; do rbd ls -l $pool ; done | grep -v
SIZE | awk '{ sum += $2} END { print sum }'
rbd: pool data doesn't contain rbd images
rbd: pool metadata doesn't contain rbd images
526360

I have same thing before, but not so contrast as there. Cluster was
put on moderate failure test, dropping one or two osds at once under
I/O pressure with replication factor three.
