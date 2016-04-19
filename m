From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: jewel punch list
Date: Tue, 19 Apr 2016 15:05:54 -0400 (EDT)
Message-ID: <946594922.38798214.1461092754712.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1604181448220.4803@cpach.fuggernut.com> <CAJ4mKGYU=53qMvQgCMRk2i3bak3ZxXDrDLk-ZvZ_VeNbV-J-Kg@mail.gmail.com> <alpine.DEB.2.11.1604191455340.16393@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34041 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933162AbcDSTF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2016 15:05:56 -0400
In-Reply-To: <alpine.DEB.2.11.1604191455340.16393@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, dillaman@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

Jason's on vacation. I'll ack on his behalf.

----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "Gregory Farnum" <gfarnum@redhat.com>, dillaman@redhat.com
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, April 19, 2016 11:56:07 AM
> Subject: Re: jewel punch list
> 
> I just got a verbal ack from Sam and Yehuda.  Jason?
> 
> sage
> 
> 
> On Mon, 18 Apr 2016, Gregory Farnum wrote:
> 
> > Ack.
> > 
> > On Mon, Apr 18, 2016 at 12:57 PM, Sage Weil <sweil@redhat.com> wrote:
> > > I think we're in good shape.  Assuming the qa/workunit bit is fixed
> > > (let's
> > > do a rados run as soon as master builds), are we good for the 10.2.0
> > > release?  There is still the rgw leak, so please merge the parts that are
> > > safe and we'll backport any follow-on fixes.
> > >
> > > There is also one selinux issue (http://tracker.ceph.com/issues/15524)
> > > that we need to take care of before this goes out.  Yuri, are there other
> > > outstanding issues that we haven't addressed yet?
> > >
> > > Those items aside, can the leads and QA please ACK for a release?
> > >
> > > Thanks!
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
