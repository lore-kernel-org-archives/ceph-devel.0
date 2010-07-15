From: Sage Weil <sage@newdream.net>
Subject: Re: CEPH distributed filesystem on two sites
Date: Thu, 15 Jul 2010 09:20:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007150917290.26304@cobra.newdream.net>
References: <AANLkTikDlZd0AUFzJ_VCnWYYsTnHlTmilok2o4_ErFvq@mail.gmail.com>
 <AANLkTikj5e1JlAHK2lfoiVlXsnxCh0M5gAMBl6ZdxtEn@mail.gmail.com>
 <AANLkTilK9ca7yhp_5oxWro_uAD045kdKZytVogNgxZ-3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35692 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933658Ab0GOQSr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jul 2010 12:18:47 -0400
In-Reply-To: <AANLkTilK9ca7yhp_5oxWro_uAD045kdKZytVogNgxZ-3@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1007150917401.26304@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryan Grant <rgrant+ceph@metascopic.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, Roland Rabben <roland@jotta.no>, ceph-devel@vger.kernel.org

On Wed, 14 Jul 2010, Ryan Grant wrote:
> > On Mon, Jul 12, 2010 at 11:59 AM, Roland Rabben <roland@jotta.no> wrote:
> >> Have there been any work to get CEPH working with two datacenters?
> 
> On Mon, Jul 12, 2010 at 12:39 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> > That said, as Brian discusses it will work, but expect writes to
> > proceed at about the speed of your datacenter interconnect.
> 
> Roland did not specify an access pattern, but from context he may
> be considering the offsite copy as a backup.
> 
> my understanding is that ceph is smart enough not to make
> writes block, when there are no other open readers of files - it
> returns as fast as local disk can acknowledge.

Well, if you have a single writer and no readers, writes go into the 
buffer cache and don't flush to the osds until you call fsync() or the 
linux VM pushes things out due to memory pressure, timeout, etc.  When 
data _is_ written to the OSDs, it has to hit all replicas before the write
"succeeds".

> what does ceph do if it can get a couple copies made quickly
> (but not the third remote copy)
> and all readers are in the local datacenter?

Currently it waits for all copies.  It would certianly be possible to 
define "success" from the client perspective as N/M copies written, 
though.  Even without changing/redefining reads (ala Dynamo), since reads 
and writes are serialized by the primary replica.

sage
