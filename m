From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: RBD performance - tuning hints
Date: Fri, 31 Aug 2012 20:48:34 +1200
Message-ID: <50407A62.1020208@catalyst.net.nz>
References: <503F91EF.7020807@inktank.com> <1ab6cbb8-de0c-4d24-953b-98eced2f4ae2@mailpro> <24E144B8C0207547AD09C467A8259F755760304F@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:53324 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab2HaIsg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 04:48:36 -0400
In-Reply-To: <24E144B8C0207547AD09C467A8259F755760304F@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Josh Durgin <josh.durgin@inktank.com>, Dieter Kasper <d.kasper@kabelmail.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>

On 31/08/12 20:11, Dietmar Maurer wrote:
>>> RBD waits for the data to be on disk on all replicas. It's pretty e=
asy
>>> to relax this to in memory on all replicas, but there's no option f=
or
>>> that right now.
> I thought that is dangerous, because you can loose data?
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=
=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!tml=3D

And it is not immediately obvious that this is the bottleneck - from=20
what I can see the 'sync' call being used (sync_file_range) is extremel=
y=20
fast and is *not* the major slowdown effect...

Regards

Mark

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
