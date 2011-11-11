From: Sage Weil <sage@newdream.net>
Subject: Re: OSD hit suicide timeout
Date: Fri, 11 Nov 2011 13:03:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111111258440.24252@cobra.newdream.net>
References: <CAO47_-_Rubnh9B_DGkUvO+DNn=1WHrZaeMK54fejYoJMHNFWew@mail.gmail.com>
 <Pine.LNX.4.64.1111110902230.24252@cobra.newdream.net>
 <CAO47_-9CNQ-FNOkYZ0eZJk28ueNt+ZapFUmt7-Ty2ofkD+0gcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-195498769-1321045430=:24252"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39017 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583Ab1KKVDy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2011 16:03:54 -0500
In-Reply-To: <CAO47_-9CNQ-FNOkYZ0eZJk28ueNt+ZapFUmt7-Ty2ofkD+0gcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-195498769-1321045430=:24252
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 11 Nov 2011, Christian Brunner wrote:
> 2011/11/11 Sage Weil <sage@newdream.net>:
> > Hi Christian,
> >
> > Do you have a core file? =A0Can you dump the thread stack traces so we =
can
> > see if it got hung up on a syscall or somewhere internally (thread appl=
y
> > all bt)?
>=20
> I'm not sure if it's from btrfs, but ther is no kernel warning at that ti=
me.
>=20
> I'm missing some debuginfo packages at the moment, but I managed to
> install ceph-debuginfo. (If you need more I will ask a colleague to
> subscribe the debuginfo channel on the RedHat Satellite Server, but
> you will have to wait until Monday).
>=20
> Here is what I'm getting from the core file at the moment.

Debug symbols for glibc would help, but so far I can tell that:

- the filestore op_queue is blocked on the throttler (too much io queued)
- the commit thread is also waiting for ops to finish
- i see no actual thread processing the op_queue

Usually that's because it hit a kernel bug and got killed.  Not sure what=
=20
else would make that thread disappear...

sage


--557981400-195498769-1321045430=:24252--
