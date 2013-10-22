From: Sage Weil <sage@inktank.com>
Subject: Re: Removing disks / OSDs
Date: Tue, 22 Oct 2013 10:31:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310221029580.29488@cobra.newdream.net>
References: <52655309.8070500@dachary.org> <CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com> <52661776.20803@dachary.org> <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44174 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab3JVRbL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Oct 2013 13:31:11 -0400
In-Reply-To: <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 22 Oct 2013, Gregory Farnum wrote:
> On Mon, Oct 21, 2013 at 11:13 PM, Loic Dachary <loic@dachary.org> wrote:
> >
> >
> > On 21/10/2013 18:49, Gregory Farnum wrote:
> >> I'm not quite sure what questions you're actually asking here...
> >> In general, the OSD is not removed from the system without explicit
> >> admin intervention. When it is removed, all traces of it should be
> >> zapped (including its key), so it can't reconnect.
> >> If it hasn't been removed, then indeed it will continue working
> >> properly even if moved to a different box.
> >
> > If there is an external journal, the device containing the journal needs to be moved with the device containing the data. If I read ceph/src/upstart/ceph-osd.conf correctly, when the data device is plugged in the new machine it will fail to start because the journal is not there yet. When the journal device is plugged in, the ceph-osd.conf would be called because udev rule in ceph/udev/95-ceph-osd.rules call ceph-disk activate-journal.
> >
> > Is my understanding correct ?
> 
> Well, after being wrong last time I'm a little reluctant to make
> pronouncements from memory, but that definitely sounds correct to me.

Yep, that's how it's supposed to work.  The activate-journal piece is 
somewhat recent though (I think maybe it wasn't in place for cuttlefish?).

> :) If I were doing an audit I'd want to look at what happens if there
> is a wrong journal in the correct location, etc.

The ceph-osd will fail on start because the uuid/fsid doesn't match.

sage
