From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: RE: Comments on Ceph distributed parity implementation
Date: Fri, 21 Jun 2013 17:08:01 -0700
Message-ID: <622F4407872BA447A16110F65453358C01A4D8066F49@FMSAMAIL.fmsa.local>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
 <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local>
 <51C00FDB.6030803@polytech.univ-nantes.fr>
 <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu>
 <51C34932.4080304@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D8066EE7@FMSAMAIL.fmsa.local>
 <51C40EDD.9090909@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu24.fnanic.fujitsu.com ([192.240.6.14]:39597 "EHLO
	fujitsu24.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423187Ab3FVAEq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Jun 2013 20:04:46 -0400
In-Reply-To: <51C40EDD.9090909@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Harvey Skinner <hpmpec2a@gmail.com>


On 06/21/2013 1:29 AM, Loic Dachary wrote:
> 
> On 06/21/2013 03:23 AM, Paul Von-Stamwitz wrote:
> >
> > On 06/20/2013 11:26 PM, Loic Dachary wrote:
> >>
> >> I wrote down a short description of the read/write path I plan to
> >> implement in ceph :
> > https://github.com/dachary/ceph/blob/wip-
> 4929/doc/dev/osd_internals/erasure-code.rst.
> >> A quick look at the drawings will hopefully give you an idea. Each OSD
> is > a disk connected to the others over the network. Although I chose K+M
> = 5 > I suspect the most common use case will be around K+M = 7+3 = 10
> >
> > Hi Loic,
> >
> > A couple questions regarding your proposal:
> >
> > Where would encode/decode occur? Client or OSD? Previous discussions
> seemed to want it at the OSD level. Your proposal seems that it could be
> either.
> 
> I think it should be in the OSD. Although it would be possible to
> implement it in the client, it would have to be implemented in the OSD
> anyway for scrubbing. Therefore I think it is simpler to implement it in
> the OSD as a first step.

Agreed. Encode/decode/reconstruction belongs in the OSD layer. There is a possibility that the client and OSDs can work in tandem. For example, the client already does sharding. But, the OSD is currently responsible for replication, so it should be responsible for parity. For now, we should strive for encoding to be transparent to the client.

> 
> >
> > What about partial reads? For example, if only 'H' was requested, would
> you decode the entire object first?
> 
> Unless you see a good reason to implement this optimization from the start,
> I think the entire object would be decoded.
> 
> > Or, read from OSD1 and reconstruct on error?
> 
> I think that's what we want, ultimately. And also to encode / decode large
> objects (1GB for instance) as a sequence of independant regions (4MB for
> instance or smaller).
> 
> I updated https://github.com/dachary/ceph/blob/wip-
> 4929/doc/dev/osd_internals/erasure-code.rst to reflect our discussion.
> 
> The first, simplest implementation is likely to be fit to use with RGW and
> probably too slow to use with RBD. Do you think we should try to optimize
> for RBD right now ?

Yes, RGW is the obvious best candidate for the first implementation. We don't need to implement for RBD and CephFS now, but we should consider how the design would handle other applications in the future. The alternative is to optimize purely for RGW and provide an API/plug-in capability suggested by Harvey Skinner to make way for optimized solutions for other applications.

All the best
pvs

