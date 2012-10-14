From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: OSD::mkfs: couldn't mount FileStore: error -22
Date: Mon, 15 Oct 2012 09:19:35 +1000
Message-ID: <k5fha7$h3l$1@ger.gmane.org>
References: <k5dqro$s4d$1@ger.gmane.org> <507B2E71.4040706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40376 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab2JNXTw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Oct 2012 19:19:52 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TNXTP-0002yo-2Z
	for ceph-devel@vger.kernel.org; Mon, 15 Oct 2012 01:19:55 +0200
Received: from 124-170-67-40.dyn.iinet.net.au ([124.170.67.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 01:19:55 +0200
Received: from a.nielsen by 124-170-67-40.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 01:19:55 +0200
In-Reply-To: <507B2E71.4040706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> The immediate cause of the problem is that the osd's "commit_op_seq" file is
> reading back '0',
> which is invalid; it's created with an initial value of 1.  Try removing the
> osd data dir
> (/var/lib/ceph/osd/ceph-0) completely and let it be recreated; perhaps
> something got there somehow by mistake.

Well it looks like commit_op_seq was never created properly:

$ ls /var/lib/ceph/osd/ceph-0/current/
total 4.0K
drwxr-xr-x 1 root root 26 Oct 14 17:40 .
drwxrwx--- 1 root root 74 Oct 14 17:40 ..
-rw-r--r-- 1 root root  0 Oct 14 17:40 commit_op_seq

But how do I delete it to start again?

$ rm -rf current/
rm: cannot remove `current': Directory not empty
$ ls current/
total 4.0K
drwxr-xr-x 1 root root  0 Oct 15 09:16 .
drwxrwx--- 1 root root 26 Oct 15 09:16 ..

This is on a brand new btrfs filesystem mounted in /var/lib/ceph/osd/ceph-0. 
I created it with this:

$ mkfs.btrfs -L data -s 4096 /dev/sda1

Did I do something wrong?

Thanks,
Adam.


