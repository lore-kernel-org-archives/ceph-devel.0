From: Gregory Farnum <greg@inktank.com>
Subject: Re: bad performance fio random write - rados bench random write to compare?
Date: Mon, 2 Jul 2012 12:52:00 -0700
Message-ID: <CAPYLRzhUsvweP-J7Be+XvLy7deJJUsFpzMHA8RvygA542uLuBA@mail.gmail.com>
References: <4FE07B2A.7080209@profihost.ag>
	<5b71e1e3-b1be-4c12-897d-0bffbbcf8d33@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62461 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab2GBTwB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 15:52:01 -0400
Received: by lbbgm6 with SMTP id gm6so8099148lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 12:52:00 -0700 (PDT)
In-Reply-To: <5b71e1e3-b1be-4c12-897d-0bffbbcf8d33@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 19, 2012 at 7:05 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
> Hi,
> Is it possible to do random write bench with rados bench command ?
>
> I have very base random write performance with 4K block size inside q=
emu-kvm,
> 1000 iops/s max with 3 nodes with 3x 5 disk 15k
> (Maybe it's related to my constant disk writes, like datas are not fl=
ushed sequentially to disk)
>
> seekwatcher movie of 1 osd here :
> http://odisoweb1.odiso.net/random-write-4k.mpg
>
> I would like to do tests on kvm host with rados command to compare.
> (I don't have rbd module in my kvm host kernel,so I can't use fio on =
the host)

Unfortunately, nobody's implemented a random write test in rados bench
yet (this might be a good bug for somebody who's interested in getting
in to the project =97 rados bench is pretty simple). I'd offer more
suggestions but I think we've already discussed this elsewhere. :)
-Greg
PS: Sorry this message got lost.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
