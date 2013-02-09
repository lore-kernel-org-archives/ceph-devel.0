From: Marcus Sorensen <shadowsor@gmail.com>
Subject: preferred OSD
Date: Fri, 8 Feb 2013 17:12:45 -0700
Message-ID: <CALFpzo5YGNi0tNc2HeauCQ_Kh4hgxzEtVLu5TdT1Nb-GZBvKTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:43326 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947339Ab3BIAMq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 19:12:46 -0500
Received: by mail-ve0-f171.google.com with SMTP id b10so3823858vea.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 16:12:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I know people have been disscussing on and off about providing a
"preferred OSD" for things like multi-datacenter, or even within a
datacenter, choosing an OSD that would avoid traversing uplinks.  Has
there been any discussion on how to do this? I seem to remember people
saying things like 'the crush map doesn't work that way at the
moment'. Presumably, when a client needs to access an object, it looks
up where the object should be stored via the crush map, which returns
all OSDs that could be read from. I was thinking this morning that you
could potentially leave the crush map out of it, by setting a location
for each OSD in the ceph.conf, and an /etc/ceph/location file for the
client.  Then use the absolute value of the difference to determine
preferred OSD. So, if OSD0 was location=1, and OSD1 was location=3,
and client 1 was location=2, then it would do the normal thing, but if
client 1 was location=1.3, then it would prefer OSD0 for reads.
Perhaps that's overly simplistic and wouldn't scale to meet everyone's
requirements, but you could do multiple locations and sprinkle clients
in between them all in various ways.  Or perhaps the location is a
matrix, so you could literally map it out on a grid with a set of
coordinates. What ideas are being discussed around how to implement
this?
