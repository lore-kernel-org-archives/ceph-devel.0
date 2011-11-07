From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Mon, 7 Nov 2011 13:45:45 -0800
Message-ID: <CAORUGqD0EL4yb-RbrixJPkwjSubPpJD5NKX-2OwK6656bkgjHA@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <orwrbfu4js.fsf@livre.localdomain> <CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
 <orobwqt186.fsf@livre.localdomain> <CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
 <CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62447 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab1KGVqH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 16:46:07 -0500
Received: by wwi36 with SMTP id 36so7366106wwi.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 13:46:06 -0800 (PST)
In-Reply-To: <CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Mandell Degerness <mandell@pistoncloud.com>, Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

On Mon, Nov 7, 2011 at 11:48, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> (Hopefully this email still makes sense; I rewrote it several times
> trying to figure out what was going on with ceph-fuse!)

tl;dr: Don't mount any network filesystem on the box serving that
filesystem. The virtual memory disk buffer system will deadlock at
some point. That includes Ceph and NFS. The cost of making that work
right is so high that in practice it's just not done.
