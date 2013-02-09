From: Sage Weil <sage@inktank.com>
Subject: Re: preferred OSD
Date: Fri, 8 Feb 2013 16:45:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302081642230.13223@cobra.newdream.net>
References: <CALFpzo5YGNi0tNc2HeauCQ_Kh4hgxzEtVLu5TdT1Nb-GZBvKTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45244 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab3BIApG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 19:45:06 -0500
In-Reply-To: <CALFpzo5YGNi0tNc2HeauCQ_Kh4hgxzEtVLu5TdT1Nb-GZBvKTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Marcus-

On Fri, 8 Feb 2013, Marcus Sorensen wrote:
> I know people have been disscussing on and off about providing a
> "preferred OSD" for things like multi-datacenter, or even within a
> datacenter, choosing an OSD that would avoid traversing uplinks.  Has
> there been any discussion on how to do this? I seem to remember people
> saying things like 'the crush map doesn't work that way at the
> moment'. Presumably, when a client needs to access an object, it looks
> up where the object should be stored via the crush map, which returns
> all OSDs that could be read from. I was thinking this morning that you
> could potentially leave the crush map out of it, by setting a location
> for each OSD in the ceph.conf, and an /etc/ceph/location file for the
> client.  Then use the absolute value of the difference to determine
> preferred OSD. So, if OSD0 was location=1, and OSD1 was location=3,
> and client 1 was location=2, then it would do the normal thing, but if
> client 1 was location=1.3, then it would prefer OSD0 for reads.
> Perhaps that's overly simplistic and wouldn't scale to meet everyone's
> requirements, but you could do multiple locations and sprinkle clients
> in between them all in various ways.  Or perhaps the location is a
> matrix, so you could literally map it out on a grid with a set of
> coordinates. What ideas are being discussed around how to implement
> this?

We can do something like this for reads today, where we pick a read 
replica based on the closest IP or some other metric/mask.  We generally 
don't enable this because it leads to non-optimal cache behavior, but it 
could in principle be enabled via a config option for certain clusters 
(and in fact some of that code is already in place).

Writes always have to go through the primary, though, which is the same 
osd regardless of who or where the clients are.

FWIW, CRUSH is not really the issue.  You could modify the OSDMap to 
explicitly enumerate all PGs and their exact mappings to devices, and it 
still wouldn't be that big for most clusters.  But the problem is the 
same.. for any PG there is one single primary who tends the replicas, and 
that is where writes and (normally) reads go.

sage
