From: Sage Weil <sage@newdream.net>
Subject: re: ubuntu upstart hang due xfs mount hang
Date: Thu, 27 Oct 2016 15:10:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610271509180.14316@piezo.us.to>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314ECB05@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1588177292-1477581008=:14316"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33238 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938672AbcJ0PLA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 11:11:00 -0400
In-Reply-To: <7BD28126D6935A4498AE6DE60B5D4CAB314ECB05@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhangzengran <zhangzengran@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1588177292-1477581008=:14316
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Oct 2016, Zhangzengran wrote:
> >On Thu, 27 Oct 2016, Zhangzengran wrote:
> >> Hi Sage & all:
> >>   There is a data disk on ceph host with xfs, it’s EFIs corrupt in an
> >> unexpected power outage.when the host power on again, system(ubuntu)
> >> hang in upstart’s console, we learn that upstart try to do `ceph-disk activate-all` and mount that disk in ceph-osd-all series jobs,but the mount hang indefinite. there is also a S20ceph script called by rc series jobs,and the tty1.conf start on `stoped rc`,so we cant login from console.
> >>
> >> I saw there is a Patch for ceph-disk,it provided a timeout to mkfs.So
> >> I think,  do we also need to provide a timeout for mount?because if ceph-disk hang in upstart, no osd  daemon could start on that host.
> 
> >What version of ubuntu and Ceph is this? Since jewel we are all systemd, and the activate etc jobs are all async systemd tasks, so I don't think this should happen.
> 
> Ubuntu is 14.04, Ceph is Hammer 0.94.5

Ah.  This will all go away once you upgrade to jewel.  In the meantime, 
you can probably remove the S20 file.. though I don't think it should be 
doing anything anyway since you're using upstart.

sage

> 
> >> I have another question, could we move the S20ceph(init-ceph) script out of rcN.d in Ubuntu ? looks like it did not appear in RHEL’s rcN.d.
> 
> >Similarly, I think the sysvinit files should all be gone at this point...
> 
> >sage
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
> 
--8323329-1588177292-1477581008=:14316--
