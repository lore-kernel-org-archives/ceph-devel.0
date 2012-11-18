From: Sage Weil <sage@inktank.com>
Subject: Re: libcephfs create file with layout and replication
Date: Sat, 17 Nov 2012 16:15:42 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211171614550.31628@cobra.newdream.net>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com> <alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net> <CAPrxi58Ro5i9HP1Yryvg+hzgm=LOeo+Zp4NhBp-OJgWjpbg9xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45729 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab2KRAPn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 19:15:43 -0500
In-Reply-To: <CAPrxi58Ro5i9HP1Yryvg+hzgm=LOeo+Zp4NhBp-OJgWjpbg9xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 17 Nov 2012, Noah Watkins wrote:
> On Sat, Nov 17, 2012 at 3:23 PM, Sage Weil <sage@inktank.com> wrote:
> > On Sat, 17 Nov 2012, Noah Watkins wrote:
> >
> > FWIW, the striping parameters are object size, stripe unit, stripe count,
> > and data pool.
> 
> In ceph_mds_request_args.open I see the all the striping parameters
> except data pool, and I don't see any places that the file_replication
> parameter is being used. Should a pg_pool field be added?

Yeah, I think this bit needs to be fixed in the on-write protocol.  That 
is a delicate fix.

We ignore that for the purposes of getting the libcephfs API correct, 
though...

sage
