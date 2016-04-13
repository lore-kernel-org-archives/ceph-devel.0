From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-qa] ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 15:09:27 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604131507440.29593@cpach.fuggernut.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com> <CAKPXa=Y5rJ4ygM9Sdvys+86RwufnKopTOkMNdPHcpCh5bFbQ0w@mail.gmail.com> <CALe9h7f3OFobvNscxMTmoSSkxf2PfG71wPqAJ8mTWEBKpGH3Dw@mail.gmail.com>
 <CAKPXa=YF7aP7EyYUH2zM0XaDdtOso8EKDKnFDf8o2Q8kREKDqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638AbcDMTJ3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2016 15:09:29 -0400
In-Reply-To: <CAKPXa=YF7aP7EyYUH2zM0XaDdtOso8EKDKnFDf8o2Q8kREKDqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

On Wed, 13 Apr 2016, Vasu Kulkarni wrote:
> On Wed, Apr 13, 2016 at 11:46 AM, John Spray <jspray@redhat.com> wrote:
> > On Wed, Apr 13, 2016 at 7:02 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
> >>
> >>
> >> On Wed, Apr 13, 2016 at 3:52 AM, John Spray <jspray@redhat.com> wrote:
> >>>
> >>> Lately, we've instances where ceph.git and ceph-qa-suite.git got
> >>> slightly out of sync, as we were adding new stuff and interface
> >>> changes to ceph (especially in cephfs).
> >>>
> >>> We used to have two repos (ceph and teuthology), now we have three
> >>> (ceph, ceph-qa-suite and teuthology).
> >>
> >>
> >> we also have s3 suites in its own repo, we have big files in ceph.com/qa
> >> which i believe is the right place.
> >
> > I'm a bit ignorant of the s3 tests, is there a particular reason they
> > live separately to the main ceph-qa-suite?
> 
> Not sure, probably yehuda wanted to make it easier to test with
> Amazon::S3 and Ceph

The goal was to make them an independently useful set of functional tests 
for the S3 API, used not just by radosgw but also by other projects, so 
that we are not solely responsible for maintaining them.  I think it makes 
sense to keep them separate.

sage
