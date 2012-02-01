From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: wip-osd-op-tracking
Date: Wed, 1 Feb 2012 13:59:12 -0800
Message-ID: <CAF3hT9A5TZRzc1Bxor+Td8_JCJDNB-1d3ebro4yDZAsUPF+1RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48815 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab2BAV7N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 16:59:13 -0500
Received: by iacb35 with SMTP id b35so2079964iac.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2012 13:59:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

[ This branch follows from the "osd op tracking" thread:
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/4940]

I pushed this branch yesterday and just updated it with some
suggestions from Sage. It implements basic op tracking for the OSD,
essentially as described in the previous thread. Converting everything
to pass the new OpRequest instead of Message pointers was tedious but
actually worked out nicely in terms of existing queues and stuff, so
I'm feeling pretty comfortable with it. It is not yet a complete
solution (for instance, there's no automatic logging of all operations
and how long they spent in each step), but it will catch "stuck"
operations and provides a sane infrastructure for every logging desire
that I could come up with.

Still to do before merging:
1) clean up "mark" calls. I initially tried to step each request
through as many "states" as possible, but I think we don't want to
mark stuff that doesn't go into the PG as having reached it (eg, the
PG create/delete ops).
2) admin socket interface=A0=97=A0we want to be able to dump operations
currently in flight (optionally, those older than x time)
3) merge master =97 it probably isn't an automatic merge anymore.
4) More testing. I've run this through thrashing a number of times and
it's working out, but I'm nervous about the number of lines changed
even if they were mostly mechanical.

If you have other comments, let me know!

-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
