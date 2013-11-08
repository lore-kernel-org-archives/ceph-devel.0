From: Drunkard Zhang <gongfan193@gmail.com>
Subject: zero size file on cephfs
Date: Fri, 8 Nov 2013 10:36:54 +0800
Message-ID: <CAJiejCS_K2nKneJE9qXnRPH0uBJ8DrVaP+m1B5Ocp8jyDgNGuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45526 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352Ab3KHChQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 21:37:16 -0500
Received: by mail-oa0-f46.google.com with SMTP id i4so309044oah.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 18:37:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

Hi,
    I'm using cephfs for a while, it's great, but I found a serious pro=
blem now.

My situation is simple: a lot of servers receive syslog to local disk,
then mount ceph FS via kernel driver and move those received files to
ceph FS.

Some days ago, I found my script missed some file while processing
data, then I noticed those files' size is zero. But it's impossible,
rsyslog won't generate file until data arrives, so I logged the file
size before mv, so here's one example from these exceptions:

In log:
2013-11-07 18:17:29 /scripts/log/collector: file size: 4910689
/gwbn/nat/20131107/dnsquery-pb24-192.168.156.60-by_squid79-20131107_17.=
log

Zero size file on ceph FS:
-rw-r--r-- 1 root root     0 Jan  1  1970
dnsquery-pb24-192.168.156.60-by_squid79-20131107_17.log

stat dnsquery-pb24-192.168.156.60-by_squid79-20131107_17.log
  File: =E2=80=98dnsquery-pb24-192.168.156.60-by_squid79-20131107_17.lo=
g=E2=80=99
  Size: 0             Blocks: 0          IO Block: 4194304 regular empt=
y file
Device: 0h/0d    Inode: 1099518968218  Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root=
)
Access: 2013-11-07 17:00:00.167501860 +0800
Modify: 1970-01-01 08:00:00.000000000 +0800
Change: 2013-11-07 18:17:29.843558000 +0800
 Birth: -

I'm running multiple versions of kernel, scales from 3.8.x to 3.11.6.
Most of the zero file event occurs on those servers with kernel
version of 3.10.[45], some on 3.8.6 and 3.11.4, I didn't tested all of
them, these is my running versions.

I think the ceph FS kernel driver should sync before umount, isn't it
? So what can I do to shoot this problem down ? And any advice of
temparory solution to avoid this, manually sync?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
