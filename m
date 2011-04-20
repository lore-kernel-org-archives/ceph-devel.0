From: Mark Nigh <mnigh@netelligent.com>
Subject: RE: mds crash
Date: Wed, 20 Apr 2011 09:00:34 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C6788452D75C@NC-SVR-09.netelligent.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C6788452D627@NC-SVR-09.netelligent.com>
 <Pine.LNX.4.64.1104190917010.3238@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.netelligent.com ([199.255.228.152]:27126 "EHLO
	NC-SVR-132.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753649Ab1DTOAg convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Apr 2011 10:00:36 -0400
In-Reply-To: <Pine.LNX.4.64.1104190917010.3238@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,

Thanks for the quick response.

That seems to fix the problem. Both of my mds are up and active.

mds e1838: 2/2/2 up {0=up:active,1=up:active}

The only thing that doesn't seem right to me (I am not a developer so my understanding of git is limited) is that my version is of the following....

ceph version 0.26-303-g36f0068 (commit:36f00685633a6f953b046106f5dd31a9169c82d4)

I don't think this is correct?

I do have a few questions for the group as well.

1. What is the proper way to upgrade from version to version. Has anyone documentation the proper procedure?

2. If I just want to test out the file system capabilities, do I need to install all the packages or is there some I can do without. I have been currently installing the following packages (Ubuntu v10.10) in this order.

sudo dpkg -i libcrush1_0.26-1_amd64.deb
sudo dpkg -i libceph1_0.26-1_amd64.deb
sudo dpkg -i ceph-fuse_0.26-1_amd64.deb
sudo dpkg -i librados2_0.26-1_amd64.deb
sudo dpkg -i librbd1_0.26-1_amd64.deb
sudo dpkg -i ceph_0.26-1_amd64.deb

Thanks for everyone's help.

Mark Nigh
Systems Architect
mnigh@netelligent.com
 (p) 314.392.6926


-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Tuesday, April 19, 2011 11:18 AM
To: Mark Nigh
Cc: ceph-devel@vger.kernel.org
Subject: Re: mds crash

Hi Mark,

This should be fixed by d55399ffec224206ea324e83bb8ead1e9ca1eddc in the
'next' branch of ceph.git.  Can you test it out and see if that allows
journal replay to complete?

Thanks!
sage

http://tracker.newdream.net/issues/1019



On Tue, 19 Apr 2011, Mark Nigh wrote:

> I recently have been working with exporting ceph to NFS. I have had stability problems with NFS (ceph is working but NFS crashes). But most recently, my mds0 will not start after one of these instances with NFS.
>
> My setup. 2 mds, 1 mon (located on mds0), 5 osds. All running Ubuntu v10.10.
>
> Here is the output when I try to start the mds0. Is there other debugging I can turn on?
>
> /etc/init.d/ceph start mds0
>
> 2011-04-19 10:06:58.602640 7fb202fe4700 mds0.11 ms_handle_connect on 10.6.1.93:6800/945
> ./include/elist.h: In function 'elist<T>::item::~item() [with T = MDSlaveUpdate*]', in thread '0x7fb2004d5700'
> ./include/elist.h: 39: FAILED assert(!is_on_list())
>  ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
>  1: (MDSlaveUpdate::~MDSlaveUpdate()+0x59) [0x4d9fe9]
>  2: (ESlaveUpdate::replay(MDS*)+0x422) [0x4d2772]
>  3: (MDLog::_replay_thread()+0xb90) [0x67f850]
>  4: (MDLog::ReplayThread::entry()+0xd) [0x4b89ed]
>  5: (()+0x7971) [0x7fb20564a971]
>  6: (clone()+0x6d) [0x7fb2042e692d]
>  ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
>  1: (MDSlaveUpdate::~MDSlaveUpdate()+0x59) [0x4d9fe9]
>  2: (ESlaveUpdate::replay(MDS*)+0x422) [0x4d2772]
>  3: (MDLog::_replay_thread()+0xb90) [0x67f850]
>  4: (MDLog::ReplayThread::entry()+0xd) [0x4b89ed]
>  5: (()+0x7971) [0x7fb20564a971]
>  6: (clone()+0x6d) [0x7fb2042e692d]
> *** Caught signal (Aborted) **
>  in thread 0x7fb2004d5700
>  ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
>  1: /usr/bin/cmds() [0x70fc38]
>  2: (()+0xfb40) [0x7fb205652b40]
>  3: (gsignal()+0x35) [0x7fb204233ba5]
>  4: (abort()+0x180) [0x7fb2042376b0]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fb204ad76bd]
>  6: (()+0xb9906) [0x7fb204ad5906]
>  7: (()+0xb9933) [0x7fb204ad5933]
>  8: (()+0xb9a3e) [0x7fb204ad5a3e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x36a) [0x6f5eaa]
>  10: (MDSlaveUpdate::~MDSlaveUpdate()+0x59) [0x4d9fe9]
>  11: (ESlaveUpdate::replay(MDS*)+0x422) [0x4d2772]
>  12: (MDLog::_replay_thread()+0xb90) [0x67f850]
>  13: (MDLog::ReplayThread::entry()+0xd) [0x4b89ed]
>  14: (()+0x7971) [0x7fb20564a971]
>  15: (clone()+0x6d) [0x7fb2042e692d]
>
> I am not sure why the IP address of 0.0.0.0 shows up with starting the mds0.
>
> root@mds0:/var/log/ceph# /etc/init.d/ceph start mds0
> === mds.0 ===
> Starting Ceph mds.0 on mds0...
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  **          testing and review.  Do not trust it with important data.       **
> starting mds.0 at 0.0.0.0:6800/2994
>
> Thanks for your assistance.
>
> Mark Nigh
> Systems Architect
> mnigh@netelligent.com
>  (p) 314.392.6926
>
>
>
>
> This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
