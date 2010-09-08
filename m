From: Sage Weil <sage@newdream.net>
Subject: Re: MDS crashing
Date: Wed, 8 Sep 2010 10:27:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009081019460.28511@cobra.newdream.net>
References: <AANLkTinOE+zRi_UHq33xPkADp-xavEbxgiW+ezUhVciT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57528 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0IHR0O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Sep 2010 13:26:14 -0400
In-Reply-To: <AANLkTinOE+zRi_UHq33xPkADp-xavEbxgiW+ezUhVciT@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nat N <phenisha@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Nat,

Can you add

	debug mds = 20
	debug ms = 1

to the [mds] section of your ceph.conf, restart the mds, and post the 
resulting mds log (normally in /var/log/ceph)?  

It looks like interval_set is throwing the assertion because it's 
inserting a value into the set that is already there.. the question is 
why.  Once we identify where the error came from, we can also make the 
journal replay tolerate the condition as best it can.

Thanks!
sage

On Wed, 8 Sep 2010, Nat N wrote:

> Hi I am testing the ceph file system, all has been going OK but now it
> seems my cmds is crasing with the following error
> 
> .... <snip> ...
> 10.09.08_13:48:40.146886 419dc940 -- 172.17.8.3:6802/8771 <== osd8
> 172.17.8.11:6800/8930 7 ==== osd_op_reply(28 200.00000ef9 [read
> 0~4194304] = 0) v1 ==== 98+0+4194304 (1203150032 0 2774819477)
> 0xa22080
> 10.09.08_13:48:40.147220 44e45940 mds0.cache creating system inode with ino:100
> 10.09.08_13:48:41.293977 4333f940 -- 172.17.8.3:6802/8771 --> mon2
> 172.17.8.4:6789/0 -- mdsbeacon(8900/thorium003 up:replay seq 34 v212)
> v1 -- ?+0 0x2145500
> 10.09.08_13:48:41.295762 419dc940 -- 172.17.8.3:6802/8771 <== mon2
> 172.17.8.4:6789/0 48 ==== mdsbeacon(8900/thorium003 up:replay seq 34
> v212) v2 ==== 112+0+0 (2962285251 0 0) 0x2145500
> ./include/interval_set.h: In function 'void interval_set<T>::insert(T,
> T) [with T = inodeno_t]':
> ./include/interval_set.h:202: FAILED assert(0)
>  1: (EMetaBlob::replay(MDS*, LogSegment*)+0x3f75) [0x691625]
>  2: (EUpdate::replay(MDS*)+0x38) [0x694d28]
>  3: (MDLog::_replay_thread()+0x68e) [0x68801e]
>  4: (MDLog::ReplayThread::entry()+0xd) [0x4bb3cd]
>  5: (Thread::_entry_func(void*)+0xa) [0x49c71a]
>  6: /lib64/libpthread.so.0 [0x31d960673d]
>  7: (clone()+0x6d) [0x31d8ed3d1d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> 
> I am using the unstable git branch as well as kernel .35, one mds and
> 3 monitors with around 10 osds
> 
> unfortuantely I do not have access to the core files but please find
> the objdump cmds here:
> http://www.geopersonalassistant.com/dump/cmds.dump.gz
> 
> 
> Regards.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
