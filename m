From: Loic Dachary <loic.dachary@cloudwatt.com>
Subject: Erasure code properties in OSDMap
Date: Sun, 09 Mar 2014 13:13:09 +0100
Message-ID: <531C5AD5.9060109@cloudwatt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.corp.cloudwatt.com ([46.231.129.137]:47686 "HELO
	mail.corp.cloudwatt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752015AbaCIMVw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Mar 2014 08:21:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage & Sam,

I quickly sketched the replacement of the pg_pool_t::properties map wit=
h a OSDMap::properties list of maps at https://github.com/dachary/ceph/=
commit/fe3819a62eb139fc3f0fa4282b4d22aecd8cd398 and explained how I see=
 it at http://tracker.ceph.com/issues/7662#note-2

It indeed makes things simpler, more consistent and easier to explain. =
I can provide an implementation this week if this seems reasonable to y=
ou.

Cheers

--=20
Lo=EFc Dachary, Senior Developer

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
