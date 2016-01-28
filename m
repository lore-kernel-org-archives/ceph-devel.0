From: huang jun <hjwsm1989@gmail.com>
Subject: how to debug librados/librbd in logfile
Date: Thu, 28 Jan 2016 22:33:10 +0800
Message-ID: <CABAwU-YLhiSdD8cbZWHC=8cBeNi_UM2rp3XpJefwWsiszwv6ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35107 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbcA1OdM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 09:33:12 -0500
Received: by mail-lf0-f48.google.com with SMTP id c192so28014180lfe.2
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jan 2016 06:33:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
I want to get debug log when using librados/librbd,
set client section in ceph.conf:
[client]
debug_rbd = 20
debug_objecter = 20
log_file = /var/log/ceph/ceph.rbd.log

that not work, file "/var/log/ceph/ceph.rbd.log" does not exist at all.
Any ideas?

-- 
thanks
huangjun
