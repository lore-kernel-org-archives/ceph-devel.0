From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Mon, 12 Sep 2016 11:48:19 +0200
Message-ID: <CA+H5UW32fPXFer3v_2XcHA=cAVy9b8F4u+GcHeRStaWC-SyGCg@mail.gmail.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
 <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com> <CA+H5UW2nL1nWa6YFW7yoiuu0WE-rYxYjMpm1X+Tw6_LbvSrwwQ@mail.gmail.com>
 <1a932fce-a05d-d690-953d-6f5b74467182@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33688 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757645AbcILJsV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2016 05:48:21 -0400
Received: by mail-qk0-f172.google.com with SMTP id w204so136373935qka.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2016 02:48:21 -0700 (PDT)
In-Reply-To: <1a932fce-a05d-d690-953d-6f5b74467182@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Thu, Sep 8, 2016 at 8:23 PM, Casey Bodley <cbodley@redhat.com> wrote:
> Right, this was the requirement that motivated the work on preselection, =
so we would only try to authenticate against engines that are properly conf=
igured and relevant to the given handler.

Which component should be responsible for verifying correctness
of configuration? I would say the best candidate is an AuthEngine
itself. Some time ago the static can_be_enabled() was proposed.
If we need that feature, maybe similar (but better named) method
is a way to go?

> With respect to changing the auth strategy (i.e. the list of engines conf=
igured for a given handler) at runtime, I'm not sure it's worth the complex=
ity at this point, and we certainly don't want to add locking to do this sa=
fely. [note that we do have 'dynamic reconfiguration' which pauses the fron=
tend while it reloads RGWRados, so we could use that mechanism to change au=
th strategy without needing new locks]

Great. It looks that at this phase we don't need to have the feature onboar=
d.
It's enough to just don't prohibit implementing it in the future.

P.S.
Sorry for resending this letter, Casey. I had accidentally sent HTML
on my mobile client. The message was refused by vger.kernel.org.

Regards,
Radek
