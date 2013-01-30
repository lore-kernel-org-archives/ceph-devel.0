From: John Nielsen <lists@jnielsen.net>
Subject: Re: Geo-replication with RADOS GW
Date: Wed, 30 Jan 2013 09:30:11 -0700
Message-ID: <2FECDD68-4116-47BC-A709-8C0BB2585049@jnielsen.net>
References: <CAEU8emnv5z9JmkqTG4+ddNV6wRLQfeSQyPShznyg=xFzqTYwpg@mail.gmail.com> <4A295B7B36B341578D4F02AC963BB353@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from secure.freebsdsolutions.net ([69.55.234.48]:34377 "EHLO
	ns1.jnielsen.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751042Ab3A3QaO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 11:30:14 -0500
In-Reply-To: <4A295B7B36B341578D4F02AC963BB353@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben Rowland <ben.rowland@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Jan 28, 2013, at 11:32 AM, Gregory Farnum <greg@inktank.com> wrote:

> On Monday, January 28, 2013 at 9:54 AM, Ben Rowland wrote:
>> Hi,
>>=20
>> I'm considering using Ceph to create a cluster across several data
>> centres, with the strict requirement that writes should go to both
>> DCs. This seems possible by specifying rules in the CRUSH map, with
>> an understood latency hit resulting from purely synchronous writes.
>>=20
>> The part I'm unsure about is how the RADOS GW fits into this picture=
=2E
>> For high availability (and to improve best-case latency on reads),
>> we'd want to run a gateway in each data centre. However, the first
>> paragraph of the following post suggests this is not possible:
>>=20
>> http://article.gmane.org/gmane.comp.file-systems.ceph.devel/12238
>>=20
>> Is there a hard restriction on how many radosgw instances can run
>> across the cluster, or is the point of the above post more about a
>> performance hit?
>=20
> It's talking about the performance hit. Most people can't afford data=
-center level connectivity between two different buildings. ;) If you d=
id have a Ceph cluster split across two DC (with the bandwidth to suppo=
rt them) this will work fine. There aren't any strict limits on the num=
ber of gateways you stick on a cluster, just the scaling costs associat=
ed with cache invalidation notifications.
>=20
>=20
>> It seems to me it should be possible to run more
>> than one radosgw, particularly if each instance communicates with a
>> local OSD which can proxy reads/writes to the primary (which may or
>> may not be DC-local).
>=20
> They aren't going to do this, though =97 each gateway will communicat=
e with the primaries directly.

I don't know what the timeline is, but Yehuda proposed recently the ide=
a of master and slave "zones" (subsets of a cluster) and other changes =
to facilitate "rgw geo-replication and disaster recovery". See this mes=
sage:
	http://article.gmane.org/gmane.comp.file-systems.ceph.devel/12238

If/when that comes to fruition it would open a lot of possibilities for=
 the kind of scenario you're talking about. (Yes, I'm looking forward t=
o it. :) )

JN

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
