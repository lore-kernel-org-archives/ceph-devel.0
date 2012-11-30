From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: What is the new command to add osd to the crushmap to enable
 it to receive data
Date: Fri, 30 Nov 2012 01:54:30 +0000
Message-ID: <50B811D6.5000004@inktank.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com> <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net> <CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com> <50B80600.1000304@inktank.com> <1354237947.86472.YahooMailNeo@web121901.mail.ne1.yahoo.com> <1354238575.90788.YahooMailNeo@web121904.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33615 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab2K3Byh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 20:54:37 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so5172425wer.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 17:54:36 -0800 (PST)
In-Reply-To: <1354238575.90788.YahooMailNeo@web121904.mail.ne1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/30/2012 01:22 AM, Isaac Otsiabah wrote:
> This command below which adds a new to the crushmap to enable it to r=
eceive data has changed and does not work anymore.
>=20
>=20
> ceph osd crush set {id} {name}
>=20
>=20
> Please, what is the new command to add a new osd to the crushmap to e=
nable it to receive data?

You must specify a weight and a location. For instance,

  ceph osd crush set 0 osd.0 1.0 root=3Ddefault

Also, you can check up on the docs for more infos.

=46rom the docs at [1]:

Add the OSD to the CRUSH map so that it can begin receiving data. You
may also decompile the CRUSH map, add the OSD to the device list, add
the host as a bucket (if it=92s not already in the CRUSH map), add the
device as an item in the host, assign it a weight, recompile it and set
it. See Add/Move an OSD for details.

ceph osd crush set {id} {name} {weight} pool=3D{pool-name}
[{bucket-type}=3D{bucket-name} ...]


[1] http://ceph.com/docs/master/rados/operations/add-or-rm-osds/


  -Joao
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
