From: Amon Ott <a.ott@m-privacy.de>
Subject: MDS spinning wild after restart on all nodes
Date: Fri, 15 Jun 2012 11:43:25 +0200
Message-ID: <201206151143.25706.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:33416 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab2FOJnh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 05:43:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id EC0BA63BE7
	for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 11:43:31 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 06666-01 for <ceph-devel@vger.kernel.org>;
 Fri, 15 Jun 2012 11:43:24 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 6AE3363BE6
	for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 11:43:24 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 377F5222F5
	for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 11:43:27 +0200 (CEST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

I have seen this for a long time, but never investigated further. After=
 stable=20
test runs for several days, this is our last known show stopper before =
using=20
Ceph in production. We are running 0.47.2 on 32 Bit.

If we restart MDS (or all ceph daemons) on all nodes, one after another=
 or all=20
together, they first recover and then the active one starts to spin wit=
h full=20
cpu and does not answer any more. After a while, the next takes over, s=
tarts=20
to spin, etc., until the whole cluster is unusable. This is completely=20
reproducable and happens even without any active client.

As ecpected, ceph -w shows lots of
"2012-06-15 11:35:28.588775   mds e959: 1/1/1 up {0=3D3=3Dup:active(lag=
gy or=20
crashed)}"

It does not help to stop all services on all nodes for minutes or longe=
r and=20
to restart them - MDS will restart spinning. But: If we reboot the whol=
e=20
cluster, everything goes back to work.

Today's MDS log is available at=20
https://download.m-privacy.de/homeuser-mds.0.log.gz

Is this a known problem? It has been with us for a looong time now, but=
 since=20
rebooting used to help, we never tracked it down.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
