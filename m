From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: ObjectRecoveryInfo size in recover
Date: Fri, 11 Mar 2016 11:32:07 +0800
Message-ID: <CANE=7sWioj8-sAJm_4gJ1amLALSx=ZTxPO-=sYGRKxsnkbW3Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33303 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933456AbcCKDcJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 22:32:09 -0500
Received: by mail-ob0-f174.google.com with SMTP id fz5so101517886obc.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 19:32:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

     When osd do recovery, the size of ObjectRecoveryInfo is different
between push logic and pull logic. One uses stat size, and the other
one uses object_info_t size.

    If I do not misread, the stat size == object_info_t size,
excluding ec case.

    Why we use different logic between them?


-- 
Regards,
Xinze Chi
