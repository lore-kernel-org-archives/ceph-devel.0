From: Ugis <ugis22@gmail.com>
Subject: Re: zombie pgs
Date: Fri, 15 Mar 2013 12:09:04 +0200
Message-ID: <CAE63xUPRtLSFeBiy=dcXmnRvekFgn2eMQOBOCxNff0rogCfXAg@mail.gmail.com>
References: <CAE63xUO5hgFxzY7bStB1M7V7mW6gCO73xpMSdrhkFDFRub-7Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:55777 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3COKJF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Mar 2013 06:09:05 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so4076095ieb.6
        for <ceph-devel@vger.kernel.org>; Fri, 15 Mar 2013 03:09:04 -0700 (PDT)
In-Reply-To: <CAE63xUO5hgFxzY7bStB1M7V7mW6gCO73xpMSdrhkFDFRub-7Dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

update: zombie PGs dissapeared after I deleted pool which previously
was holding these PGs.

Thoughts and suggestion after this:
Docs say:"Stale Placement groups are in an unknown state - the OSDs
that host them have not reported to the monitor cluster in a while
(configured by mon_osd_report_timeout)."
It means mons are passive here, they just wait for OSD to report, right?

It would be desirable that scrubing("active" action) could inspect
these stale PGs and let do something with them afterwards, mark lost
at least.
If mons report, that PGs are stale - and same time after scrubbing
"ceph pg {pg-num} query" reports "i don't have pgid {pg-num}" - this
does not seem right.

Suggestion - scrubing process should take stale PGs into inspection checklist.

Right, the way I got into stuck PGs was most probably wrong order of
commands, but such scrubing improvement would help to resolve
situation in future if someone did the same. When you get used to
reliability of multiple copy pools - it is easy to mess up with single
copy pools :)


Ugis




2013/3/12 Ugis <ugis22@gmail.com>:
> Hi,
>
> Last week I have unintentionally created zombie pgs - they do not
> exist any more, cannot detect/delete them with ceph tools but cluster
> still thinks they exist and reports those as stale.
>
> how-to create zombie pgs on ceph 0.56.3:
> create single copy pool+rbd with some data.
> stop respective osds that hold pieces of this rbd.
> reformat filesystem+ceph filesystem for stopped osds with same
> {osd-nums}, start osds.
>
>
> Now:
> # ceph -s
> health HEALTH_WARN 54 pgs stale; 54 pgs stuck stale
>
> #ceph health detail
> ...
> pg 15.60 is stuck stale for 530406.612888, current state
> stale+active+clean, last acting [7]
> pg 15.61 is stuck stale for 520394.297111, current state
> stale+active+clean, last acting [6]
> pg 15.63 is stuck stale for 519992.929160, current state
> stale+active+clean, last acting [5]
>
> #ceph pg scrub 15.63
> instructing pg 15.63 on osd.5 to scrub
> wait while scrub finish
>
> # ceph osd deep-scrub 5
> osd.5 instructed to deep-scrub
> wait while scrub finish
>
> # ceph pg 15.63 query
> i don't have pgid 15.63
>
> # ceph pg 15.63 mark_unfound_lost revert
> i don't have pgid 15.63
>
> Logs at monitors, osd.5 do not show anything about finding these pgs
> while scrubbing.
>
> Hoped to reveal non existant pgs via scrub and then "ceph pg {pg-id}
> mark_unfound_lost revert" those, but scrubs do not find them,
> shouldn't they?
> I could try to remove respective single copy pool as missing pgs are
> from only rbd that was in this pool, but this is not the best way -
> there could be other rbds other times.
>
> How to remove these zombie pgs?
>
> P.S. While osds were reformatted + recovering in other terminal I run
> "rbd rm -p single-copy-pool single-copy-rbd" from client. This command
> hanged for tens of minutes then I Ctrl+c'd it. Do not remember if I
> run rm before starting to reformat osds(should), but even if not there
> should be no zombie pgs in cluster after deep scrub - they should be
> unfound.
>
>
> Regards,
> Ugis Racko
