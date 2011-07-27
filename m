From: Sage Weil <sage@newdream.net>
Subject: Re: Filesystems for ceph
Date: Wed, 27 Jul 2011 16:33:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107271633110.29985@cobra.newdream.net>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
 <loom.20110728T001529-856@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47775 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab1G0X31 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 19:29:27 -0400
In-Reply-To: <loom.20110728T001529-856@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Wed, 27 Jul 2011, Fyodor Ustinov wrote:
> Christian Brunner <chb <at> muc.de> writes:
> 
> > 
> > From what I read in Fyodors emails ext4 in 2.6.39 isn't much better.
> > 
> > So, what filesystem would you recommend?
> > 
> 
> Christian, IMHO ext3/ext4/btrfs unusable for ceph. I tested some time xfs, and 
> think to use it again. But I think that the ceph developers do not like xfs:)

What problems have you seen with ext4?

sage
