From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: ceph-mon blocked error
Date: Fri, 04 Nov 2011 16:27:03 -0200
Message-ID: <orwrbfu4js.fsf@livre.localdomain>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
	<CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
	<CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:48444 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750845Ab1KEFsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Nov 2011 01:48:07 -0400
In-Reply-To: <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
	(Mandell Degerness's message of "Thu, 3 Nov 2011 12:09:23 -0700")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Nov  3, 2011, Mandell Degerness <mandell@pistoncloud.com> wrote:

> We are currently running all services on each of the three nodes.
> (mon, mds, and several osd processes).

Do you also happen to have a ceph.ko mount on the node that showed the
problem?  If so, you may be running into a deadlock in which ceph.ko is
waiting for a response from the mon to complete a sync and release some
pages, but mon is waiting for a sync to complete before it will respond.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
