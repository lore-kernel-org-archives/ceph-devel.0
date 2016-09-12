From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: MDS failed to reconnect a kernel client with CIFS workload
Date: Mon, 12 Sep 2016 16:56:33 -0700
Message-ID: <CAJ4mKGaH_G9XDXQFjgcWOTaQ_f2nJT8Ojn_n1rHUiBFhyznoXQ@mail.gmail.com>
References: <FF8D83DAE5DF57468726B79904321E06251178CB@H3CMLB12-EX.srv.huawei-3com.com>
 <FF8D83DAE5DF57468726B79904321E06251180C0@H3CMLB12-EX.srv.huawei-3com.com> <FF8D83DAE5DF57468726B79904321E06251184E0@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:33224 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbcILX4f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2016 19:56:35 -0400
Received: by mail-ua0-f176.google.com with SMTP id v13so2439690uav.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2016 16:56:34 -0700 (PDT)
In-Reply-To: <FF8D83DAE5DF57468726B79904321E06251184E0@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>, Zheng Yan <zyan@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 7, 2016 at 11:35 PM, Xusangdi <xu.sangdi@h3c.com> wrote:
> Hi Cephers,
>
> We encountered a problem when using CephFS + Samba, which fails the reconnection phase of MDS respawn.
> Reproduce steps:
> 1. kernel mount CephFS to a Samba server
> 2. re-export the mount point by Samba
> 3. connect to Samba server from a Windows 7 client, and copy a large file (4GB) to the shared directory
> 4. during copy process, restart the active (and the only one) MDS
> 5. MDS then gives up reconnecting to the kernel client after timeout
> As a result, all client requests will hang for like forever :<
>
> I did a few extra tests, which proved that this issue will not occur when using kernel client directly nor via
> NFS re-export. From the syslog I found the following error (with dynamic debug enabled):
>
> Sep  6 20:34:41 trusty81 kernel: [465858.676638] ceph: mds0 caps stale
> Sep  6 20:34:41 trusty81 kernel: [465859.123780] ceph: mds0 reconnect start
> Sep  6 20:34:41 trusty81 kernel: [465859.125113] ceph:  session ffff8801121f7000 state reconnecting
> Sep  6 20:34:41 trusty81 kernel: [465859.126306] ceph:  counted 0 flock locks and 0 fcntl locks
> Sep  6 20:34:41 trusty81 kernel: [465859.126349] ceph:  encoding 0 flock and 0 fcntl locksceph:  counted 1 flock locks and 0 fcntl locks
> Sep  6 20:34:41 trusty81 kernel: [465859.128575] ceph:  encoding 1 flock and 0 fcntl locksceph:  Have unknown lock type 32
> Sep  6 20:34:41 trusty81 kernel: [465859.129795] ceph: error -22 preparing reconnect for mds0
>
> It looks like the CIFS workload generates an invalid lock type, but I’m not sure about this. Any suggestions?

That's pretty weird. Looks to me like it's just reading data out of
the inode passed in, and that's somehow corrupted. Zheng, do you have
any idea?
-Greg

>
> PS:
> 1. Samba version: 4.3.9, kernel version: 3.19.0-25-generic
> 2. I also tried a newer kernel (4.4.0-31-generic), but with no luck
> Feb 11 11:41:52 xerus101 kernel: [  836.960441] ceph: mds0 reconnect start
> Feb 11 11:41:52 xerus101 kernel: [  836.960494] ceph: error -22 preparing reconnect for mds0
>
> Regards,
> ---Sandy
>
> -------------------------------------------------------------------------------------------------------------------------------------
> 本邮件及其附件含有杭州华三通信技术有限公司的保密信息，仅限于发送给上面地址中列出
> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
> 邮件！
> This e-mail and its attachments contain confidential information from H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!
