From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH V6] ceph: use vfs __set_page_dirty_nobuffers interface
 instead of doing it inside filesystem
Date: Thu, 22 Aug 2013 08:51:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308220850330.12830@cobra.newdream.net>
References: <1377073654-6232-1-git-send-email-handai.szj@taobao.com> <alpine.DEB.2.00.1308210835050.1492@cobra.newdream.net> <CAFj3OHUKx8RnFWdK+4k+AwLsv1PhtFvXRSO+0hcMXQVC_ZXDvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56271 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3HVPvK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 11:51:10 -0400
In-Reply-To: <CAFj3OHUKx8RnFWdK+4k+AwLsv1PhtFvXRSO+0hcMXQVC_ZXDvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sha Zhengju <handai.szj@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <ukernel@gmail.com>, Michal Hocko <mhocko@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Sha Zhengju <handai.szj@taobao.com>

On Thu, 22 Aug 2013, Sha Zhengju wrote:
> On Wed, Aug 21, 2013 at 11:35 PM, Sage Weil <sage@inktank.com> wrote:
> > On Wed, 21 Aug 2013, Sha Zhengju wrote:
> >> Following we will begin to add memcg dirty page accounting around
> >> __set_page_dirty_{buffers,nobuffers} in vfs layer, so we'd better use vfs interface to
> >> avoid exporting those details to filesystems.
> >>
> >> Since vfs set_page_dirty() should be called under page lock, here we don't need elaborate
> >> codes to handle racy anymore, and two WARN_ON() are added to detect such exceptions.
> >> Thanks very much for Sage and Yan Zheng's coaching!
> >>
> >> I tested it in a two server's ceph environment that one is client and the other is
> >> mds/osd/mon, and run the following fsx test from xfstests:
> >>
> >>   ./fsx   1MB -N 50000 -p 10000 -l 1048576
> >>   ./fsx  10MB -N 50000 -p 10000 -l 10485760
> >>   ./fsx 100MB -N 50000 -p 10000 -l 104857600
> >>
> >> The fsx does lots of mmap-read/mmap-write/truncate operations and the tests completed
> >> successfully without triggering any of WARN_ON.
> >>
> >> Signed-off-by: Sha Zhengju <handai.szj@taobao.com>
> >
> > Reviewed-by: Sage Weil <sage@inktank.com>
> >
> > Would you like me to take this through the ceph tree?
> >
> 
> Yes, of course.  : )
> BTW I lost my from:    From: Sha Zhengju <handai.szj@taobao.com>

Fixed the authorship and pushed to the testing branch.  Assuming it's 
stable under testing this will go upstream in the next window.

Thanks!
sage

