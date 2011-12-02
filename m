From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Bug #1047 reproduced
Date: Fri, 2 Dec 2011 12:17:09 +0100
Message-ID: <201112021217.10054.a.ott@m-privacy.de>
References: <201112010937.37642.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:36482 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab1LBLRT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2011 06:17:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 1D79685F13
	for <ceph-devel@vger.kernel.org>; Fri,  2 Dec 2011 12:17:18 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 20940-02 for <ceph-devel@vger.kernel.org>;
 Fri,  2 Dec 2011 12:17:11 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id CF3DC85F11
	for <ceph-devel@vger.kernel.org>; Fri,  2 Dec 2011 12:17:11 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 38CD026D7C
	for <ceph-devel@vger.kernel.org>; Fri,  2 Dec 2011 12:17:11 +0100 (CET)
In-Reply-To: <201112010937.37642.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thursday 01 December 2011 you wrote:
> On all four nodes of my test cluster, MDS crashes with a trace like t=
hat in
> bug #1047. Example and ceph.conf attached. Ceph server side is from g=
it
> master, last commit ce6572273943ffdca4b7dc5344152d6c35106a2d.
>
> MDS does not start on any node here, it reliably crashes with that as=
sert.

Does it makes sense for you to keep the cluster in that broken state, s=
o that=20
we can reproduce that bug or test a potential fix? Otherwise, I would=20
recreate the Ceph filesystem to make more tests. I also have a full log=
 of=20
one mds from start to crash here.

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
