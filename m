From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Thu, 3 Nov 2011 12:23:26 -0700
Message-ID: <CAORUGqB+oS5WupMZURbkenNop68u2jf2VrY3_tktBk4=b-jS8w@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com> <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65155 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab1KCTXs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 15:23:48 -0400
Received: by eye27 with SMTP id 27so1460789eye.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 12:23:47 -0700 (PDT)
In-Reply-To: <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Nov 3, 2011 at 12:09, Mandell Degerness <mandell@pistoncloud.com> wrote:
> We are currently running all services on each of the three nodes.
> (mon, mds, and several osd processes).

Is the osd data directory on the same filesystem as the mon data dir,
or are they perhaps on different disks? (Hoping for the former, for
the sake of xfs credibility ;)
