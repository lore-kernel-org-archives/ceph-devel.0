From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Fri, 20 Dec 2013 01:35:34 -0200
Message-ID: <orbo0c5h4p.fsf@livre.home>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	<or38lq86ig.fsf@livre.home>
	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>
	<or4n656zij.fsf@livre.home> <52B2F44A.1050109@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:54003 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab3LTDgD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Dec 2013 22:36:03 -0500
In-Reply-To: <52B2F44A.1050109@intel.com> (Zheng Yan's message of "Thu, 19 Dec
	2013 21:27:38 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Dec 19, 2013, "Yan, Zheng" <zheng.z.yan@intel.com> wrote:

> next time you encountered log corruption, please open "new issues" at http://tracker.ceph.com/

I have saved the dumped journal, but it contains too much information
I'm not supposed to or willing to share, especially with a US-based
company in the post-Snowden era :-(  (something like btrfs-image -s
might be good to have)

I'd be glad to try to dig info that might be useful out of it, if told
how to do so, but uploading the journal as taken from the cluster is not
an option.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
