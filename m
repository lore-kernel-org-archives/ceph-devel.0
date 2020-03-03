From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: question for ceph study
Date: Tue, 3 Mar 2020 08:23:50 -0800
Message-ID: <CAJ4mKGZR2Vrbc=OhR-i3bo7US544fRQ+2=W92JdqCsYED_oAWg@mail.gmail.com>
References: <56829C2A36C2E542B0CCB9854828E4D8562BAEEB@CDSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49075 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729508AbgCCQYE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2020 11:24:04 -0500
Received: by mail-qk1-f198.google.com with SMTP id z124so2475871qkd.20
        for <ceph-devel@vger.kernel.org>; Tue, 03 Mar 2020 08:24:02 -0800 (PST)
In-Reply-To: <56829C2A36C2E542B0CCB9854828E4D8562BAEEB@CDSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Haochuan Z" <haochuan.z.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "dev@ceph.io" <dev@ceph.io>

It's just an arbitrary value to try and identify the store is really
there. I *think* it's mostly about guaranteeing that the monitor store
has been completely set up (ie, the store is fully created and you can
use it), but I may be forgetting something.

But it's of very little importance in the ordinary course of events.
-Greg

On Tue, Mar 3, 2020 at 8:20 AM Chen, Haochuan Z
<haochuan.z.chen@intel.com> wrote:
>
> Hi
>
>
>
> I am a rookie, one question. what's magic in monitor data? What=E2=80=99s=
 the usage of magic?
>
>
>
> Thanks
>
>
>
> Martin, Chen
>
> IOTG, Software Engineer
>
> 021-61164330
>
>
>
> _______________________________________________
> Dev mailing list -- dev@ceph.io
> To unsubscribe send an email to dev-leave@ceph.io
