From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: sync Ceph packaging efforts for Debian/Ubuntu
Date: Thu, 28 Jun 2012 05:39:15 +0000
Message-ID: <1340861955.16563.33.camel@julia>
References: <1339805412.7726.160.camel@julia>
	 <Pine.LNX.4.64.1206161442230.20239@cobra.newdream.net>
	 <4FDF0276.8030304@ubuntu.com>
	 <Pine.LNX.4.64.1206180926100.9362@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:47522 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab2F1Fj1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 01:39:27 -0400
In-Reply-To: <Pine.LNX.4.64.1206180926100.9362@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: James Page <james.page@ubuntu.com>, Ben Collins <bcollins@ubuntu.com>, clint@fewbar.com, Ceph Development <ceph-devel@vger.kernel.org>, openstack-devel@lists.alioth.debian.org

Hi all,

On Mon, 2012-06-18 at 09:44 -0700, Sage Weil wrote:
> On Mon, 18 Jun 2012, James Page wrote:
> > Laszlo - thanks for sending the original email - I'd like to get
> > everything as closely in-sync as possible between the three packaging
> > sources as well.
 It seems I could sync with Ubuntu a bit, but you need to get libs3 and
sync that with me if appreciated.

> > On 16/06/12 22:50, Sage Weil wrote:
> > > - Has the leveldb patch been sent upstream?  Once it is committed to 
> > > the upstream git, we can update ceph to use it; that's nicer than carrying 
> > > the patch.  However, I thought you needed to link against the existing
> > > libleveldb1 package... which means we shouldn't do anything on our
> > > side,
> > > right?
 Yes, the leveldb maintainer tries to port it to all architectures. It
would be better to join efforts on this topic.
Especially that Ceph is unbuildable on mips, powerpc, s390, s390x and
sparc architectures (where previously it was built) due to leveldb is
unbuildable on them. This means Ceph looses a lot of and big users. :(

> > > - That same patch also switched all the Architecture: lines back to 
> > > linux-any.  Was that intentional?  I just changed them from that last 
> > > week.
 Well, mostly. My step that Ceph and later leveldb should be limited to
the archs where it's buildable is not accepted. Porting is going on for
leveldb, but I still don't see that it will support all archs for
Wheezy. Sorry for the extra work it caused.

> Okay, keep us posted! 
 To ones whom it may concerns, Ceph 0.47.2 is passed the new queue and
accepted for Wheezy. This means that adding it to OpenStack can start.

> I pushed a new 'debian' branch with those changes; please take a look and 
> let me know if it loks okay.
 Will do. Now I've to run.

Regards,
Laszlo/GCS

