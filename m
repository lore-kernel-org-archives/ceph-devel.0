From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Filesystems for ceph
Date: Wed, 27 Jul 2011 22:21:21 +0000 (UTC)
Message-ID: <loom.20110728T001529-856@post.gmane.org>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36450 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393Ab1G0WVd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Jul 2011 18:21:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QmCTr-000797-NJ
	for ceph-devel@vger.kernel.org; Thu, 28 Jul 2011 00:21:31 +0200
Received: from 94.232.181.14 ([94.232.181.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 00:21:31 +0200
Received: from ufm by 94.232.181.14 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 00:21:31 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Christian Brunner <chb <at> muc.de> writes:

> 
> From what I read in Fyodors emails ext4 in 2.6.39 isn't much better.
> 
> So, what filesystem would you recommend?
> 

Christian, IMHO ext3/ext4/btrfs unusable for ceph. I tested some time xfs, and 
think to use it again. But I think that the ceph developers do not like xfs:)

WBR,
    Fyodor.



