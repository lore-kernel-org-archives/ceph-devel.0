From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: full cluster/pool handling
Date: Thu, 24 Sep 2015 13:45:34 -0700
Message-ID: <CAJ4mKGZM-p6DeHDu=md7WVJ68JLeoHxyo46uwmik94sCShL4MA@mail.gmail.com>
References: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net>
	<CAANLjFo7J44QbGRRY0oKTWRy3HPUKvvxPpKz8rYcr4a24riUtA@mail.gmail.com>
	<alpine.DEB.2.00.1509240803460.13265@cobra.newdream.net>
	<CAJ4mKGb-V8L6P_StKRO2EL99AJ7R5UrUA=zsQZ8r0qzUP8j-2g@mail.gmail.com>
	<CALe9h7eSjOrHG0jcx7v9j9BQLg6AmoVgVndt7cv3oZBppP64RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38384 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbIXUpf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 16:45:35 -0400
Received: by wiclk2 with SMTP id lk2so317479wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 13:45:34 -0700 (PDT)
In-Reply-To: <CALe9h7eSjOrHG0jcx7v9j9BQLg6AmoVgVndt7cv3oZBppP64RQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 24, 2015 at 1:36 PM, John Spray <jspray@redhat.com> wrote:
> On Thu, Sep 24, 2015 at 7:26 PM, Gregory Farnum <gfarnum@redhat.com> =
wrote:

>> That latter switch already exists, by the way, although I don't thin=
k
>> it's actually enforced via cephx caps (it should be) =E2=80=94 the O=
bjecter
>> has an honor_full_flag setting which the MDS sets to false. I don't
>> think the library interfaces are there to specify it per-op but IIRC
>> it is part of the data sent to OSDs so it wouldn't require a wire
>> protocol change.
>
> I don't think it's sent with the ops, the OSDs simply check if the
> requester's entity type is MDS.

Oh drat, you're right.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
