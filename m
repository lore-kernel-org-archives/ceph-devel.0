From: =?utf-8?b?QmVub8OudA==?= Parrein
	<benoit.parrein@polytech.univ-nantes.fr>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Sun, 16 Jun 2013 19:51:34 +0000 (UTC)
Message-ID: <loom.20130616T214215-201@post.gmane.org>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60248 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab3FPUKG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 16 Jun 2013 16:10:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UoJH1-0008UK-OQ
	for ceph-devel@vger.kernel.org; Sun, 16 Jun 2013 22:10:03 +0200
Received: from crb44-1-82-67-126-78.fbx.proxad.net ([82.67.126.78])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 16 Jun 2013 22:10:03 +0200
Received: from benoit.parrein by crb44-1-82-67-126-78.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 16 Jun 2013 22:10:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Paul Von-Stamwitz <PVonStamwitz <at> us.fujitsu.com> writes:

Hi Paul, 

> 
> Loic, I know nothing about Mojette Transforms. From what little I gleaned, 
it might be good for repair
> (needing only a subset of chunks within a range to recalculate a missing 
chunk) but I'm worried about the
> storage efficiency. RozoFS claims 1.5x. I'd like to do better than that.
> 
> All the best,
> Paul
> 

If you want to do better than that you will probably lose in availability. 
1.5x give the same availability than 3 replicats and that for any kind of 
erasure coding.
FYI, Mojette transform has no constraint in terms of Galois fields. It is the 
big advantage to use discrete geometry rather than algebra.

best regards,
bp



