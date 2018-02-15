From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: 12.2.3 QE Luminous validation status
Date: Thu, 15 Feb 2018 11:58:20 -0500
Message-ID: <CA+aFP1B5qOcpWY+KD8Qm2RNX=mCimAhAf0eFT-T4ruGj6P2WhQ@mail.gmail.com>
References: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
 <1518632155.13566.22.camel@redhat.com> <CAMMFjmFrssPwEx_9YGkeJsW941YHsNin9+Tdua8FtAgJJd=7wg@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:38812 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426756AbeBOQ6V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Feb 2018 11:58:21 -0500
Received: by mail-yw0-f181.google.com with SMTP id w78so187041ywd.5
        for <ceph-devel@vger.kernel.org>; Thu, 15 Feb 2018 08:58:21 -0800 (PST)
In-Reply-To: <CAMMFjmFrssPwEx_9YGkeJsW941YHsNin9+Tdua8FtAgJJd=7wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, ceph-qe-team <ceph-qe-team@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>

Yuri,

On Thu, Feb 15, 2018 at 11:55 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Outstanding issues:
>
> upgrade/kraken-x => http://tracker.ceph.com/issues/22740 assuming
> Jason, Sage approve

Do you have a link to the associated failed test run? I would have
expected this to have been fixed indirectly by
https://github.com/ceph/ceph/pull/20053 as a workaround for the broken
kraken builders.

> knfs => http://tracker.ceph.com/issues/22995 Sage pls approve.
>
> Abhishek, Alfredo - assuming all agreed and Sage approves, we can
> publish 12.2.3 any time.
>
> Thx
> YuriW
>
> On Wed, Feb 14, 2018 at 10:15 AM, Jeff Layton <jlayton@redhat.com> wrote:
>> On Tue, 2018-02-13 at 13:36 -0800, Yuri Weinstein wrote:
>>
>>>
>>> knfs - pending review/approval from Jeff (http://tracker.ceph.com/issues/22995)
>>>
>>
>> Ok, I've flogged it about as far as I can. The problem is that we see
>> OSD_DOWN in the logs after they run. It doesn't seem to have crashed --
>> it just goes unresponsive to pings for a little while.
>>
>> That's about as far as I can carry it -- at this point it'd be nice to
>> have someone with more familiarity with the OSD code take a look and see
>> what they can tell.
>>
>> FWIW, these tests seem to routinely fail on smithi, but we have at least
>> one run on OVH hosts that passed. This leads be to believe that it's
>> something specific to smithi: flaky hw maybe? or possibly load related?
>>
>> --
>> Jeff Layton <jlayton@redhat.com>



-- 
Jason
