From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: MDS failed to reconnect a kernel client with CIFS workload
Date: Tue, 13 Sep 2016 10:18:26 +0800
Message-ID: <2DBBE861-B155-44B3-8716-339012328FB8@redhat.com>
References: <FF8D83DAE5DF57468726B79904321E06251178CB@H3CMLB12-EX.srv.huawei-3com.com> <FF8D83DAE5DF57468726B79904321E06251180C0@H3CMLB12-EX.srv.huawei-3com.com> <FF8D83DAE5DF57468726B79904321E06251184E0@H3CMLB12-EX.srv.huawei-3com.com> <CAJ4mKGaH_G9XDXQFjgcWOTaQ_f2nJT8Ojn_n1rHUiBFhyznoXQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755010AbcIMCSe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 22:18:34 -0400
In-Reply-To: <CAJ4mKGaH_G9XDXQFjgcWOTaQ_f2nJT8Ojn_n1rHUiBFhyznoXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Xusangdi <xu.sangdi@h3c.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On Sep 13, 2016, at 07:56, Gregory Farnum <gfarnum@redhat.com> wrote:
> 
> On Wed, Sep 7, 2016 at 11:35 PM, Xusangdi <xu.sangdi@h3c.com> wrote:
>> Hi Cephers,
>> 
>> We encountered a problem when using CephFS + Samba, which fails the reconnection phase of MDS respawn.
>> Reproduce steps:
>> 1. kernel mount CephFS to a Samba server
>> 2. re-export the mount point by Samba
>> 3. connect to Samba server from a Windows 7 client, and copy a large file (4GB) to the shared directory
>> 4. during copy process, restart the active (and the only one) MDS
>> 5. MDS then gives up reconnecting to the kernel client after timeout
>> As a result, all client requests will hang for like forever :<
>> 
>> I did a few extra tests, which proved that this issue will not occur when using kernel client directly nor via
>> NFS re-export. From the syslog I found the following error (with dynamic debug enabled):
>> 
>> Sep  6 20:34:41 trusty81 kernel: [465858.676638] ceph: mds0 caps stale
>> Sep  6 20:34:41 trusty81 kernel: [465859.123780] ceph: mds0 reconnect start
>> Sep  6 20:34:41 trusty81 kernel: [465859.125113] ceph:  session ffff8801121f7000 state reconnecting
>> Sep  6 20:34:41 trusty81 kernel: [465859.126306] ceph:  counted 0 flock locks and 0 fcntl locks
>> Sep  6 20:34:41 trusty81 kernel: [465859.126349] ceph:  encoding 0 flock and 0 fcntl locksceph:  counted 1 flock locks and 0 fcntl locks
>> Sep  6 20:34:41 trusty81 kernel: [465859.128575] ceph:  encoding 1 flock and 0 fcntl locksceph:  Have unknown lock type 32
>> Sep  6 20:34:41 trusty81 kernel: [465859.129795] ceph: error -22 preparing reconnect for mds0
>> 
>> It looks like the CIFS workload generates an invalid lock type, but I’m not sure about this. Any suggestions?
> 
> That's pretty weird. Looks to me like it's just reading data out of
> the inode passed in, and that's somehow corrupted. Zheng, do you have
> any idea?

CIFS uses mandatory flock, which ceph does not support. the check in ceph_flock() is buddy. Fixed by https://github.com/ceph/ceph-client/commit/77309a116cbee5a3a29ccd63f8d80c127180d923

Regards
Yan, Zheng

> -Greg
> 
>> 
>> PS:
>> 1. Samba version: 4.3.9, kernel version: 3.19.0-25-generic
>> 2. I also tried a newer kernel (4.4.0-31-generic), but with no luck
>> Feb 11 11:41:52 xerus101 kernel: [  836.960441] ceph: mds0 reconnect start
>> Feb 11 11:41:52 xerus101 kernel: [  836.960494] ceph: error -22 preparing reconnect for mds0
>> 
>> Regards,
>> ---Sandy
>> 
>> -------------------------------------------------------------------------------------------------------------------------------------
>> 本邮件及其附件含有杭州华三通信技术有限公司的保密信息，仅限于发送给上面地址中列出
>> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
>> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
>> 邮件！
>> This e-mail and its attachments contain confidential information from H3C, which is
>> intended only for the person or entity whose address is listed above. Any use of the
>> information contained herein in any way (including, but not limited to, total or partial
>> disclosure, reproduction, or dissemination) by persons other than the intended
>> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
>> by phone or email immediately and delete it!

