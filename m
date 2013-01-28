From: Gregory Farnum <greg@inktank.com>
Subject: Re: Geo-replication with RADOS GW
Date: Mon, 28 Jan 2013 10:32:27 -0800
Message-ID: <4A295B7B36B341578D4F02AC963BB353@inktank.com>
References: <CAEU8emnv5z9JmkqTG4+ddNV6wRLQfeSQyPShznyg=xFzqTYwpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:41178 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab3A1Sce convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 13:32:34 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so1379771dal.1
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 10:32:33 -0800 (PST)
In-Reply-To: <CAEU8emnv5z9JmkqTG4+ddNV6wRLQfeSQyPShznyg=xFzqTYwpg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben Rowland <ben.rowland@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Monday, January 28, 2013 at 9:54 AM, Ben Rowland wrote:
> Hi,
> =20
> I'm considering using Ceph to create a cluster across several data
> centres, with the strict requirement that writes should go to both
> DCs. This seems possible by specifying rules in the CRUSH map, with
> an understood latency hit resulting from purely synchronous writes.
> =20
> The part I'm unsure about is how the RADOS GW fits into this picture.
> For high availability (and to improve best-case latency on reads),
> we'd want to run a gateway in each data centre. However, the first
> paragraph of the following post suggests this is not possible:
> =20
> http://article.gmane.org/gmane.comp.file-systems.ceph.devel/12238
> =20
> Is there a hard restriction on how many radosgw instances can run
> across the cluster, or is the point of the above post more about a
> performance hit?

It's talking about the performance hit. Most people can't afford data-c=
enter level connectivity between two different buildings. ;) If you did=
 have a Ceph cluster split across two DC (with the bandwidth to support=
 them) this will work fine. There aren't any strict limits on the numbe=
r of gateways you stick on a cluster, just the scaling costs associated=
 with cache invalidation notifications.

 =20
> It seems to me it should be possible to run more
> than one radosgw, particularly if each instance communicates with a
> local OSD which can proxy reads/writes to the primary (which may or
> may not be DC-local).

They aren't going to do this, though =E2=80=94 each gateway will commun=
icate with the primaries directly.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
