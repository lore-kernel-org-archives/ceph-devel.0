From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Tue, 15 Dec 2015 09:51:17 -0700
Message-ID: <CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
	<CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34495 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbbLOQvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 11:51:18 -0500
Received: by mail-qk0-f173.google.com with SMTP id p187so22280646qkd.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Dec 2015 08:51:17 -0800 (PST)
In-Reply-To: <CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>, spray@redhat.com, mchristi@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I have opened ticket: 14086

On Tue, Dec 15, 2015 at 5:05 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Tue, Dec 15, 2015 at 2:08 PM, Eric Eastman
>> [Tue Dec 15 00:46:55 2015] ------------[ cut here ]------------
>> [Tue Dec 15 00:46:55 2015] WARNING: CPU: 0 PID: 1123421 at
>> /home/kernel/COD/linux/fs/ceph/addr.c:125
>
> could you confirm that addr.c:125 is WARN_ON(!PageLocked(page));

I am using the generic kernel from:
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.4-rc4-wily
and assuming they did not change anything, from the 4.4rc4 source tree
I pulled down shows:

124         ret = __set_page_dirty_nobuffers(page);
125         WARN_ON(!PageLocked(page));
126         WARN_ON(!page->mapping);


modinfo ceph
filename:       /lib/modules/4.4.0-040400rc4-generic/kernel/fs/ceph/ceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
alias:          fs-ceph
srcversion:     E94BA78C2D998705FE2C600
depends:        libceph,fscache
intree:         Y
vermagic:       4.4.0-040400rc4-generic SMP mod_unload modversions

This error has shown up about 20 times in 12 hours, since I started
the ESXi test.

Thanks,
Eric
