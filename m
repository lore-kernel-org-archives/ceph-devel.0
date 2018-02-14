From: Jeff Layton <jlayton@redhat.com>
Subject: Re: 12.2.3 QE Luminous validation status
Date: Wed, 14 Feb 2018 13:15:55 -0500
Message-ID: <1518632155.13566.22.camel@redhat.com>
References: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:39105 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161696AbeBNSP6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Feb 2018 13:15:58 -0500
Received: by mail-qt0-f181.google.com with SMTP id f4so8810669qtj.6
        for <ceph-devel@vger.kernel.org>; Wed, 14 Feb 2018 10:15:58 -0800 (PST)
In-Reply-To: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, ceph-qe-team <ceph-qe-team@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>

On Tue, 2018-02-13 at 13:36 -0800, Yuri Weinstein wrote:

> 
> knfs - pending review/approval from Jeff (http://tracker.ceph.com/issues/22995)
> 

Ok, I've flogged it about as far as I can. The problem is that we see
OSD_DOWN in the logs after they run. It doesn't seem to have crashed --
it just goes unresponsive to pings for a little while.

That's about as far as I can carry it -- at this point it'd be nice to
have someone with more familiarity with the OSD code take a look and see
what they can tell.

FWIW, these tests seem to routinely fail on smithi, but we have at least
one run on OVH hosts that passed. This leads be to believe that it's
something specific to smithi: flaky hw maybe? or possibly load related?

-- 
Jeff Layton <jlayton@redhat.com>
