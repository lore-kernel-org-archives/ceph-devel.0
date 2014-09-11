From: Sage Weil <sweil@redhat.com>
Subject: RE: OpTracker optimization
Date: Wed, 10 Sep 2014 20:33:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409102032440.17200@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783A845@SACMBXIP02.sdcorp.global.sandisk.com> <CA+4uBUbSrYhy8=ZPKZ7dOTh0sNNCs5mC3ttgBH+qoWO+58UdvA@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2783C56D@SACMBXIP02.sdcorp.global.sandisk.com>
 <CA+4uBUbTBksZbRxR9RCTws-O--2N+QnHN5aS_Kx-D7yVeEmiDw@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2783C636@SACMBXIP02.sdcorp.global.sandisk.com> <CA+4uBUaaycvVCnjtDCEZO3i9iFB7FifK-+xZwtEcemC7XGPiTg@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2783C65C@SACMBXIP02.sdcorp.global.sandisk.com> <CA+4uBUboaU=1uWT7_kNB+ViK0sOOeB4hJKpCVQ397OjWpY83tQ@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2783C7E4@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53304 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaIKDdX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 23:33:23 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783C7E4@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

I had two substantiative comments on the first patch and then some trivial 
whitespace nits.    Otherwise looks good!

tahnks-
sage

On Thu, 11 Sep 2014, Somnath Roy wrote:

> Sam/Sage,
> I have incorporated all of your comments. Please have a look at the same pull request.
> 
> https://github.com/ceph/ceph/pull/2440
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Samuel Just [mailto:sam.just@inktank.com] 
> Sent: Wednesday, September 10, 2014 3:25 PM
> To: Somnath Roy
> Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
> Subject: Re: OpTracker optimization
> 
> Oh, I changed my mind, your approach is fine.  I was unclear.
> Currently, I just need you to address the other comments.
> -Sam
> 
> On Wed, Sep 10, 2014 at 3:13 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > As I understand, you want me to implement the following.
> >
> > 1.  Keep this implementation one sharded optracker for the ios going through ms_dispatch path.
> >
> > 2. Additionally, for ios going through ms_fast_dispatch, you want me 
> > to implement optracker (without internal shard) per opwq shard
> >
> > Am I right ?
> >
> > Thanks & Regards
> > Somnath
> >
> > -----Original Message-----
> > From: Samuel Just [mailto:sam.just@inktank.com]
> > Sent: Wednesday, September 10, 2014 3:08 PM
> > To: Somnath Roy
> > Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org; 
> > ceph-users@lists.ceph.com
> > Subject: Re: OpTracker optimization
> >
> > I don't quite understand.
> > -Sam
> >
> > On Wed, Sep 10, 2014 at 2:38 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> >> Thanks Sam.
> >> So, you want me to go with optracker/shadedopWq , right ?
> >>
> >> Regards
> >> Somnath
> >>
> >> -----Original Message-----
> >> From: Samuel Just [mailto:sam.just@inktank.com]
> >> Sent: Wednesday, September 10, 2014 2:36 PM
> >> To: Somnath Roy
> >> Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org; 
> >> ceph-users@lists.ceph.com
> >> Subject: Re: OpTracker optimization
> >>
> >> Responded with cosmetic nonsense.  Once you've got that and the other comments addressed, I can put it in wip-sam-testing.
> >> -Sam
> >>
> >> On Wed, Sep 10, 2014 at 1:30 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> >>> Thanks Sam..I responded back :-)
> >>>
> >>> -----Original Message-----
> >>> From: ceph-devel-owner@vger.kernel.org 
> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Samuel Just
> >>> Sent: Wednesday, September 10, 2014 11:17 AM
> >>> To: Somnath Roy
> >>> Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org; 
> >>> ceph-users@lists.ceph.com
> >>> Subject: Re: OpTracker optimization
> >>>
> >>> Added a comment about the approach.
> >>> -Sam
> >>>
> >>> On Tue, Sep 9, 2014 at 1:33 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> >>>> Hi Sam/Sage,
> >>>>
> >>>> As we discussed earlier, enabling the present OpTracker code 
> >>>> degrading performance severely. For example, in my setup a single 
> >>>> OSD node with
> >>>> 10 clients is reaching ~103K read iops with io served from memory 
> >>>> while optracking is disabled but enabling optracker it is reduced to ~39K iops.
> >>>> Probably, running OSD without enabling OpTracker is not an option 
> >>>> for many of Ceph users.
> >>>>
> >>>> Now, by sharding the Optracker:: ops_in_flight_lock (thus xlist
> >>>> ops_in_flight) and removing some other bottlenecks I am able to 
> >>>> match the performance of OpTracking enabled OSD with OpTracking 
> >>>> disabled, but with the expense of ~1 extra cpu core.
> >>>>
> >>>> In this process I have also fixed the following tracker.
> >>>>
> >>>>
> >>>>
> >>>> http://tracker.ceph.com/issues/9384
> >>>>
> >>>>
> >>>>
> >>>> and probably http://tracker.ceph.com/issues/8885 too.
> >>>>
> >>>>
> >>>>
> >>>> I have created following pull request for the same. Please review it.
> >>>>
> >>>>
> >>>>
> >>>> https://github.com/ceph/ceph/pull/2440
> >>>>
> >>>>
> >>>>
> >>>> Thanks & Regards
> >>>>
> >>>> Somnath
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> ________________________________
> >>>>
> >>>> PLEASE NOTE: The information contained in this electronic mail 
> >>>> message is intended only for the use of the designated recipient(s) 
> >>>> named above. If the reader of this message is not the intended 
> >>>> recipient, you are hereby notified that you have received this 
> >>>> message in error and that any review, dissemination, distribution, 
> >>>> or copying of this message is strictly prohibited. If you have 
> >>>> received this communication in error, please notify the sender by 
> >>>> telephone or e-mail (as shown above) immediately and destroy any 
> >>>> and all copies of this message in your possession (whether hard copies or electronically stored copies).
> >>>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>> in the body of a message to majordomo@vger.kernel.org More majordomo 
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>> ________________________________
> >>>
> >>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> >>>
> 
