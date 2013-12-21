From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Fri, 20 Dec 2013 22:22:12 -0200
Message-ID: <ord2kr3vez.fsf@livre.home>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	<or38lq86ig.fsf@livre.home>
	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>
	<or4n656zij.fsf@livre.home> <52B2F44A.1050109@intel.com>
	<orbo0c5h4p.fsf@livre.home> <52B3F9DE.60301@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:55470 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab3LUAWs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Dec 2013 19:22:48 -0500
In-Reply-To: <52B3F9DE.60301@intel.com> (Zheng Yan's message of "Fri, 20 Dec
	2013 16:03:42 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Dec 20, 2013, "Yan, Zheng" <zheng.z.yan@intel.com> wrote:

> On 12/20/2013 11:35 AM, Alexandre Oliva wrote:
>> On Dec 19, 2013, "Yan, Zheng" <zheng.z.yan@intel.com> wrote:
>> 
>>> next time you encountered log corruption, please open "new issues" at http://tracker.ceph.com/
>> 
>> I have saved the dumped journal, but it contains too much information
>> I'm not supposed to or willing to share, especially with a US-based
>> company in the post-Snowden era :-(  (something like btrfs-image -s
>> might be good to have)
>> 
>> I'd be glad to try to dig info that might be useful out of it, if told
>> how to do so, but uploading the journal as taken from the cluster is not
>> an option.

> can you send out the mds log (the latest few hundreds of lines) when the mds crashed.

It didn't quite crash.  Here's what it spit out:

mds.0.cache creating system inode with ino:1
mds.0.journaler(ro) try_read_entry got 0 len entry at offset 1248878082748
mds.0.log _replay journaler got error -22, aborting
mds.0.1307 boot_start encountered an error, failing
mds.0.1307 suicide.  wanted down:dne, now up:replay

Before this, the mds was brought down along with the rest of the
cluster:

mds.0.1273 *** got signal Terminated ***
mds.0.1273 suicide.  wanted down:dne, now up:active

The --reset-journal session, that aborted because of the assertion
failure I mentioned in the patch, added the recent message log, but
there's nothing useful there: the mds asked osds for each one of the log
segments, got successful responses for them all, and then proceeded to
reset the journal.  The only oddity I found was this:

client.411305.journaler(ro) _finish_probe_end write_pos = 1248890415494 (header had 1248890413881). recovered.

For reference, here's the complete loghead info:

client.411305.journaler(ro) _finish_read_head loghead(trim 1248761741312, expire 1248761744503, write 1248890413881).  probing for end of log (from 1248890413881)...

Note how the offset at which we got the zero-len entry is not close to
either end of the (non-trimmed portion of) the log.  200.00048b1b, where
the zero-len entry was, was not only read successfully, the
corresponding file in the osds had the correct 4MB size, and the md5sum
of that file was the same on all 4 osds that contained it.  So, whatever
it was that corrupted the log happened long before the mds shutdown;
200.00048b1b's timestamp is 1387397117, while 200.00048b1e's (the tail
before the journal reset) is 1387430417; the 2 other files in between
are spaced at a nearly constant rate of 10000 seconds per 4MB.

The mds log has nothing special for that time range, but from the mon
and the osd logs I can tell that was about the time in which I rolled
back many of the osds to recent snapshots thereof, from which I'd
cleaned all traces of the user.ceph._parent.  I intended to roll back
only 2 out of the 4 replicas of each pg at a time, and wait for them to
recover, but I recall that during this process, two osds came down
before they were meant to, because of timeouts caused by the
metadata-heavy recursive setfattr.  I guess this may have caused me to
lose changes that had already been committed, by rolling back all the
osds that had those changes.

So I think by now I'm happy to announce that it was an IO error (where
IO stands for Incompetence of the Operator ;-)

Sorry about this disturbance, and thanks for asking me to investigate it
further and find a probable cause that involves no fault of Ceph's.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
