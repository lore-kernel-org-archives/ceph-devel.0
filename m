From: "xan.peng" <xanpeng@gmail.com>
Subject: Re: A problem with ceph-disk and ceph-deploy
Date: Sat, 26 Oct 2013 02:09:49 +0800
Message-ID: <CA+8ZFnjpN3f7PxUHWCC=VEO1=w_8enr90GYfEQfL_HO8M_T4EQ@mail.gmail.com>
References: <CA+8ZFngUzk1_koBBkJjdrRje--0SJ_K0=xZ4SrnTL4GTiBTuKQ@mail.gmail.com>
	<alpine.DEB.2.00.1310251056280.11294@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36931 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3JYSJv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Oct 2013 14:09:51 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so6996066iec.38
        for <ceph-devel@vger.kernel.org>; Fri, 25 Oct 2013 11:09:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1310251056280.11294@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Oct 26, 2013 at 1:57 AM, Sage Weil <sage@inktank.com> wrote:
> On Sat, 26 Oct 2013, xan.peng wrote:
>> Hi all,
>>
>> I ran into a little problem when trying ceph-deploy, and I'm wondering
>> it's a bug?
>>
>> steps:
>> 1) ./ceph-deploy -v osd prepare --fs-type ext4
>> mon02:sdb:/mnt/cephjournal/journal0
>> 2) ./ceph-deploy -v osd activate --fs-type ext4
>> mon02:/dev/sdb1:/mnt/cephjournal/journal0
>> "ERROR:ceph-disk:Failed to activate" shown.
>>
>> solution:
>> go to target node, run `ceph-disk -v activate --mark-init sysvinit
>> --mount /dev/sdb1`, find that in maybe_mkdir()@/usr/sbin/ceph-disk,
>> os.mkdir("/var/lib/ceph/osd/osd-1") is called.
>> Right here should we use os.makedirs() instead of os.mkdir()? As
>> makedirs will create all intermediate directories but mkdir will not.
>
> You mean /var/lib/ceph/osd didn't already exist?  That directory should be
> created by the package.  I think this has actually come up before but we
> deliberately left it this way because if the directory is missing the
> package is broken or not installed.  What distro are you using?  Is ceph
> installed?
>

Hmm, I get it, I'm running Ceph which is compiled manually (the
"configure && make && make install" things), and I should create
/var/lib/ceph/osd before ceph-deploying.
Sorry to disturb :(

-- 
Best,
xan
