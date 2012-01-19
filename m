From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Searching for a Distributed Filesystem
Date: Wed, 18 Jan 2012 17:20:13 -0800
Message-ID: <CAF3hT9Ca9LnuUBkQxCYAx6u18kNeVozkmyMzMxOpCrf8D2pbnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61305 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab2ASBUN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 20:20:13 -0500
Received: by iagf6 with SMTP id f6so6854098iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 17:20:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: blog@roland.entierement.nu
Cc: ceph-devel@vger.kernel.org

[http://roland.entierement.nu/blog/2012/01/15/looking-for-the-ultimate-=
distributed-filesystem.html]
Roland,
I had just a few comments on your characterization of Ceph that I
thought I should share. :)

"Availability/redundancy 1:" Saying Ceph "works" on the net is a bit
of a stretch. It will probably not fail, but Ceph expects LAN-like
latency and bandwidth throughout its design.
"Availability/redundancy 2:" Ceph automatically balances all its data
as new servers are added, old servers are removed, or current servers
fail. If there's documentation somewhere that implies otherwise, it's
in need of a great deal of work!
This note is important in your context =97=A0if you host data on your
personal computer and it gets turned off; Ceph will try and place
other replicas elsewhere, and will go through a potentially-expensive
sync operation every time you turn it on. (In practice it probably
won't be too expensive; and it's very cheap for dedicated storage
servers; but you might not appreciate it scanning directories every
time you log in.)
"Performance:" Ceph does allow configuration of data location, but
it's important to understand that each replica of a file (/file chunk)
is kept updated synchronously. So if you're doing writes then it's
still going to go over your internet connection =97 it'll just go to a
lot of other places too.
Similarly, by default Ceph will only read off one of those servers
(the primary), which is not necessarily the server closest to you.
Some configuration of this is possible; whether it's enough for what
you're seeking will depend on your computing environment.
"Scalability:" The configuration you need is pretty limited, and is
being reduced each time we work on it, so probably at some point all
it will need is to be pointed at the monitor nodes=85but yeah, there is
configuration right now.

In general I think there's a communications gap over what a
"distributed" filesystem is (because the word is used very differently
by different projects). Ceph is distributed in the sense that it
doesn't have a Single Point of Failure, and the system's intelligence
is spread across all the nodes; it is not distributed in the sense of
being intended for use over the internet. (In contrast [to the best of
my understanding], Tahoe-LAFS is distributed in both senses; and
XtreemFS is distributed in the second but only partly in the first.)
Indeed, the features you like in each project are largely correlated
with their target use cases =97=A0Ceph is intended for use across a dat=
a
center, or possibly across a fast WAN; Tahoe-LAFS is intended for
secure long-term storage over the internet; XtreemFS is intended (best
I can tell) for sharing research data over the internet, but not for
frequently-updated personal data in several locations.

=46rom your use case I think that Ceph is not the solution you are
looking for. Tahoe-LAFS is certainly closer (though I'm unfortunately
not familiar enough with the particulars of each of these projects to
say for sure). :) You might also want to check out Andrew FS; which
does not distribute authority but I think is designed for use cases a
little closer to what you're after.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
