From: Loic Dachary <loic@dachary.org>
Subject: infernalis-backports suites analysis
Date: Fri, 5 Feb 2016 15:35:21 +0700
Message-ID: <56B45EC9.8050607@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58339 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbcBEIfd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 03:35:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Abhishek,

Analyzing the rbd,fs,rados,upgrade,rgw suites for the infernalis-backpo=
rts branch (http://tracker.ceph.com/issues/13750#note-14), a few proble=
ms are blocking progress but nothing too concerning I think.

* a number valgrind runs in all suites fail with http://tracker.ceph.co=
m/issues/14664 : I suspect other people also saw the same problem but I=
 could not find an issue with the relevant keywords in the tracker and =
made a new one.=20
* the subuser pull request seems to be causing problems (https://github=
=2Ecom/ceph/ceph/pull/7422) and I marked it DNM until this is resolved

Last but not least, there is the mystery of the number of jobs in the s=
uite (I get 10, yuri gets 26, that's not fair ;-).

I'll ask around about the valgrind problem later today, hopefully there=
 is a simple solution.=20

I re-ran the failed test when there were environmental failures to get =
maximum coverage and I'll analyze the results tomorrow.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
