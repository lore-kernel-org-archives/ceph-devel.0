From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: which Linux kernel version corresponds to 0.48argonaut?
Date: Sun, 06 Jan 2013 16:00:33 +1300
Message-ID: <50E8E8D1.6010000@catalyst.net.nz>
References: <50D35ECA.4040602@cs.utah.edu> <50D3BD69.8010305@cs.utah.edu> <CAPYLRzhi2h_YDP7zdobMQepGA8ntQOqQgY+rP4AKvjvH3=-+WA@mail.gmail.com> <alpine.DEB.2.00.1301041633340.6109@cobra.newdream.net> <50E8D99F.3090008@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:38440 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab3AFDAh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 22:00:37 -0500
In-Reply-To: <50E8D99F.3090008@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'd hazard a guess that you are still (accidentally) running the 
packaged binary - the packaged version installs in /usr/bin (etc) but 
your source build will probably be in /usr/local/bin. I've been through 
this myself and purged the packaged version before building and 
installing from source (just to be sure).

Cheers

Mark

On 06/01/13 14:55, Xing Lin wrote:

> After changing the client-side code, I can map/unmap rbd block devices
> at client machines. However, I am not able to list rbd block devices. At
> the client machine, I first installed 0.48.2argonaut package for Ubuntu
> then I compiled and installed my own version according to instructions
> on this page ( http://ceph.com/docs/master/install/building-ceph/). The
> client failed to recognize the fifth bucket algorithm I added. I
> searched "unsupported bucket algorithm" in the ceph code base and that
> text only appeared in the src/crush/CrushWrapper.cc. I checked
> decode_crush_bucket() and it should be able to recognize the fifth
> algorithm. Even after I changed the error message (added print of
> "[XXX]" and values for two bucket algorithm macros), it still prints the
> same error message. So, it seems that my new version of CrushWrapper.cc
> is not used during compilation to create the final rbd binary. Would you
> please tell me where the problem is and how I can fix it? Thank you very
> much.
>

