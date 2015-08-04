From: GuangYang <yguang11@outlook.com>
Subject: radosgw - stuck ops
Date: Mon, 3 Aug 2015 18:53:20 -0700
Message-ID: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc3s9.hotmail.com ([65.55.116.84]:64210 "EHLO
	BLU004-OMC3S9.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbbHDBxW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 21:53:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda,
Recently with our pre-production clusters (with radosgw), we had an out=
age that all radosgw worker threads got stuck and all clients request r=
esulted in 500 because that there is no worker thread taking care of th=
em.

What we observed from the cluster, is that there was a PG stuck at *pee=
ring* state, as a result, all requests hitting that PG would occupy a w=
orker thread infinitely and that gradually stuck all workers.

The reason why the PG stuck at peering is still under investigation, bu=
t radosgw side, I am wondering if we can pursue anything to improve suc=
h use case (to be more specific, 1 out of 8192 PGs' issue cascading to =
a service unavailable across the entire cluster):

1. The first approach I can think of is to add timeout at objecter laye=
r for each OP to OSD, I think the complexity comes with WRITE, that is,=
 how do we make sure the integrity if we abort at objecter layer. But f=
or immutable op, I think we certainly can do this, since at an upper la=
yer, we already reply back to client with an error.
2. Do thread pool/working queue sharding =A0at radosgw, in which case, =
partial failure would (hopefully) only impact partial of worker threads=
 and only cause a partial outage.

How do you think?

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
