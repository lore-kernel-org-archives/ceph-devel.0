From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Luminous v12.2.3 approvals
Date: Thu, 8 Feb 2018 21:18:24 +0100
Message-ID: <CAEw75dP-K4xZYNVFe+onT3XqORvdRg38M4bKdvttmPtdqGH3qw@mail.gmail.com>
References: <87vafa2frf.fsf@suse.com> <0471458e-4805-ebef-910e-e497c3173f6f@redhat.com>
 <87k1vn30h5.fsf@suse.com> <alpine.DEB.2.11.1802081656290.15996@piezo.novalocal>
 <CAEPMp+7dszOCNALdSGpFpLdxTjFB-yEOCJf6kAMSnShZZuzGAQ@mail.gmail.com> <alpine.DEB.2.11.1802081840140.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:45264 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeBHUSZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 15:18:25 -0500
Received: by mail-io0-f178.google.com with SMTP id p188so7125241ioe.12
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 12:18:25 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1802081840140.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Andrew Schoen <aschoen@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Thu, Feb 8, 2018 at 7:41 PM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 8 Feb 2018, Andrew Schoen wrote:
>> On Thu, Feb 8, 2018 at 10:56 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Thu, 8 Feb 2018, Abhishek Lekshmanan wrote:
>> >> Josh Durgin <jdurgin@redhat.com> writes:
>> >>
>> >> > On 02/06/2018 09:24 AM, Abhishek Lekshmanan wrote:
>> >> >> These are the current list of PRs currently undergoing/waiting QE for Luminous v12.2.3
>> >> >> https://github.com/ceph/ceph/labels/luminous-batch-1
>> >> >>
>> >> >> Assuming teuthology is happy with these, leads, are we ready to cut
>> >> >> 12.2.3 or are there more PRs that we need to wait for?
>> >>
>> >> Sage, John, Patrick, Yehuda/Matt, are we good to handover to QE?
>> >
>> > I think so!
>> > sage
>>
>> Sage, do you think this will get in? https://github.com/ceph/ceph/pull/19939
>>
>> ceph-volume's --crush-device-class flag now depends on that PR.
>
> I addressed Kefu's test concern and pushed a built to test against master.
> If we include it in .3 it'd be last minute; inclined to wait and get .3
> testing going!

Great! Yuri this means that we can start final round of QE on luminous,
I've pushed to luminous-rc in ceph/ceph with the current tip of luminous at

22c6b1d3d6bbc7ee466fddd3af13bcdb7f0c9a55



Best,
Abhishek




> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
