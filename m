From: Jeff Cody <jcody@redhat.com>
Subject: Re: [RFC v6] RBD: Add support readv,writev for rbd
Date: Fri, 24 Feb 2017 06:42:22 -0500
Message-ID: <20170224114222.GA16659@localhost.localdomain>
References: <20170221065003.26103-1-jazeltq@gmail.com>
 <20170224035236.GB2613@localhost.localdomain>
 <CAKZcxgcWpz5g-WdeFNu8Ad_4PQZMPHoJDmn_1HENntVLLZG_Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbdBXLmZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Feb 2017 06:42:25 -0500
Content-Disposition: inline
In-Reply-To: <CAKZcxgcWpz5g-WdeFNu8Ad_4PQZMPHoJDmn_1HENntVLLZG_Jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel <ceph-devel@vger.kernel.org>, tianqing <tianqing@unitedstack.com>

On Fri, Feb 24, 2017 at 02:09:31PM +0800, Jaze Lee wrote:
> 2017-02-24 11:52 GMT+08:00 Jeff Cody <jcody@redhat.com>:
> > On Tue, Feb 21, 2017 at 02:50:03PM +0800, jazeltq@gmail.com wrote:
> >> From: tianqing <tianqing@unitedstack.com>
> >>
> >> Rbd can do readv and writev directly, so wo do not need to transform
> >> iov to buf or vice versa any more.
> >>
> >> Signed-off-by: tianqing <tianqing@unitedstack.com>
> >> ---
> >
> >
> > This is marked as an RFC still - is this a series you would like to see in
> > 2.9?
> 
> Yes.   What should i do if i like it in 2.9
>

Ideally you would submit the series as a non-RFC patch (that is, it would
have progressed to a normal patch away from RFC).

But in this case, it seems to me that this patch has progressed beyond RFC;
is there any reason it is still marked as RFC instead of just a patch?  It
looks OK to me.

