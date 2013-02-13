From: femi anjorin <femi.anjorin@gmail.com>
Subject: optimizing ceph-fuse performance
Date: Wed, 13 Feb 2013 13:31:17 +0100
Message-ID: <CAPhYxPzLpw5H9W4LxCaWWeOPRYwVsSJb7h1OgQzswbCMT9S_xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:57556 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3BMMbR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 07:31:17 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so1185056oag.7
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 04:31:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Pls can somebody help interprete what this configuration signify.

[global]
        debug ms = 0

[mon]
        debug mon = 20
        debug paxos = 20
        debug auth = 20

[osd]
        debug osd = 20
        debug filestore = 20
        debug journal = 20
        debug monc = 20

[mds]
        debug mds = 20
        debug mds balancer = 20
        debug mds log = 20
        debug mds migrator = 20


 I used the same configuration and my boot disk got full

ceph-mds.a.log =  50299281408
ceph-mon.a.log = 173858816

Moreover the results of my test using ceph-fuse to mount a share and
exportiing the share with samba isn't so good... How can i turn off
some of the logs to optimize ceph performance in a write,read and
delete operations. I will publish the result as soon as i can get the
cluster more optimized.


regards.
