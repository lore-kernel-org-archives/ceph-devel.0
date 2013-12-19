From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Thu, 19 Dec 2013 21:27:38 +0800
Message-ID: <52B2F44A.1050109@intel.com>
References: <oriounafd8.fsf@livre.home>	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>	<or38lq86ig.fsf@livre.home>	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com> <or4n656zij.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442Ab3LSN2B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Dec 2013 08:28:01 -0500
In-Reply-To: <or4n656zij.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>, Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/19/2013 04:00 PM, Alexandre Oliva wrote:
> On Dec 18, 2013, Gregory Farnum <greg@inktank.com> wrote:
> 
>> This probably wouldn't be too hard to get working properly,
> 
> For some value of properly ;-)
> 
> The current state of affairs is that the parent attribute only gets
> updated when the log segment is about to be expired.  Worst case, using
> the proposed setxattr extension will force it to be updated earlier.
> How could that end up being a bad thing?  It's not like we even use the
> parent attribute for anything while the inode remains in the mds
> journal.
> 
> So we have the following possibilities of divergence:
> 
> a) the inode is created or moved, and then someone calls
> setxattr(parent), and the file remains in place until the inode gets
> expired from the journal.  the parent attribute will be updated at the
> time of the setxattr request, but it won't ever be used before the inode
> gets expired from the journal, at which point it would have been updated
> to the same value.
> 
> b) the inode is absent from the journal, and someone calls
> setxattr(parent), and then moves the inode to a different location.  the
> parent attribute will be updated (a nop unless the attribute is missing
> or wrong) at the time of the setxattr request, and then the move
> operation will cause the attribute to be overwritten at the time the
> inode is about to be expired from the journal
> 
> c) the inode is moved, then setxattr(parent)ed, then moved again, before
> the initial move gets expired from the journal.  the setxattr will be
> performed at the time it is requested, and it will be correct at that
> point; when the first inode move is expired from the journal, the parent
> attribute may or may not be updated (I'm not sure), but if it is, then
> we're back to the original behavior, and anyway, this incorrect value
> won't ever be used as long as the subsequent move remains in the journal
> 
> 
> Did I miss any case?
>

I think you are right. Setting the parent xattr direclty won't compromise
the backtrace.

> 
> Now, I've just run into another scenario in which this parent-setting
> useful.  I had to resort to --reset-journal (for reasons unknown), but
> any files and directories created recently, whose create operations
> hadn't been expired from the journal yet, won't get a parent attribute
> from ceph unless I actually moved them about to force an update.  This
> means caps on them won't recover properly until I find out what they are
> and perform corrective action.
> 
> Moving a bunch of objects is somewhat tricky, because if the mds
> restarts just at the wrong time, the move operation will seem to fail
> because the new mds won't recover that transaction correctly, precisely
> because the object is absent from the journal and missing the parent
> attribute.  This sort of probably will often get a client stuck, or
> signal an error that may or may not indicate the operation failed.
> 
> Plus, if I have to do that move dance on a large number of objects, odds
> are the mds will get slow enough that a standby-replay mds will decide
> it's dead and take over, and then fail to recover the ongoing
> operations.  See where I'm going? :-)
> 
> Having some means to update the internal bookkeeping parent attribute
> without actually touching the inodes, not even their ctimes, is a plus
> for this case.
> 
> 
> So now it's not just really old ceph nodes and a wish to have accurate
> information in the parent nodes, it's recovering from a --reset-journal
> required by some other failure I couldn't figure out.

next time you encountered log corruption, please open "new issues" at http://tracker.ceph.com/

Regards
Yan, Zheng

> 
> (hmm...  if I have 2*N replicas of PGs in the metadata pool and demand N
> replicas to be up for the PG to be deemed complete, if I shut down the N
> replicas that are up after they get an update and bring up the other N
> replicas, they will know they're out of date, right?  IIUC that's what
> the down state is about, although I'm not sure where the OSDs get the
> info from to decide to enter that state; I've always assumed it was from
> pg versions known by the monitors)
> 

