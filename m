From: Tren Blackburn <tren@eotnetworks.com>
Subject: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 13:44:13 -0700
Message-ID: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54401 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab2ISUoP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 16:44:15 -0400
Received: by vbbff1 with SMTP id ff1so1783262vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 13:44:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey List;

I'm in the process of rsyncing in about 7TB of data to Ceph across
approximately 58565475 files (okay, so I guess that's not so
approximate). It's only managed to copy a small portion of this so far
(about 35GB) and the server that currently is the mds master shows the
ceph-mds process closing in on 2GB of RAM used. I'm getting a little
nervous about this steep increase.

fern ceph # ps wwaux | grep ceph-mds
root     29943  3.7  0.9 2473884 1915468 ?     Ssl  08:42  11:22
/usr/bin/ceph-mds -i 1 --pid-file /var/run/ceph/mds.1.pid -c
/etc/ceph/ceph.conf

Thank in advance!

t.
