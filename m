From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: pg number question
Date: Fri, 2 Sep 2011 10:08:48 -0700
Message-ID: <CA+qbEUOhcoPLSqYDVWZEckyGmVJ870Z2yF99s2j5_hE=-XN=ww@mail.gmail.com>
References: <CABAwU-bwnScFKRf--bvBTBBZLF45uO4A610Z1imSfcH6Df=o_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47405 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab1IBRIw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2011 13:08:52 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 38645C066
	for <ceph-devel@vger.kernel.org>; Fri,  2 Sep 2011 10:12:14 -0700 (PDT)
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id DEB49C068
	for <ceph-devel@vger.kernel.org>; Fri,  2 Sep 2011 10:12:13 -0700 (PDT)
Received: by fxh19 with SMTP id 19so1815311fxh.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Sep 2011 10:08:50 -0700 (PDT)
In-Reply-To: <CABAwU-bwnScFKRf--bvBTBBZLF45uO4A610Z1imSfcH6Df=o_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 2, 2011 at 4:35 AM, huang jun <hjwsm1989@gmail.com> wrote:
> hi,all
> we test osd adding
> at first there is only one osd , and we add an osd online, at the ste=
p:
> $ osdmaptool --createsimple 2 --clobber /tmp/osdmap.junk
> --export-crush /tmp/crush.new
> we look into the source code, and a few things confused us.
> the pg_num is based on osd_num, but now we have 2 osds, i think=A0pg_=
num
> should be 128.
> but the "ceph osd dump -o -" outputs:
> pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash
> rjenkins=A0pg_num 64=A0pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 =
owner
> 0)
> pg_pool 1 'metadata' pg_pool(rep pg_size 2 crush_ruleset 1 object_has=
h
> rjenkins=A0pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 ow=
ner
> 0)
> pg_pool 2 'rbd' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash
> rjenkins=A0pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 ow=
ner
> 0)
>
> max_osd 2
> osd0 up =A0 in =A0weight 1 up_from 2 up_thru 5 down_at 0 last_clean_i=
nterval 0-0
> osd1 up =A0 in =A0weight 1 up_from 5 up_thru 6 down_at 0 last_clean_i=
nterval 0-0
> we test many other situations, and a common result we got is:
> 1) if we add osds on line the total pg don't change, only move some
> new pgs to the new osd.
> 2) if we remove osds, total pg don't change too, just move the pg fro=
m
> the dead osd to the the exist osds in current osdmap.
> so, did the "osd dump -o -" =A0depends on the very first time when we
> start the ceph cluster?
> then, we are interesting in situation that add 130 osds online one by
> one, the pg_num doesn't change too?always stay 64?
> and the most confusing question is: when should we split pg??
> thank you !
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi Huang,

The number of PGs is set when you run mkcephfs.

The number of PGs can be changed later by the administrator. The code
for changing the number of PGs is under development, and it's unstable
at the moment.

sincerely,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
