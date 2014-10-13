From: Nicheal <zay11022@gmail.com>
Subject: WriteBack Throttle kill the performace of the disk
Date: Mon, 13 Oct 2014 18:18:38 +0800
Message-ID: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:59003 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbaJMKf7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 06:35:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id v63so5057451oia.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Oct 2014 03:35:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm currently finding that enable WritebackThrottle lead to lower IOPS
for large number of small io. Since WritebackThrottle calls
fdatasync(fd) to flush an object content to disk, large number of
ramdom small io always cause the WritebackThrottle to submit one or
two 4k io every time.
Thus, it is much slower than the global sync in
FileStore::sync_entry().  Note:: here, I use xfs as the FileStore
underlying filesystem. So I would know that if any impact when I
disable Writeback throttles. I cannot catch the idea on the website
(http://ceph.com/docs/master/dev/osd_internals/wbthrottle/).
Large number of inode will cause longer time to sync, but submitting a
batch of write to disk always faster than submitting few io update to
the disk.

Nicheal
