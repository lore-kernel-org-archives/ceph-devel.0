From: Mark Meyers <MarkMeyers.MMY@gmail.com>
Subject: Re: [ceph-users] use and benifits of CEPH_IOC_SYNCIO flag
Date: Sat, 2 Sep 2017 13:58:23 +0000 (UTC)
Message-ID: <1176129766.1692338.1504360703322@mail.yahoo.com>
References: <105287461.1665463.1504358688546.ref@mail.yahoo.com> <105287461.1665463.1504358688546@mail.yahoo.com>
Reply-To: Mark Meyers <MarkMeyers.MMY@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sonic303-48.consmr.mail.ne1.yahoo.com ([66.163.188.174]:35952
        "EHLO sonic303-48.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752441AbdIBOCZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Sep 2017 10:02:25 -0400
In-Reply-To: <105287461.1665463.1504358688546@mail.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

More Details, the code is in kernel cephfs(path: linux-kernel-src/fs/ceph/ioctl.h), the flag will be judged when write from kernel cephfs.



On Saturday, September 2, 2017 9:29 PM, Mark Meyers <MarkMeyers.MMY@gmail.com> wrote:



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

_______________________________________________

ceph-users mailing list

ceph-users@lists.ceph.com

http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
