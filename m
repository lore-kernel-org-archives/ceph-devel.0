From: Sage Weil <sweil@redhat.com>
Subject: Re: Luminous v12.2.3 approvals
Date: Thu, 8 Feb 2018 18:41:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802081840140.24931@piezo.novalocal>
References: <87vafa2frf.fsf@suse.com> <0471458e-4805-ebef-910e-e497c3173f6f@redhat.com> <87k1vn30h5.fsf@suse.com> <alpine.DEB.2.11.1802081656290.15996@piezo.novalocal> <CAEPMp+7dszOCNALdSGpFpLdxTjFB-yEOCJf6kAMSnShZZuzGAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeBHSlP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:41:15 -0500
In-Reply-To: <CAEPMp+7dszOCNALdSGpFpLdxTjFB-yEOCJf6kAMSnShZZuzGAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Thu, 8 Feb 2018, Andrew Schoen wrote:
> On Thu, Feb 8, 2018 at 10:56 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Thu, 8 Feb 2018, Abhishek Lekshmanan wrote:
> >> Josh Durgin <jdurgin@redhat.com> writes:
> >>
> >> > On 02/06/2018 09:24 AM, Abhishek Lekshmanan wrote:
> >> >> These are the current list of PRs currently undergoing/waiting QE for Luminous v12.2.3
> >> >> https://github.com/ceph/ceph/labels/luminous-batch-1
> >> >>
> >> >> Assuming teuthology is happy with these, leads, are we ready to cut
> >> >> 12.2.3 or are there more PRs that we need to wait for?
> >>
> >> Sage, John, Patrick, Yehuda/Matt, are we good to handover to QE?
> >
> > I think so!
> > sage
> 
> Sage, do you think this will get in? https://github.com/ceph/ceph/pull/19939
> 
> ceph-volume's --crush-device-class flag now depends on that PR.

I addressed Kefu's test concern and pushed a built to test against master.  
If we include it in .3 it'd be last minute; inclined to wait and get .3 
testing going!

sage
