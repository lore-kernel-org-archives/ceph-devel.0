From: huang jun <hjwsm1989@gmail.com>
Subject: pg number question
Date: Fri, 2 Sep 2011 19:35:20 +0800
Message-ID: <CABAwU-bwnScFKRf--bvBTBBZLF45uO4A610Z1imSfcH6Df=o_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50898 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1IBLfV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2011 07:35:21 -0400
Received: by gwaa12 with SMTP id a12so1587779gwa.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Sep 2011 04:35:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
we test osd adding
at first there is only one osd , and we add an osd online, at the step:
$ osdmaptool --createsimple 2 --clobber /tmp/osdmap.junk
--export-crush /tmp/crush.new
we look into the source code, and a few things confused us.
the pg_num is based on osd_num, but now we have 2 osds, i think=A0pg_nu=
m
should be 128.
but the "ceph osd dump -o -" outputs:
pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash
rjenkins=A0pg_num 64=A0pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 ow=
ner
0)
pg_pool 1 'metadata' pg_pool(rep pg_size 2 crush_ruleset 1 object_hash
rjenkins=A0pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 owne=
r
0)
pg_pool 2 'rbd' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash
rjenkins=A0pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 owne=
r
0)

max_osd 2
osd0 up =A0 in =A0weight 1 up_from 2 up_thru 5 down_at 0 last_clean_int=
erval 0-0
osd1 up =A0 in =A0weight 1 up_from 5 up_thru 6 down_at 0 last_clean_int=
erval 0-0
we test many other situations, and a common result we got is:
1) if we add osds on line the total pg don't change, only move some
new pgs to the new osd.
2) if we remove osds, total pg don't change too, just move the pg from
the dead osd to the the exist osds in current osdmap.
so, did the "osd dump -o -" =A0depends on the very first time when we
start the ceph cluster?
then, we are interesting in situation that add 130 osds online one by
one, the pg_num doesn't change too?always stay 64?
and the most confusing question is: when should we split pg??
thank you !
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
