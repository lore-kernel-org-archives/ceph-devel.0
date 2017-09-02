From: Mark Meyers <MarkMeyers.MMY@gmail.com>
Subject: use and benifits of CEPH_IOC_SYNCIO flag
Date: Sat, 2 Sep 2017 13:24:48 +0000 (UTC)
Message-ID: <105287461.1665463.1504358688546@mail.yahoo.com>
References: <105287461.1665463.1504358688546.ref@mail.yahoo.com>
Reply-To: Mark Meyers <MarkMeyers.MMY@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sonic307-37.consmr.mail.ne1.yahoo.com ([66.163.190.60]:40215
        "EHLO sonic307-37.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752401AbdIBN2u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Sep 2017 09:28:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi:
               I want to ask a question about CEPH_IOC_SYNCIO flag.

        I know that when using O_SYNC flag or O_DIRECT flag, write call executes in other two code paths different than using CEPH_IOC_SYNCIO flag.
               And I find the comments about CEPH_IOC_SYNCIO here:

        /*
                 * CEPH_IOC_SYNCIO - force synchronous IO
                 *
                 * This ioctl sets a file flag that forces the synchronous IO that
                 * bypasses the page cache, even if it is not necessary.  This is
                 * essentially the opposite behavior of IOC_LAZYIO.  This forces the
                 * same read/write path as a file opened by multiple clients when one
         * or more of those clients is opened for write.
                 *
                 * Note that this type of sync IO takes a different path than a file
         * opened with O_SYNC/D_SYNC (writes hit the page cache and are
                 * immediately flushed on page boundaries).  It is very similar to
                 * O_DIRECT (writes bypass the page cache) except that O_DIRECT writes
                 * are not copied (user page must remain stable) and O_DIRECT writes
                 * have alignment restrictions (on the buffer and file offset).
                 */
                #define CEPH_IOC_SYNCIO _IO(CEPH_IOCTL_MAGIC, 5)

My question is: 

         "This forces the same read/write path as a file opened by multiple clients when one or more of those clients is opened for write." 

         Does this mean multiple clients can execute in the same code path when they all use the CEPH_IOC_SYNCIO flag? 

         Will the use of CEPH_IOC_SYNCIO in all clients bring effects such as coherency and performance?

         Thanks for your reading. I will wait for your rely, thanks!


Best Regards
Mark Meyers
