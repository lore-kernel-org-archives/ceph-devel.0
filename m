From: Sage Weil <sage@newdream.net>
Subject: Re: Filesystems for ceph
Date: Wed, 27 Jul 2011 21:35:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107272133000.29447@cobra.newdream.net>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
 <loom.20110728T001529-856@post.gmane.org> <Pine.LNX.4.64.1107271633110.29985@cobra.newdream.net>
 <4E30E42E.30101@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37720 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab1G1Ebn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 00:31:43 -0400
In-Reply-To: <4E30E42E.30101@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Thu, 28 Jul 2011, Fyodor Ustinov wrote:
> On 07/28/2011 02:33 AM, Sage Weil wrote:
> > On Wed, 27 Jul 2011, Fyodor Ustinov wrote:
> > > Christian Brunner<chb<at>  muc.de>  writes:
> > > 
> > > >  From what I read in Fyodors emails ext4 in 2.6.39 isn't much better.
> > > > 
> > > > So, what filesystem would you recommend?
> > > > 
> > > Christian, IMHO ext3/ext4/btrfs unusable for ceph. I tested some time xfs,
> > > and
> > > think to use it again. But I think that the ceph developers do not like
> > > xfs:)
> > What problems have you seen with ext4?
>
> Look to my message to Greg. In a nutshell - I again have broken ext4 fs 
> on OSD servers with 2.6.39 kernel.

Oh, you mean the fsck errors?  Got it.  If you see it again (on another 
disk/machine, with a reasonably fresh fs) the ext4 guys will be interested 
in hearing about it.  It's probably in the xattr code, which ceph uses 
heavily but most people only set once per file (for selinux labels), if 
at all.

sage
