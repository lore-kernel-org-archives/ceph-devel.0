From: John Spray <jspray@redhat.com>
Subject: Re: disk enclosure LEDs
Date: Mon, 5 Dec 2016 15:28:24 +0000
Message-ID: <CALe9h7esr-SwWis58JLKnjCF0y2Rcj3116nNVKNdrrqBPRW-0A@mail.gmail.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de> <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de> <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com>
 <BLUPR0201MB1524F8910A0625ECACC4B29AE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CALe9h7fJOM2vrxAoi+=xdc01z0kkjpH8048bFe1wF1pBw1yVsQ@mail.gmail.com> <20161205125836.lxcbv5ai5qdavitr@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35306 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbcLEP2p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2016 10:28:45 -0500
Received: by mail-qk0-f173.google.com with SMTP id n204so349303092qke.2
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2016 07:28:45 -0800 (PST)
In-Reply-To: <20161205125836.lxcbv5ai5qdavitr@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 5, 2016 at 12:58 PM, Lars Marowsky-Bree <lmb@suse.com> wrote:
> On 2016-12-05T12:44:51, John Spray <jspray@redhat.com> wrote:
>
>> Question to the OpenAttic folks, who afaik are the only ones on the
>> thread actively building tools like this: if ceph-mgr modules could do
>> arbitrary command remote execution on OSD nodes, is that what you
>> would use for blinking LEDs?  How would you wire that up to the rest
>> of your stack?
>
> So, in "our" world, we have Salt minions for remote execution
> everywhere.
>
> If Ceph requires an additional remote execution channel, aren't we
> rebuilding work that's part of both Salt, Ansible, Puppet, ...?

Yes, although only a tiny part of what tools like ansible do -- and in
the process, we save the effort of integrating with all of the above.
IMHO it would actually be better value for money to write our own
agent than to maintain and test a pluggable infrastructure that could
use any of them (especially as some have different semantics), and
handle newer/older versions of them, etc.

John

>
> The advantage of having a ceph remote agent is most prominent if you
> view ceph as an isolated distributed system.
>
>
> Regards,
>     Lars
>
> --
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar Wilde
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
