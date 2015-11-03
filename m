From: Mike <mike.almateia@gmail.com>
Subject: NIC with Erasure offload feature support and Ceph
Date: Tue, 3 Nov 2015 14:15:09 +0300
Message-ID: <5638973D.6090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34694 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbbKCLPM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Nov 2015 06:15:12 -0500
Received: by lfgh9 with SMTP id h9so13589289lfg.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Nov 2015 03:15:10 -0800 (PST)
Received: from mike.0xFFF ([185.51.156.255])
        by smtp.googlemail.com with ESMTPSA id g65sm4764392lfb.11.2015.11.03.03.15.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 03:15:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello!

In our project we planing build a petabayte cluster with Erasure pool.
Also we looking on Mellanox ConnectX-4 Lx EN Cards/ConnectX-4 EN Cards
for using its a offloading erasure code feature.

Someone use this feature in test lab/prodaction?


-- 
Mike, runs.

