From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Fri, 20 Dec 2013 16:03:42 +0800
Message-ID: <52B3F9DE.60301@intel.com>
References: <oriounafd8.fsf@livre.home>	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>	<or38lq86ig.fsf@livre.home>	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>	<or4n656zij.fsf@livre.home> <52B2F44A.1050109@intel.com> <orbo0c5h4p.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42551 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab3LTID7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Dec 2013 03:03:59 -0500
In-Reply-To: <orbo0c5h4p.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/20/2013 11:35 AM, Alexandre Oliva wrote:
> On Dec 19, 2013, "Yan, Zheng" <zheng.z.yan@intel.com> wrote:
> 
>> next time you encountered log corruption, please open "new issues" at http://tracker.ceph.com/
> 
> I have saved the dumped journal, but it contains too much information
> I'm not supposed to or willing to share, especially with a US-based
> company in the post-Snowden era :-(  (something like btrfs-image -s
> might be good to have)
> 
> I'd be glad to try to dig info that might be useful out of it, if told
> how to do so, but uploading the journal as taken from the cluster is not
> an option.
> 

can you send out the mds log (the latest few hundreds of lines) when the mds crashed.

Regards
Yan, Zheng
