From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: building boost statically
Date: Sat, 30 Apr 2016 03:24:24 +0000
Message-ID: <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
 <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
 <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
 <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:33664
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752368AbcD3DY3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2016 23:24:29 -0400
In-Reply-To: <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ken Dreyer <kdreyer@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Let's not wait. 

As another option. If all we're looking for is "small_vector", then I looked at taking the equivalent out of the Folly library a while ago. It looked like it would be relatively easy to hack up the one header file to make it standalone. Then we could just include it in the Ceph source tree as a common file (it's a header-only thing). Once we're confident that all of the relevant distro's are updated we can easily dispose of the file and do a top level rename. 


Allen Samuels
Software Architect, Fellow, Systems and Software Solutions 

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Friday, April 29, 2016 6:44 PM
> To: Ken Dreyer <kdreyer@redhat.com>
> Cc: Haomai Wang <haomai@xsky.com>; ceph-devel@vger.kernel.org
> Subject: Re: building boost statically
> 
> On Fri, 29 Apr 2016, Ken Dreyer wrote:
> > On Thu, Apr 28, 2016 at 8:31 PM, Haomai Wang <haomai@xsky.com>
> wrote:
> > > Yes, I'm always glad to see more deps removed!
> >
> > It's not removed, it's just moved. The Ceph project will then be on
> > the hook for all boost security updates.
> >
> > I think we should bundle less not more.  Build times are already long
> enough...
> 
> If building separate packages and including them in all the repos is in fact
> easier, that seems like the right choice.  Static linkage makes development
> easier, but we can make do.
> 
> Whether it's static or dynamic, though, we're on the hook for updating the
> packages for bugs or security update either way.  Unless we just give up an
> wait for the distros to catch up, but I don't think that's a viable option...
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
