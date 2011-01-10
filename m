From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [bug?] stat functions inconsistently
Date: Sun, 9 Jan 2011 17:45:12 -0800
Message-ID: <EE1B9791-D7B0-4518-A541-0F3A44C03BB1@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:38422 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab1AJBpN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Jan 2011 20:45:13 -0500
Received: from [192.168.51.138] (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id D01BB1009BFC
	for <ceph-devel@vger.kernel.org>; Sun,  9 Jan 2011 17:45:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am seeing what looks like inconsistent reporting by stat (2).

Below is the annotated trace that shows a successful stat of the
file "part-m-00001", and then later a failed stat of the same file.

This trace gathered with strace. The scenario can be fully reproduced, but so far
not with any exemplary, concise code; this trace comes deep from within Java.

Setup: two files exist under the Ceph mount point (/ceph):
    /ceph/ts5-in/part-m-00000
    /ceph/ts5-in/part-m-00001

Link to full trace: http://www.cs.ucsc.edu/~jayhawk/log2-full.txt.tar.gz

-------

(1) In the first part of the trace a thread successfully stats both files,
and performs an ioctl on both files:

--> 10941 stat("/ceph/ts5-in/part-m-00000", {st_mode=S_IFREG|0644, st_size=2500000, ...}) = 0
--> 10941 stat("/ceph/ts5-in/part-m-00001", {st_mode=S_IFREG|0644, st_size=2500000, ...}) = 0
10941 open("/ceph/ts5-in/part-m-00000", O_RDONLY) = 55
10941 ioctl(55, 0x80289701, 0x7fd7a7efd9e0) = 0
10941 ioctl(55, 0xc0f89703, 0x7fd7a7efda10) = 0
10941 close(55)                         = 0
10941 open("/ceph/ts5-in/part-m-00001", O_RDONLY) = 55
10941 ioctl(55, 0x80289701, 0x7fd7a7efd9e0) = 0
10941 ioctl(55, 0xc0f89703, 0x7fd7a7efda10) = 0
10941 close(55)                         = 0

...

(2) Later in the trace, a thread (10956) stats "part-m-00000" with success,
while the thread (10957) stats "part-m-00001" and fails with ENOENT.

10956 stat("/ceph/ts5-in/part-m-00000",  <unfinished ...>
10950 <... futex resumed> )             = 0
10957 write(2, "\n", 1)                 = 1
10950 gettimeofday({1294621240, 685789}, NULL) = 0
-->  10957 stat("/ceph/ts5-in/part-m-00001",  <unfinished ...>
10950 gettimeofday( <unfinished ...>
-->  10957 <... stat resumed> 0x7fd75db461f0) = -1 ENOENT (No such file or directory)
10956 <... stat resumed> {st_mode=S_IFREG|0644, st_size=2500000, ...}) = 0

Thanks,
Noah