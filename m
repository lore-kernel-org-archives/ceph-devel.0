From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: 12.2.3 QE Luminous validation status
Date: Thu, 15 Feb 2018 08:55:17 -0800
Message-ID: <CAMMFjmFrssPwEx_9YGkeJsW941YHsNin9+Tdua8FtAgJJd=7wg@mail.gmail.com>
References: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
 <1518632155.13566.22.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pl0-f49.google.com ([209.85.160.49]:34153 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426701AbeBOQzS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Feb 2018 11:55:18 -0500
Received: by mail-pl0-f49.google.com with SMTP id bd10so155687plb.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Feb 2018 08:55:18 -0800 (PST)
In-Reply-To: <1518632155.13566.22.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, ceph-qe-team <ceph-qe-team@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>

Outstanding issues:

upgrade/kraken-x => http://tracker.ceph.com/issues/22740 assuming
Jason, Sage approve
knfs => http://tracker.ceph.com/issues/22995 Sage pls approve.

Abhishek, Alfredo - assuming all agreed and Sage approves, we can
publish 12.2.3 any time.

Thx
YuriW

On Wed, Feb 14, 2018 at 10:15 AM, Jeff Layton <jlayton@redhat.com> wrote:
> On Tue, 2018-02-13 at 13:36 -0800, Yuri Weinstein wrote:
>
>>
>> knfs - pending review/approval from Jeff (http://tracker.ceph.com/issues/22995)
>>
>
> Ok, I've flogged it about as far as I can. The problem is that we see
> OSD_DOWN in the logs after they run. It doesn't seem to have crashed --
> it just goes unresponsive to pings for a little while.
>
> That's about as far as I can carry it -- at this point it'd be nice to
> have someone with more familiarity with the OSD code take a look and see
> what they can tell.
>
> FWIW, these tests seem to routinely fail on smithi, but we have at least
> one run on OVH hosts that passed. This leads be to believe that it's
> something specific to smithi: flaky hw maybe? or possibly load related?
>
> --
> Jeff Layton <jlayton@redhat.com>
