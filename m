From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: Luminous v12.2.3 approvals
Date: Thu, 8 Feb 2018 12:04:55 -0600
Message-ID: <CAEPMp+7dszOCNALdSGpFpLdxTjFB-yEOCJf6kAMSnShZZuzGAQ@mail.gmail.com>
References: <87vafa2frf.fsf@suse.com> <0471458e-4805-ebef-910e-e497c3173f6f@redhat.com>
 <87k1vn30h5.fsf@suse.com> <alpine.DEB.2.11.1802081656290.15996@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:40150 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBHSFg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 13:05:36 -0500
Received: by mail-qk0-f174.google.com with SMTP id e20so6771784qkm.7
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 10:05:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1802081656290.15996@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Thu, Feb 8, 2018 at 10:56 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 8 Feb 2018, Abhishek Lekshmanan wrote:
>> Josh Durgin <jdurgin@redhat.com> writes:
>>
>> > On 02/06/2018 09:24 AM, Abhishek Lekshmanan wrote:
>> >> These are the current list of PRs currently undergoing/waiting QE for Luminous v12.2.3
>> >> https://github.com/ceph/ceph/labels/luminous-batch-1
>> >>
>> >> Assuming teuthology is happy with these, leads, are we ready to cut
>> >> 12.2.3 or are there more PRs that we need to wait for?
>>
>> Sage, John, Patrick, Yehuda/Matt, are we good to handover to QE?
>
> I think so!
> sage

Sage, do you think this will get in? https://github.com/ceph/ceph/pull/19939

ceph-volume's --crush-device-class flag now depends on that PR.

Thanks,
Andrew
