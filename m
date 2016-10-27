From: Sage Weil <sage@newdream.net>
Subject: Re: ubuntu upstart hang due xfs mount hang
Date: Thu, 27 Oct 2016 14:39:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610271438290.14316@piezo.us.to>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314EC306@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1255675693-1477579171=:14316"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60921 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942843AbcJ0Ojc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 10:39:32 -0400
In-Reply-To: <7BD28126D6935A4498AE6DE60B5D4CAB314EC306@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhangzengran <zhangzengran@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1255675693-1477579171=:14316
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Oct 2016, Zhangzengran wrote:
> Hi Sage & all:
>   There is a data disk on ceph host with xfs, it’s EFIs corrupt in an unexpected power outage.when the host power on again, system(ubuntu) hang in upstart’s console,
> we learn that upstart try to do `ceph-disk activate-all` and mount that disk in ceph-osd-all series jobs,but the mount hang indefinite. there is also a S20ceph script called
> by rc series jobs,and the tty1.conf start on `stoped rc`,so we cant login from console.
> 
> I saw there is a Patch for ceph-disk,it provided a timeout to mkfs.So I think,  do we also need to provide a timeout for mount?because if ceph-disk hang in upstart, no osd
>  daemon could start on that host.

What version of ubuntu and Ceph is this? Since jewel we are all systemd, 
and the activate etc jobs are all async systemd tasks, so I don't think 
this should happen.

> I have another question, could we move the S20ceph(init-ceph) script out of rcN.d in Ubuntu ? looks like it did not appear in RHEL’s rcN.d.

Similarly, I think the sysvinit files should all be gone at this point...

sage
--8323329-1255675693-1477579171=:14316--
