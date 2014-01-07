From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Tue, 07 Jan 2014 02:15:46 -0200
Message-ID: <orha9gzatp.fsf@livre.home>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	<or38lq86ig.fsf@livre.home>
	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>
	<or4n656zij.fsf@livre.home> <52B2F44A.1050109@intel.com>
	<orbo0c5h4p.fsf@livre.home> <52B3F9DE.60301@intel.com>
	<ord2kr3vez.fsf@livre.home> <or8uvf3u3r.fsf@livre.home>
	<CAPYLRzgG0VTh+7cDg58-pknn7Kv_-CDDLqoGxd=UhX4vAiCkJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:44293 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbaAGESG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jan 2014 23:18:06 -0500
In-Reply-To: <CAPYLRzgG0VTh+7cDg58-pknn7Kv_-CDDLqoGxd=UhX4vAiCkJA@mail.gmail.com>
	(Gregory Farnum's message of "Mon, 6 Jan 2014 09:22:14 -0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Jan  6, 2014, Gregory Farnum <greg@inktank.com> wrote:

> On Fri, Dec 20, 2013 at 4:50 PM, Alexandre Oliva <oliva@gnu.org> wrote:
>> On Dec 20, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>> 
>>> back many of the osds to recent snapshots thereof, from which I'd
>>> cleaned all traces of the user.ceph._parent.  I intended to roll back
>> 
>> Err, I meant user.ceph._path, of course ;-)
>> 
>>> So I think by now I'm happy to announce that it was an IO error (where
>>> IO stands for Incompetence of the Operator ;-)
>> 
>>> Sorry about this disturbance, and thanks for asking me to investigate it
>>> further and find a probable cause that involves no fault of Ceph's.
>> 
>> I guess after the successful --reset-journal, I get to clean up on my
>> own the journal files that are no longer used but that apparently won't
>> get cleaned up by the mds any more.  Right?

> If they're in the "future" of the mds journal they'll get cleared out
> automatically as the MDS gets up to them (this is the pre-zeroing
> thing). If they're in the "past", yeah, you'll need to clear them up.

After an ceph-mds --reset-journal, I don't see how they could be in the
"future", but what do I know?

> Did you do that rollback via your cluster snapshot thing, or just
> local btrfs snaps?

Local btrfs snaps.  Had I rolled back to a cluster snapshot proper,
there's no way this problem could have happened.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
