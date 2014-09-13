From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: OpTracker optimization
Date: Sat, 13 Sep 2014 07:32:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409130731180.29849@cobra.newdream.net>
References: <0b0459cc-3a8b-485f-9c69-d64c92d6c3dd@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <0b0459cc-3a8b-485f-9c69-d64c92d6c3dd@mailpro>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Sat, 13 Sep 2014, Alexandre DERUMIER wrote:
> Hi,
> as ceph user, It could be wonderfull to have it for Giant,
> optracker performance impact is really huge (See my ssd benchmark on ceph user mailing)

Definitely.  More importantly, it resolves a few crashes we've observed. 
It's going through some testing right now, but once that's done it'll go 
into giant.

sage


> 
> Regards,
> 
> Alexandre Derumier
> 
> ----- Mail original ----- 
> 
> De: "Somnath Roy" <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> 
> ?: "Samuel Just" <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> 
> Cc: "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> Envoy?: Samedi 13 Septembre 2014 10:03:52 
> Objet: Re: [ceph-users] OpTracker optimization 
> 
> Sam/Sage, 
> I saw Giant is forked off today. We need the pull request (https://github.com/ceph/ceph/pull/2440) to be in Giant. So, could you please merge this into Giant when it will be ready ? 
> 
> Thanks & Regards 
> Somnath 
> 
> -----Original Message----- 
> From: Samuel Just [mailto:sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org] 
> Sent: Thursday, September 11, 2014 11:31 AM 
> To: Somnath Roy 
> Cc: Sage Weil; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> Subject: Re: OpTracker optimization 
> 
> Just added it to wip-sam-testing. 
> -Sam 
> 
> On Thu, Sep 11, 2014 at 11:30 AM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote: 
> > Sam/Sage, 
> > I have addressed all of your comments and pushed the changes to the same pull request. 
> > 
> > https://github.com/ceph/ceph/pull/2440 
> > 
> > Thanks & Regards 
> > Somnath 
> > 
> > -----Original Message----- 
> > From: Sage Weil [mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org] 
> > Sent: Wednesday, September 10, 2014 8:33 PM 
> > To: Somnath Roy 
> > Cc: Samuel Just; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> > Subject: RE: OpTracker optimization 
> > 
> > I had two substantiative comments on the first patch and then some trivial 
> > whitespace nits. Otherwise looks good! 
> > 
> > tahnks- 
> > sage 
> > 
> > On Thu, 11 Sep 2014, Somnath Roy wrote: 
> > 
> >> Sam/Sage, 
> >> I have incorporated all of your comments. Please have a look at the same pull request. 
> >> 
> >> https://github.com/ceph/ceph/pull/2440 
> >> 
> >> Thanks & Regards 
> >> Somnath 
> >> 
> >> -----Original Message----- 
> >> From: Samuel Just [mailto:sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org] 
> >> Sent: Wednesday, September 10, 2014 3:25 PM 
> >> To: Somnath Roy 
> >> Cc: Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org); ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> >> Subject: Re: OpTracker optimization 
> >> 
> >> Oh, I changed my mind, your approach is fine. I was unclear. 
> >> Currently, I just need you to address the other comments. 
> >> -Sam 
> >> 
> >> On Wed, Sep 10, 2014 at 3:13 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote: 
> >> > As I understand, you want me to implement the following. 
> >> > 
> >> > 1. Keep this implementation one sharded optracker for the ios going through ms_dispatch path. 
> >> > 
> >> > 2. Additionally, for ios going through ms_fast_dispatch, you want 
> >> > me to implement optracker (without internal shard) per opwq shard 
> >> > 
> >> > Am I right ? 
> >> > 
> >> > Thanks & Regards 
> >> > Somnath 
> >> > 
> >> > -----Original Message----- 
> >> > From: Samuel Just [mailto:sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org] 
> >> > Sent: Wednesday, September 10, 2014 3:08 PM 
> >> > To: Somnath Roy 
> >> > Cc: Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org); ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> >> > Subject: Re: OpTracker optimization 
> >> > 
> >> > I don't quite understand. 
> >> > -Sam 
> >> > 
> >> > On Wed, Sep 10, 2014 at 2:38 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote: 
> >> >> Thanks Sam. 
> >> >> So, you want me to go with optracker/shadedopWq , right ? 
> >> >> 
> >> >> Regards 
> >> >> Somnath 
> >> >> 
> >> >> -----Original Message----- 
> >> >> From: Samuel Just [mailto:sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org] 
> >> >> Sent: Wednesday, September 10, 2014 2:36 PM 
> >> >> To: Somnath Roy 
> >> >> Cc: Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org); ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> >> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> >> >> Subject: Re: OpTracker optimization 
> >> >> 
> >> >> Responded with cosmetic nonsense. Once you've got that and the other comments addressed, I can put it in wip-sam-testing. 
> >> >> -Sam 
> >> >> 
> >> >> On Wed, Sep 10, 2014 at 1:30 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote: 
> >> >>> Thanks Sam..I responded back :-) 
> >> >>> 
> >> >>> -----Original Message----- 
> >> >>> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> >> >>> [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Samuel 
> >> >>> Just 
> >> >>> Sent: Wednesday, September 10, 2014 11:17 AM 
> >> >>> To: Somnath Roy 
> >> >>> Cc: Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org); ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> >> >>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> >> >>> Subject: Re: OpTracker optimization 
> >> >>> 
> >> >>> Added a comment about the approach. 
> >> >>> -Sam 
> >> >>> 
> >> >>> On Tue, Sep 9, 2014 at 1:33 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote: 
> >> >>>> Hi Sam/Sage, 
> >> >>>> 
> >> >>>> As we discussed earlier, enabling the present OpTracker code 
> >> >>>> degrading performance severely. For example, in my setup a 
> >> >>>> single OSD node with 
> >> >>>> 10 clients is reaching ~103K read iops with io served from 
> >> >>>> memory while optracking is disabled but enabling optracker it is reduced to ~39K iops. 
> >> >>>> Probably, running OSD without enabling OpTracker is not an 
> >> >>>> option for many of Ceph users. 
> >> >>>> 
> >> >>>> Now, by sharding the Optracker:: ops_in_flight_lock (thus xlist 
> >> >>>> ops_in_flight) and removing some other bottlenecks I am able to 
> >> >>>> match the performance of OpTracking enabled OSD with OpTracking 
> >> >>>> disabled, but with the expense of ~1 extra cpu core. 
> >> >>>> 
> >> >>>> In this process I have also fixed the following tracker. 
> >> >>>> 
> >> >>>> 
> >> >>>> 
> >> >>>> http://tracker.ceph.com/issues/9384 
> >> >>>> 
> >> >>>> 
> >> >>>> 
> >> >>>> and probably http://tracker.ceph.com/issues/8885 too. 
> >> >>>> 
> >> >>>> 
> >> >>>> 
> >> >>>> I have created following pull request for the same. Please review it. 
> >> >>>> 
> >> >>>> 
> >> >>>> 
> >> >>>> https://github.com/ceph/ceph/pull/2440 
> >> >>>> 
> >> >>>> 
> >> >>>> 
> >> >>>> Thanks & Regards 
> >> >>>> 
> >> >>>> Somnath 
> >> >>>> 
> >> >>>> 
> >> >>>> 
> >> >>>> 
> >> >>>> ________________________________ 
> >> >>>> 
> >> >>>> PLEASE NOTE: The information contained in this electronic mail 
> >> >>>> message is intended only for the use of the designated 
> >> >>>> recipient(s) named above. If the reader of this message is not 
> >> >>>> the intended recipient, you are hereby notified that you have 
> >> >>>> received this message in error and that any review, 
> >> >>>> dissemination, distribution, or copying of this message is 
> >> >>>> strictly prohibited. If you have received this communication in 
> >> >>>> error, please notify the sender by telephone or e-mail (as shown 
> >> >>>> above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies). 
> >> >>>> 
> >> >>> -- 
> >> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> >> >>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More 
> >> >>> majordomo info at http://vger.kernel.org/majordomo-info.html 
> >> >>> 
> >> >>> ________________________________ 
> >> >>> 
> >> >>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies). 
> >> >>> 
> >> 
> _______________________________________________ 
> ceph-users mailing list 
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
