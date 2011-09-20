From: Sage Weil <sage@newdream.net>
Subject: Re: radosgw question
Date: Tue, 20 Sep 2011 08:09:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109200808120.30961@cobra.newdream.net>
References: <CANExM-Mfy4braUiwMp1GC29d4fAeH933X_oLhJ2hd+AigukbFA@mail.gmail.com>
 <CAC-hyiGS=gJzipxYhUp+wbdC+Et0F5TexL76futvCa-3ybMNrg@mail.gmail.com>
 <CANExM-Oicj-ZjajRx+K4g=O0=8j3KPQGHGYAvyXavbjOKzDp4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab1ITPJY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 11:09:24 -0400
In-Reply-To: <CANExM-Oicj-ZjajRx+K4g=O0=8j3KPQGHGYAvyXavbjOKzDp4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 20 Sep 2011, Henry C Chang wrote:
> 2011/9/20 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> > On Tue, Sep 20, 2011 at 1:36 AM, Henry C Chang <henry.cy.chang@gmail.com> wrote:
> >> Hi,
> >>
> >> I have a question about the radosgw.
> >>
> >> The radosgw uses an object to record the buckets owned by one user
> >> account. However, suppose that the user account is shared by multiple
> >> users, and these users connect to the radosgw concurrently. If, say,
> >> user A creates bucket B1 and user B deletes bucket B2 at the same
> >> time, they will both update the object. Since it seems radosgw has no
> >> lock mechanism for object update, the problems would occurs - either
> >> the created bucket will be lost or the deleted bucket can still be
> >> listed but dne actually.
> >>
> >> I know it may be a rare case, just wondering if there is away to
> >> handle this situation.
> >>
> >
> > The RADOS gateway uses RADOS tmap atomic operations for modifying this
> > object. The tmap operations allows it to either add, remove, or modify
> > entries in this object without the need for locking and without
> > possible race conditions.
> >
> > Yehuda
> >
> 
> That's cool. If possible, could you briefly explain how tmap operation
> works or is there any document I can refer to?

The best reference is probably librados.h.  That describes the current 
interface, at least.  You'll find the implementation in 
osd/ReplicatedPG.cc.. search for TMAP on do_osd_ops().

https://github.com/NewDreamNetwork/ceph/blob/master/src/include/rados/librados.h

sage
