From: Sage Weil <sage@inktank.com>
Subject: Re: Proposed change to vstart.sh
Date: Mon, 22 Oct 2012 09:40:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210220940020.31573@cobra.newdream.net>
References: <508469CE.3000502@gmail.com> <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net> <508562A1.2040106@gmail.com> <50856F74.8020001@inktank.com> <508575C0.9080700@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57592 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab2JVQkw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:40:52 -0400
In-Reply-To: <508575C0.9080700@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <jbbuck@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 22 Oct 2012, Joe Buck wrote:
> Sam,
> 
> Here's the last few lines printed when I start vstart.sh
> 
> ./vstart.sh: 397: ./vstart.sh: btrfs: not found
> add osd0 7cf25a23-32dd-4b82-b9d4-d514eb857d02
> 2012-10-22 09:31:46.788605 7ff87bb4e780 -1 unable to authenticate as
> client.admin
> 2012-10-22 09:31:46.790370 7ff87bb4e780 -1 ceph_tool_common_init failed.
> 
> I'm invoking vstart.sh like so (my version has the patch I sent out this
> morning applied):
> ./vstart.sh -d -n -l -X
> 
> The line in vstart.sh that seems to tank is:
> 
> $SUDO $CEPH_ADM osd create $uuid

Possibly related: I just pushed a patch to master that enables cephx auth 
by default.  For the -X case we need to put in ceph.conf:

	auth cluster required = 
	auth service required = 

s
> 
> -Joe Buck
> 
> On 10/22/2012 09:08 AM, Sam Lang wrote:
> > On 10/22/2012 10:13 AM, Joe Buck wrote:
> > > On 10/21/2012 02:35 PM, Sage Weil wrote:
> > 
> > > > Also, we should fix the auth none usage at some point.  :)
> > 
> > I made some changes a while back to fix the auth none problems with vstart
> > (https://github.com/ceph/ceph/commit/0f7c516f3e1f37c5869f8fbff67f53ca0c90568c).
> > The -x help text inversion was a bug on my part.
> > 
> > Joe what errors do you get with auth none?  I'm able to do vstart.sh -n -l
> > (without the -x/-X changes) successfully.
> > 
> > -sam
> > 
> > > > 
> > > > sage
> > > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
