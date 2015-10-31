From: Ning Yao <zay11022@gmail.com>
Subject: Re: pg scrub check problem
Date: Sun, 1 Nov 2015 00:59:04 +0800
Message-ID: <CALZt5jzc+ii1zF_Xyp78auVTqaCmeVEz23-FVCexTwBMsJ+Ysg@mail.gmail.com>
References: <000001d11164$7fa470a0$7eed51e0$@com>
	<alpine.DEB.2.00.1510281712280.1004@cobra.newdream.net>
	<563167B3.1040504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33958 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbJaQ7G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 12:59:06 -0400
Received: by wmff134 with SMTP id f134so31198379wmf.1
        for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2015 09:59:04 -0700 (PDT)
In-Reply-To: <563167B3.1040504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Sage Weil <sage@newdream.net>, changtao381 <changtao381@163.com>, ceph-devel <ceph-devel@vger.kernel.org>

> Good point.  In my previous response I did "echo garbage >
> ........./foo__head_7FC1F406__1" to corrupt a replica.

I think this may just happen when mixing O_DIRECT and buffer_io, which
may just happen in Newstore.
Or, inode content changes such as FileStore write "
........./foo__head_7FC1F406__1", then rm -f
........./foo__head_7FC1F406__1 and echo garbage >
........./foo__head_7FC1F406__1
Or, you just write 4bytes in object  ........./foo__head_7FC1F406__1
and echo > 4bytes data to  " ........./foo__head_7FC1F406__1", which
will lead to extent changed.
If the extent is already allocated and echo new content, you can read
out the modified data immediately
