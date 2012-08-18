From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Sat, 18 Aug 2012 06:08:11 -0300
Message-ID: <ora9xsbm9w.fsf@livre.localdomain>
References: <orboos1qyu.fsf@livre.localdomain>
	<Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
	<ork43bbbbb.fsf@livre.localdomain>
	<Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:45904 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752379Ab2HRJI1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 18 Aug 2012 05:08:27 -0400
In-Reply-To: <Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net> (Sage
	Weil's message of "Sat, 3 Mar 2012 16:14:12 -0800 (PST)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mar  3, 2012, Sage Weil <sage@newdream.net> wrote:

> On Sat, 25 Feb 2012, Alexandre Oliva wrote:
>> On Feb 23, 2012, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 21 Feb 2012, Alexandre Oliva wrote:
>> >> This was supposed to fix bug 1946, and likely bug 1849 too, but it looks
>> >> like something's still missing for a complete fix.

>> create snapshot
>> check timestamps -> baseline
>> unmount
>> mount again
>> check timestamps -> same
>> restart mds
>> check timestamps -> same
>> unmount
>> mount again
>> check timestamps -> same
>> moved a tree into dir
>> check timestamps -> dir changed and snapshot unchanged, as expected
>> unmount
>> mount again
>> check timestamps -> same
>> restart mds
>> check timestamps -> snapshot changed to dir's; its size too!

> It looks like the problem is that CInode::first isn't being journaled.  

I see old_inodes are being journalled properly now.  I've looked further
into this tonight, and I found out what modifies the timestamps in the
inode is (re)issuing caps to a client.  I had a hw watchpoint on the
timestamp in old_inodes, and it hit when I accessed the directory from a
client, with this stack trace:

#0  0x0000000000668e1d in operator= (this=0x7fffb5513370)
    at ../../src/mds/mdstypes.h:375
#1  CInode::cow_old_inode (this=0x7fffe09f6630, follows=..., cow_head=true)
    at ../../src/mds/CInode.cc:2035
#2  0x000000000066972e in CInode::pre_cow_old_inode (this=0x7fffe09f6630)
    at ../../src/mds/CInode.cc:2058
#3  0x00000000005dac8b in Locker::scatter_writebehind (this=0x1277500, 
    lock=0x7fffe09f6d78) at ../../src/mds/Locker.cc:3583
#4  0x00000000005e5bac in Locker::eval_gather (this=0x1277500, 
    lock=0x7fffe09f6d78, first=true, pneed_issue=0x7ffff4fc4f3f, 
    pfinishers=0x0) at ../../src/mds/Locker.cc:686
#5  0x00000000005e993e in eval_any (need_issue=0x7ffff4fc4f3f, 
    lock=<optimized out>, this=0x1277500) at ../../src/mds/Locker.h:103
#6  eval_any (need_issue=0x7ffff4fc4f3f, lock=0x7fffe09f6d78, this=0x1277500)
    at ../../src/mds/Locker.cc:763
#7  Locker::eval (this=0x1277500, in=0x7fffe09f6630, mask=<optimized out>)
    at ../../src/mds/Locker.cc:783
#8  0x00000000005f9ff9 in Locker::handle_client_caps (this=0x1277500, 
    m=0x7fff683e8620) at ../../src/mds/Locker.cc:2340
#9  0x00000000004ba900 in MDS::handle_deferrable_message (this=0x1272d70, 
    m=0x7fff683e8620) at ../../src/mds/MDS.cc:1742
#10 0x00000000004cddae in MDS::_dispatch (this=0x1272d70, m=<optimized out>)
    at ../../src/mds/MDS.cc:1833
---Type <return> to continue, or q <return> to quit---

old_inodes looks like this:

std::map with 1 elements = {[{val = 5}] = {first = {val = 2}, inode = {
      ino = {val = 1099511627776}

follows is 5 and first is 2 within CInode::pre_cow_old_inode.

So, how can we stop pre_cow_old_inode from messing with the old_inode?
Any suggestions?

Thanks in advance,

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
