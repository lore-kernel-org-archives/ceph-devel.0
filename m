From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Mon, 6 Jan 2014 09:22:14 -0800
Message-ID: <CAPYLRzgG0VTh+7cDg58-pknn7Kv_-CDDLqoGxd=UhX4vAiCkJA@mail.gmail.com>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	<or38lq86ig.fsf@livre.home>
	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>
	<or4n656zij.fsf@livre.home>
	<52B2F44A.1050109@intel.com>
	<orbo0c5h4p.fsf@livre.home>
	<52B3F9DE.60301@intel.com>
	<ord2kr3vez.fsf@livre.home>
	<or8uvf3u3r.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:52122 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683AbaAFRWP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jan 2014 12:22:15 -0500
Received: by mail-qc0-f182.google.com with SMTP id e16so17732692qcx.41
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jan 2014 09:22:14 -0800 (PST)
In-Reply-To: <or8uvf3u3r.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Dec 20, 2013 at 4:50 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> On Dec 20, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>
>> back many of the osds to recent snapshots thereof, from which I'd
>> cleaned all traces of the user.ceph._parent.  I intended to roll back
>
> Err, I meant user.ceph._path, of course ;-)
>
>> So I think by now I'm happy to announce that it was an IO error (where
>> IO stands for Incompetence of the Operator ;-)
>
>> Sorry about this disturbance, and thanks for asking me to investigate it
>> further and find a probable cause that involves no fault of Ceph's.
>
> I guess after the successful --reset-journal, I get to clean up on my
> own the journal files that are no longer used but that apparently won't
> get cleaned up by the mds any more.  Right?

If they're in the "future" of the mds journal they'll get cleared out
automatically as the MDS gets up to them (this is the pre-zeroing
thing). If they're in the "past", yeah, you'll need to clear them up.

Did you do that rollback via your cluster snapshot thing, or just
local btrfs snaps? I don't think I want to add anything that makes it
easy for people to break their filesystem like this. :p
-Greg
