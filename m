From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Thu, 3 Nov 2011 14:29:15 -0700
Message-ID: <CAORUGqCLPfWUu4JeGctQDVtz+1kfj=8Z3qO5DBAYen_CW_pAzQ@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <CAORUGqB+oS5WupMZURbkenNop68u2jf2VrY3_tktBk4=b-jS8w@mail.gmail.com>
 <CA+jddaO2NqLTNbS2zBnQW4MCA7=BYDC-GHx_H01hqSq9RvOgBw@mail.gmail.com>
 <CAORUGqC3ZG-7NG7xACFoHP0kY=gDDgMG=i+99MV1hmM1XpL9bw@mail.gmail.com> <20111103212024.GA1587@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33395 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1KCV3h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 17:29:37 -0400
Received: by wwi36 with SMTP id 36so2506333wwi.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 14:29:36 -0700 (PDT)
In-Reply-To: <20111103212024.GA1587@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mandell Degerness <mandell@pistoncloud.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Nov 3, 2011 at 14:20, Christoph Hellwig <hch@infradead.org> wro=
te:
> XFS is just waiting for I/O to complete - xfs_bwrite is a very simple
> funtion that synchronously submits I/O, and xfs_buf_iowait is called
> to wait for the completion. =C2=A0 This is a typical symptom for a br=
oken
> I/O subsystem. =C2=A0What kind of setup do you use? =C2=A0Especially =
hardware
> RAID controllers tends to produce these kinds of issues.

Oh yeah, I didn't mean to necessarily implicate XFS as such, more to
say "I don't think that's a Ceph bug", look lower in the stack. I
think I'm just likely to call out fs bugs at this point because
usually with btrfs, that same hung message from the kernel tends to
mean the fs broke, not the disk. Broken block device drivers and
firmware happens too. Failure is always an option, at every layer of
the stack.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
