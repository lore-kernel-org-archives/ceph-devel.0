From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Wed, 18 Dec 2013 10:47:04 +0800
Message-ID: <CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
References: <oriounafd8.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:56480 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab3LRCrH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 21:47:07 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so3491156lam.25
        for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 18:47:04 -0800 (PST)
In-Reply-To: <oriounafd8.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zheng.z.yan@intel.com>

On Tue, Dec 17, 2013 at 7:25 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> This is a (probably half-baked) solution for the problem of cephfs
> clusters encountering recovery problems when clients are accessing files
> that don't have a parent attribute.  It enables clients to request the
> parent attribute to be updated right away, by a simple setxattr call:
>
> # setfattr -n ceph.parent /cephfs/mount/path/name
>
> I had to relax the assert because there's no reason I can think of to
> force the object and its parent dirty just to set this internal
> bookkeeping xattr.  The operation is not journaled, as it takes effect
> immediately.  Although there's no assurance that the operation is
> completed before success is returned, my tests indicate that running
> rados getxattr right after setfattr already gets an attribute, for
> objects that had been created before the introduction of the parent
> attribute.
>
> I realize Zheng Yan posted a patch that would mark for update missing or
> too-old parent attributes on the fly, when inodes were brought into the
> cache, so that the parent attribute would be updated when the inodes
> were to be expired from the MDS log.  I had mds running with that patch
> for a while, and I even explicitly touched and linked files and dirs
> that were missing the parent attribute; many, but not all of the files
> and dirs got the attribute, and I'm having some difficulties getting it
> to work on the remaining ones, in part because it takes so long to take
> effect (as in, perform an operation, then wait for several hours until
> the then-current MDS log segment gets expired, then check whether the
> attribute was set).  This patch causes the parent attribute to be set
> right away.
>
> I'm not sure this immediate behavior would be appropriate for use in
> production (as in, I'm not sure creating an inode and trying to set the
> parent attribute might cause a failure because the inode object isn't
> there yet by the time we try to set an attribute on it), but it should
> be ok for retrofitting ancient inode objects so that they don't cause
> recovery problems due to the lack of the parent xattr.
>

Hi,

This seems like a good solution for fixing cephfs that was created
before dumpling. But I'm not sure whether we should merge this patch
(how many cephfs that was created before dumpling still exist)

Regards
Yan, Zheng


> BTW, Zheng Yan, thanks for the patch that fixed mds readdir with dirs
> ending in remote (hard) links; this one had annoyed me for a long time,
> and I was just about to start actually digging into it when I saw the
> 0.73 announcement that mentioned what appeared to be a fix for the
> problem I was running into, and indeed, it was.  I merged it into my
> 0.72.1 build and it's been working great!
>
>
>
> --
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
>
