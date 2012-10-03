From: Tren Blackburn <tren@eotnetworks.com>
Subject: mds cache size configuration option being ignored
Date: Wed, 3 Oct 2012 15:22:13 -0700
Message-ID: <CANLRBox7q8eJkJ8rKoyqrjdPLq7kjjqiMJx9MAdaSgCTtcmnog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45138 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342Ab2JCWWO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 18:22:14 -0400
Received: by ieak13 with SMTP id k13so18452114iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 15:22:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List;

I was advised to use the "mds cache size" option to limit the memory
that the mds process will take. I have it set to "32768". However it
the ceph-mds process is now at 50GB and still growing.

fern ceph # ps wwaux | grep ceph-mds
root       895  4.3 26.6 53269304 52725820 ?   Ssl  Sep28 312:29
/usr/bin/ceph-mds -i fern --pid-file /var/run/ceph/mds.fern.pid -c
/etc/ceph/ceph.conf

Have I specified the limit incorrectly? How far will it go?

Thanks in advance,

Tren
