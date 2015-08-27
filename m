From: Sage Weil <sweil@redhat.com>
Subject: Re: async messenger
Date: Thu, 27 Aug 2015 08:23:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508270821580.13116@cobra.newdream.net>
References: <alpine.DEB.2.00.1508241427170.13128@cobra.newdream.net> <CACJqLyZ_9AM+_9cPxdm-Ab7dFc-CKze5khZPQGBrDdjxRMSrdQ@mail.gmail.com> <CACJqLyapdDqvL5W3j9fZyH6BY0tRw8xVWKrsrKTdm2+vh7Uarg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133AbbH0PXG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Aug 2015 11:23:06 -0400
In-Reply-To: <CACJqLyapdDqvL5W3j9fZyH6BY0tRw8xVWKrsrKTdm2+vh7Uarg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just merged https://github.com/ceph/ceph-qa-suite/pull/544 so that this 
gets tested in all master rados runs.

This means we'll need larger --subset denomitators, btw, to keep the test 
count reasonable.

sage


On Thu, 27 Aug 2015, Haomai Wang wrote:

> I ran a random job(http://pulpito.ceph.com/haomai-2015-08-27_04:09:28-rados-master-distro-basic-multi/)
> and the result seemed ok to me.
> 
> On Tue, Aug 25, 2015 at 9:22 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> > On Tue, Aug 25, 2015 at 5:28 AM, Sage Weil <sweil@redhat.com> wrote:
> >> Hi Haomai,
> >>
> >> How did your most recent async messenger run go?
> >>
> >> If there aren't major issues, we'd like to start mixing it in with the
> >> regular rados suite by doing 'ms type = random'...
> >
> > From last run, we have no async related failed jobs. I would like to
> > scheduler a "random" type by hand to see whether have terrible
> > compatible problem.
> >
> >>
> >> sage
> >
> >
> >
> > --
> > Best Regards,
> >
> > Wheat
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
