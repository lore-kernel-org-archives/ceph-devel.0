From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: core dumps
Date: Tue, 10 Jul 2012 15:39:42 +0200
Message-ID: <1358508.lp2FM92poT@mranderson>
References: <1417057.BKrM6AzGtZ@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from imap.ki.iif.hu ([193.6.222.244]:49454 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab2GJNjt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 09:39:49 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by strudel.ki.iif.hu (Postfix) with ESMTP id D75893C5
	for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 15:39:46 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id mF+5glW48W2j for <ceph-devel@vger.kernel.org>;
	Tue, 10 Jul 2012 15:39:44 +0200 (CEST)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 77F73386
	for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 15:39:43 +0200 (CEST)
In-Reply-To: <1417057.BKrM6AzGtZ@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It just turned out that this problem was likely caused by a network out=
age,=20
that made the iSCSI-backed filesystem that holds Ceph's data directorie=
s go=20
away.

The third mon seems to have crashed, too, but that machine didn't have =
enough=20
free space in the root filesystem for the core file.

On 2012. July 10. 12:28:24 Sz=E9kelyi Szabolcs wrote:
> I usually find core dumps in my root folders belonging to Ceph daemon=
s.
> Yesterday night two of my three monitors dumped core at the exact sam=
e
> moment. Are you interested in them?
>=20
> And in general, if I find such core files, should I send them to you?

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
