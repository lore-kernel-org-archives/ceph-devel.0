From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Wed, 18 Dec 2013 14:32:07 -0200
Message-ID: <or38lq86ig.fsf@livre.home>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:49998 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3LRRDX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 12:03:23 -0500
In-Reply-To: <CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	(Zheng Yan's message of "Wed, 18 Dec 2013 10:47:04 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zheng.z.yan@intel.com>

On Dec 18, 2013, "Yan, Zheng" <ukernel@gmail.com> wrote:

> On Tue, Dec 17, 2013 at 7:25 PM, Alexandre Oliva <oliva@gnu.org> wrote:
>> # setfattr -n ceph.parent /cephfs/mount/path/name

> This seems like a good solution for fixing cephfs that was created
> before dumpling.

There's more to it than just that, actually.  Renaming an entire subtree
won't update the parent attribute of files in there, so they will appear
to be incorrect (*).  This patch introduces a mechanism that could be
used to force them to be updated.

(*) I'm well aware that they contain enough information to find the
updated information, so the redundant info in this attribute can be
harmlessly out-of-date, but if someone plans to use the data for other
purposes (like I sometimes do), it's useful to have them fully up to
date.  I also move large trees around, which makes this issue visible.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
