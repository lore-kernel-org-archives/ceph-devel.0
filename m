From: Martin Fick <mogulguy@yahoo.com>
Subject: Re: how to install a cloud storage network :which is best smart automatic  file replication solution for cloud storage based systems.
Date: Thu, 27 May 2010 12:31:03 -0700 (PDT)
Message-ID: <13316.5620.qm@web36102.mail.mud.yahoo.com>
References: <AANLkTilC2wJJvaZlJgLvCRm3cOenq4Pt2S0d_y49L-N7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36102.mail.mud.yahoo.com ([66.163.179.216]:32534 "HELO
	web36102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750852Ab0E0TbH convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 May 2010 15:31:07 -0400
In-Reply-To: <AANLkTilC2wJJvaZlJgLvCRm3cOenq4Pt2S0d_y49L-N7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, =?utf-8?B?TWV0aW4gQWt5YWzEsQ==?= <metin.akyali@gmail.com>

--- On Thu, 5/27/10, Metin Akyal=C4=B1 <metin.akyali@gmail.com> wrote:

> I would use 1gbit client servers and 100mbit storage
> servers. All the servers will be in same DC. I will=20
> rent the servers and i dont own my own DC house. Reason=20
> i am choosing 1gbit server as the client is i
> wont have too much 1gbit server, but i will have many
> stogage nodes, and 1gbit server is very expensive but=20
> 100mbit is not so.

It sounds like you may not really need replication=20
if all the files have to pass through the "client". =20
Simply add a caching layer to the client, I suspect=20
that most FSes can do that.  I know that glusterfs
 certainly can, they have a caching translator. =20
But, even plain old NFS should likely cache enough=20
on the client side if it is a read only load.
If not, AFS does provide some read only specific=20
replication, but I think that you have to specify=20
which files to replicate.  From what I understand=20
the ceph clients will also cache data locally with a=20
read only load.

Additionally, both ceph and glusterfs (at least) will=20
stripe files across multiple storage nodes, so even
without replication they should be able to serve up
a single file at a higher bandwidth than the=20
connection to one single node.  I am not sure that
replication really is the solution you seek.

My $.02,

-Martin



     =20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
