From: Ana Aviles <ana@greenhost.nl>
Subject: Unfound objects and inconsistent reports
Date: Wed, 11 May 2016 15:46:07 +0200
Message-ID: <5733379F.5080800@greenhost.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smarthost1.greenhost.nl ([195.190.28.81]:59984 "EHLO
	smarthost1.greenhost.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcEKNqL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 09:46:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

Hello everyone,

We experienced a strange scenario last week of unfound objects and
inconsistent reports from ceph tools. We solved it with the help from
Sage, and we wanted to share our experience and to see if it can be of
any use for developers too.

After OSDs segfaulting randomly, our cluster ended up with one OSD down
and unfound objects, probably due to a combination of inopportune
crashes. We tried to start that OSD again, but it crashed when reading =
a
specific PG from the log. here: http://pastebin.com/u9WFJnMR

Sage pointed that it looked like some metadata was corrupted. Funny
thing is that, that PG didn't belong to that OSD anymore. Once we made
sure it didn't belong to that OSD, we removed the PG from that OSD.

ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-51/ --pgid
2.1fd --op remove --journal-path /var/lib/ceph/osd/ceph-51/journal

We had to repeat this procedure for other PGs on that same OSD, as it
kept on crashing on startup. Finally the OSD was up and in, but the
recovery process was stuck with 10 unfound objects. We deleted marking
them as lost in their PGs doing:

ceph pg 2.481 mark_unfound_lost delete

Right after that, recovery was successfully completed but ceph reports
were a bit inconsistent. ceph -s was reporting 7 unfound objects, while
ceph health detail didn't report which PGs those unfound objects
belonged to. Sage pointed us to ceph pg dump, that indeed showed which
PGs owned those objects (in all PGs, the crashed OSD was a member).
However, when we listed missing objects on those PGs, they reported non=
e:

{
    "offset": {
        "oid": "",
        "key": "",
        "snapid": 0,
        "hash": 0,
        "max": 0,
        "pool": -9223372036854775808,
        "namespace": ""
    },
    "num_missing": 0,
    "num_unfound": 0,
    "objects": [],
    "more": 0
}

Then we decided to restart the OSDs on those PGs, and the unfound
objects disappear from ceph -s report.

It may be important to mention that we had four nodes running the OSDs.
Two nodes with v9.2.0 and another with v9.2.1. Our OSDs were crashing
apparently because of an issue on v9.2.1. We shared this on the
ceph-devel list, that were very helpful solving this
(http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/31123).

Greetings,

--=20
Ana Avil=C3=A9s
Greenhost - sustainable hosting & digital security
E: ana@greenhost.nl
T: +31 20 4890444
W: https://greenhost.nl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
