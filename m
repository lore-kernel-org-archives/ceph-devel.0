From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph journal
Date: Wed, 31 Oct 2012 14:54:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210311454080.20646@cobra.newdream.net>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com> <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33969 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760825Ab2JaVyi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 17:54:38 -0400
In-Reply-To: <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

On Wed, 31 Oct 2012, Tren Blackburn wrote:
> On Wed, Oct 31, 2012 at 2:18 PM, Gandalf Corvotempesta
> <gandalf.corvotempesta@gmail.com> wrote:
> > In a multi replica cluster (for example, replica = 3) is safe to set
> > journal on a tmpfs?
> > As fa as I understood with journal enabled all writes are wrote on
> > journal and then to disk in a second time.
> > If node hangs when datas are still on journal (and journal is not on a
> > permanent disk), some data lost could happens.
> >
> > In a multi replica environment, other nodes should be able to write
> > the same datas to disk, right? I this case, using a journal on a tmpfs
> > should be safe enough.
> 
> Unless you're using btrfs which writes to the journal and osd fs
> concurrently, if you lose the journal device (such as due to a
> reboot), you've lost the osd device, requiring it to be remade and
> re-added.

This is correct.  For non-btrfs file systems we rely on the journal for 
basic consistency.

sage
