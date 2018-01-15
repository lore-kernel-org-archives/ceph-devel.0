From: Sage Weil <sage@newdream.net>
Subject: Re: Porting snap trim queue check to Luminous
Date: Mon, 15 Jan 2018 19:02:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801151901450.24931@piezo.novalocal>
References: <6258c4a1-3fa1-3627-1e47-cde2bcb4742e@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-792898878-1516042937=:24931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:33308 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeAOTCS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 14:02:18 -0500
In-Reply-To: <6258c4a1-3fa1-3627-1e47-cde2bcb4742e@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-792898878-1516042937=:24931
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 15 Jan 2018, Piotr Dałek wrote:
> With Mimic, there are a new fields added to pg_stat_t: "state" and
> "purged_snaps". My snap trim queue check
> (https://github.com/ceph/ceph/pull/19520) adds one more field
> ("snaptrimq_len") and it is positioned quite unfortunately - AFTER those two,
> meaning that I can't add it without adding the other two. Knowing that Mimic
> is not out, there are three options:
> 
> 1 - Backport just
> https://github.com/ceph/ceph/pull/19520/commits/dc7781cf17d11cb09067656cb25c0d710ab60d71
> that adds snap_trimq_len field to "pg query" command and leave out the rest.
> That's not entirely satisfying from my perspective, but it's still a little
> step forward.
> 2 - Fill "state" and "purged snaps" with dummy data in Luminous, but that can
> screw up upgrades from Luminous to Mimic.
> 3 - Reorder fields in master/Mimic and add snaptrimq_len before state and
> purged snaps. Probably no impact as Mimic is not out yet.

I think #3 is fine!

sage
--8323329-792898878-1516042937=:24931--
