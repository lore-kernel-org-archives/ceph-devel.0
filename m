From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Which SSD method is better for performance?
Date: Tue, 14 Feb 2012 09:17:41 -0800
Message-ID: <CAORUGqDbeOsAcfPjGiZ-hcSXjK3BeqN_U=KuNOyQMcKU70uA6A@mail.gmail.com>
References: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43377 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636Ab2BNRSD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 12:18:03 -0500
Received: by werb13 with SMTP id b13so105017wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 09:18:02 -0800 (PST)
In-Reply-To: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 13, 2012 at 16:39, Paul Pettigrew
<Paul.Pettigrew@mach.com.au> wrote:
> #1. place it in the main [osd] stanza and reference the whole drive a=
s a single partition; or

As explained by others, that will not work.

> #2. partition up the disk, so 1x partition per SATA HDD, and place ea=
ch partition in the [osd.N] portion
=2E..
> I am asking therefore, is the added work (and constraints) of specify=
ing down to individual partitions per #2 worth it in performance gains?=
 Does it not also have a constraint, in that if I wanted to add more HD=
D's into the server (we buy 45 bay units, and typically provision HDD's=
 "on demand" i.e. 15x at a time as usage grows), I would have to additi=
onally partition the SSD (taking it offline) - but if it were #1 option=
, I would only have to add more [osd.N] sections (and not have to worry=
 about getting the SSD with 45x partitions)?

If you need to touch the existing partitions on the SSD when you add
new disks, you'll need to take all the OSDs on that machine down. That
does not sound like a good idea. Maybe you should provision the SSD as
1/45th size journals, in the first place. You'll lose some of the
space, but I really don't see a way around that without needing
downtime on all the OSDs when growing, and a good SSD will use that
internally for wear leveling and asynchronous erase, so it should even
be faster.

> One final related question, if I were to use #1 method (which I would=
 prefer if there is no material performance or other reason to use #2),=
 then that specification (i.e. the "osd journal =3D /dev/sdb") SSD disk=
 reference would have to be identical on all other hardware nodes, yes =
(I want to use the same ceph.conf file on all servers per the doco reco=
mmendations)? What would happen if for example, the SSD was on /dev/sde=
 on a new node added into the cluster? References to /dev/disk/by-id et=
c are clearly no help, so should a symlink be used from the get-go? Eg =
something like "ln -s /dev/sdb /srv/ssd" on one box, and =C2=A0"ln -s /=
dev/sde /srv/ssd" on the other box, so that in the [osd] section we cou=
ld use this line which would find the SSD disk on all nodes "osd journa=
l =3D /srv/ssd"?

Use labels. /dev/disk/by-label/* with a modern udev.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
