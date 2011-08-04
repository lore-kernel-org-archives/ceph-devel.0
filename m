From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: read performance not perfect
Date: Thu, 4 Aug 2011 19:36:20 +0000 (UTC)
Message-ID: <loom.20110804T213454-854@post.gmane.org>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com> <Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net> <CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com> <Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57130 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105Ab1HDTge (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Aug 2011 15:36:34 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Qp3ia-0005uw-Mx
	for ceph-devel@vger.kernel.org; Thu, 04 Aug 2011 21:36:32 +0200
Received: from 94.232.181.14 ([94.232.181.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 04 Aug 2011 21:36:32 +0200
Received: from ufm by 94.232.181.14 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 04 Aug 2011 21:36:32 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> newdream.net> writes:

> 
> Hi,
> 
> I've just pushed a wip-readahead branch to ceph-client.git that rewrites 
> ceph_readpages (used for readahead) to be fully asynchronous.  This should 
> let us take full advantage of whatever the readahead window is.  I'm still 
> doing some testing on this end, but things look good so far.

As I understand it's available only in kernel 3.1 ?

WBR,
    Fyodor.

