From: Alfredo Deza <adeza@redhat.com>
Subject: Re: open the floodgates...
Date: Mon, 25 Apr 2016 07:29:35 -0400
Message-ID: <CAC-Np1xJYePN8gwZS=0saekSg2=d2s0KzTVfLXevK0+U8Kqt+w@mail.gmail.com>
References: <alpine.DEB.2.11.1604211432300.16393@cpach.fuggernut.com>
	<571B3083.5070606@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37836 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbcDYL3g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Apr 2016 07:29:36 -0400
Received: by mail-wm0-f51.google.com with SMTP id n3so122370581wmn.0
        for <ceph-devel@vger.kernel.org>; Mon, 25 Apr 2016 04:29:36 -0700 (PDT)
In-Reply-To: <571B3083.5070606@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Apr 23, 2016 at 4:21 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 04/21/2016 09:03 PM, Sage Weil wrote:
>>
>> and release the (pull requests with code destined for) kraken!
>>
>> One question: we moved from a 'next' branch to 'jewel' branch for the
>> development period to represent the 'frozen' bugfix branch before each
>> development checkpoint release.  Should we
>>
>> 1) Use a 'kraken' branch, just like we did with jewel.  After each dev
>> release, merge in the next lump of new stuff from master.\
>
>
> I've become accustomed to this, so it seems natural to me. Subjectively, +1
>
>> 2) Go back to a 'next' branch, like we did pre-jewel.
>
>
> No, thanks.
>
>> 3) Give up on the delayed dev checkpoint release thing we've been doing
>> (where we send bug fixes to next or kraken for 2 weeks before release) and
>> just release regular checkpoints of master (as 11.0.z).
>
>
> Though this delay introduces some complexity, we have it documented and it
> serves a good purpose: i.e. making the dev checkpoint releases more stable.
>
>> 4) Stop doing development checkpoint releases entirely and let testers
>> pull automated builds from gitbuilder or jenkins.
>
>
> Psychologically, the "imprimatur" of a checkpoint release is reassuring.
> Perhaps more importantly, the granularity of point releases has information
> value. You ask someone what version they are running - with dev checkpoint
> releases they say "10.1.2". Without them, they would say
> "4a2a6f72640d6b74a3bbd92798bb913ed380dcd4".

What about a middle ground: keep the checkpoint releases but automated
like the gitbuilders: the releases would be incremental and
have a release cadence that could be nightly/weekly/every-other-day.

This would also play nicely with #3 were we could already be cutting
dev releases for 11.0.z

Keeping releases coming from the actual release-named branch (e.g.
'jewel') would help the current release process that bases the model
around that
idea (we have never cut a release from a 'next' or 'master' branch).

>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
