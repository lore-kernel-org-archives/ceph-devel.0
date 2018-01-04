From: Matt Benjamin <mbenjami@redhat.com>
Subject: Fwd: aio poll, io_pgetevents and a new in-kernel poll API
Date: Thu, 4 Jan 2018 08:28:11 -0500
Message-ID: <CAKOnarnWD3sEuQKeKtGzuh-HuvuRgHs49u0WX78ZUp8fyicp4A@mail.gmail.com>
References: <20180104080043.14506-1-hch@lst.de> <846305254.12.1515072390525.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:40933 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeADN2N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 08:28:13 -0500
Received: by mail-io0-f171.google.com with SMTP id v30so2204547iov.7
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 05:28:13 -0800 (PST)
In-Reply-To: <846305254.12.1515072390525.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

For folks not subscribed to linux-aio (most?)

Matt

---------- Forwarded message ----------
From: Matt W. Benjamin <matt@cohortfs.com>
Date: Thu, Jan 4, 2018 at 8:26 AM
Subject: Fwd: aio poll, io_pgetevents and a new in-kernel poll API
To: mbenjamin <mbenjamin@redhat.com>



----- Forwarded Message -----
From: "Christoph Hellwig" <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: "Avi Kivity" <avi@scylladb.com>, linux-aio@kvack.org,
linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
linux-kernel@vger.kernel.org
Sent: Thursday, January 4, 2018 3:00:12 AM
Subject: aio poll, io_pgetevents and a new in-kernel poll API

Hi all,

this series adds support for the IOCB_CMD_POLL operation to poll for the
readyness of file descriptors using the aio subsystem.  The API is based
on patches that existed in RHAS2.1 and RHEL3, which means it already is
supported by libaio.  To implement the poll support efficiently new
methods to poll are introduced in struct file_operations:  get_poll_head
and poll_mask.  The first one returns a wait_queue_head to wait on
(lifetime is bound by the file), and the second does a non-blocking
check for the POLL* events.  This allows aio poll to work without
any additional context switches, unlike epoll.

To make the interface fully useful a new io_pgetevents system call is
added, which atomically saves and restores the signal mask over the
io_pgetevents system call.  It it the logical equivalent to pselect and
ppoll for io_pgetevents.

The corresponding libaio changes for io_pgetevents support and
documentation, as well as a test case will be posted in a separate
series.

The changes were sponsored by Scylladb, and improve performance
of the seastar framework up to 10%, while also removing the need
for a privileged SCHED_FIFO epoll listener thread.

The patches are on top of Als __poll_t annoations, so I've also
prepared a git branch on top of those here:

    git://git.infradead.org/users/hch/vfs.git aio-poll

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll

Libaio changes:

    http://git.infradead.org/users/hch/libaio.git/shortlog/refs/heads/aio-poll

Seastar changes:

    https://github.com/avikivity/seastar/commits/aio

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

--
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689
fax.  734-769-8938
cel.  734-216-5309


-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
