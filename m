From: Ugis <ugis22@gmail.com>
Subject: zombie pgs
Date: Tue, 12 Mar 2013 10:24:39 +0200
Message-ID: <CAE63xUO5hgFxzY7bStB1M7V7mW6gCO73xpMSdrhkFDFRub-7Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:56301 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3CLIYk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 04:24:40 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so6024300iec.4
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 01:24:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Last week I have unintentionally created zombie pgs - they do not
exist any more, cannot detect/delete them with ceph tools but cluster
still thinks they exist and reports those as stale.

how-to create zombie pgs on ceph 0.56.3:
create single copy pool+rbd with some data.
stop respective osds that hold pieces of this rbd.
reformat filesystem+ceph filesystem for stopped osds with same
{osd-nums}, start osds.


Now:
# ceph -s
health HEALTH_WARN 54 pgs stale; 54 pgs stuck stale

#ceph health detail
...
pg 15.60 is stuck stale for 530406.612888, current state
stale+active+clean, last acting [7]
pg 15.61 is stuck stale for 520394.297111, current state
stale+active+clean, last acting [6]
pg 15.63 is stuck stale for 519992.929160, current state
stale+active+clean, last acting [5]

#ceph pg scrub 15.63
instructing pg 15.63 on osd.5 to scrub
wait while scrub finish

# ceph osd deep-scrub 5
osd.5 instructed to deep-scrub
wait while scrub finish

# ceph pg 15.63 query
i don't have pgid 15.63

# ceph pg 15.63 mark_unfound_lost revert
i don't have pgid 15.63

Logs at monitors, osd.5 do not show anything about finding these pgs
while scrubbing.

Hoped to reveal non existant pgs via scrub and then "ceph pg {pg-id}
mark_unfound_lost revert" those, but scrubs do not find them,
shouldn't they?
I could try to remove respective single copy pool as missing pgs are
from only rbd that was in this pool, but this is not the best way -
there could be other rbds other times.

How to remove these zombie pgs?

P.S. While osds were reformatted + recovering in other terminal I run
"rbd rm -p single-copy-pool single-copy-rbd" from client. This command
hanged for tens of minutes then I Ctrl+c'd it. Do not remember if I
run rm before starting to reformat osds(should), but even if not there
should be no zombie pgs in cluster after deep scrub - they should be
unfound.


Regards,
Ugis Racko
