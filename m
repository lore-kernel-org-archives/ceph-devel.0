From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Mon, 9 Nov 2015 16:50:57 -0700
Message-ID: <CAANLjFrNhZra5WHCeynrabyQoM=r0dU6L3tf7TL580AqrXip5Q@mail.gmail.com>
References: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
	<CAN=+7FWJ2aH1mRg7Z4P2o9f7hB7q2MHE6rBzyeR9Yrnf8qh3jA@mail.gmail.com>
	<CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
	<CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
	<CAANLjFo8RiTqmQJEbr5O082613pNGsu3-YM0VX-tToY-YPBfuQ@mail.gmail.com>
	<alpine.DEB.2.00.1511060202130.5830@cobra.newdream.net>
	<CAANLjFrka=DHN=1D-=wsY4HgHQ=-tg0+0hfff80kiiaaRK=r0g@mail.gmail.com>
	<CAANLjFqMf9xPMPLx-8BM=P00vJ0OnXNCkC3K3Xe-R27Dt6k4Kw@mail.gmail.com>
	<alpine.DEB.2.00.1511080619140.27153@cobra.newdream.net>
	<CAN=+7FUyzNtzjngg-r=fdRo9uqeZfcMRvqc7eZumn7KaB9KYmg@mail.gmail.com>
	<CAANLjFoFT6ajEBJKfhA9rnjyJ+a8gKpFrQz74uyobKjiyZvxeQ@mail.gmail.com>
	<CAN=+7FWjVG5XuBqzzeZkQiQ=ZVSbScUj2gNms6gy52N738Y5sQ@mail.gmail.com>
	<CAANLjFpveonAff_aQNV-RNKOkhgBHjNAjwLftjWWinz+XNFztw@mail.gmail.com>
	<CAN=+7FWi=wcQsFU7rMLPKdLF+9DZGKUgNmMTM3xDP0+K0bQ56A@mail.gmail.com>
	<CAANLjFrXdK2r25RaC4RB3=irSv_qufvQi__S4QbZBN7VS1WSjw@mail.gmail.com>
	<CAN=+7FW3G1V5DvF=C=TCiBN_L2xLhydhXGbbUc4GYG=-dEqGEg@mail.gmail.com>
	<CAANLjFpVtK7wNFJPQtkewLtjP5d0M6iab42PF09ii6E3ddT3Mg@mail.gmail.com>
	<CAN=+7FU78Pq0nVdTn1uNR6p0b+_HQeMj3UrnvBRqg4OCdQKL3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36521 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbKIXu6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 18:50:58 -0500
Received: by vkas68 with SMTP id s68so3563326vka.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2015 15:50:57 -0800 (PST)
In-Reply-To: <CAN=+7FU78Pq0nVdTn1uNR6p0b+_HQeMj3UrnvBRqg4OCdQKL3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

It sounds like dmclock/mclock will alleviate a lot of the concerns I
have as long as it can be smart like you said. It sounds like the
queue thread was already tried so there is experience behind the
current implementation vs. me thinking it might be better. The basic
idea I had is below:


Client,           Client,
Repop,            Repop,
backfill,   ...   Backfill,
recovery,         Recovery,
etc thread        etc thread
    |                 |
    \                 /
     \               /
lock; push (prio,cost,strict,
front/back,subsystem,&OP); unlock
            |
            |
     (queue thread) pop
        /          \
       /            \
if ops.low        Place op in prio
(fast path)       queue, do any
      |           housekeeping
      |                |
      |           when post-queue.len
      |           < threads
      \                /
       \              /
       post-queue push
              |
       lock, cond, pop
           /    \
          /      \
    Worker   ...  Worker
    thread        thread

What I meant by more scalable is that the rate of boulders would be
constant and evenly dispersed. It also prevents any one worker thread
from being backed up while others are idle. This may not be an issue
if the PG is busy. This design could also suffer if many OPs require
some locking at the PG level instead of the object level. The queue
itself does not do any op work only passing pointers to work to be
done. As I mentioned before it sounds like something like this already
proved to be limiting in performance, although thinking through this
has given me some ideas about implementing a fast path option in the
WRR queue to save some cycles.

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWQS/lCRDmVDuy+mK58QAA69QP/0H1K3cArNaqM+yo4W4D
vpUMGxgTOg/8+69w4U2smHtjy8zRnJyUU1fbYdeTCbwTlZi5XVvtdMstDgPf
OqtF+uJm/akWVblzjreWjcqkBOXmlv89loOKJZGp9oUaHll8vrL117dd7Kwh
WHnGkc+fKCjkA7qo3gBo+Y5N3I1N2BNF0NQVuSTFEP5CfPE4Wy6DwBpYD1KY
zoN021E564V8eK1336je+v5xDg4oZLOxp5HhWmLHXnnisvfrK/VUipVl3aGY
Y5AXpdHGuRlsfvodKo6ZjAr1NEyPqlapJ7o57montY8yTxPR6ubSYAPP04Ky
VxA1FmtjsXKwui23rJMViWmY+lCT/P42fDlXEmVkbrnpkfoyzWn3N6yERatV
UCazWH6eA8w/FMjrkU7FTNjttYeQU74Ph26qywL9oNVWbzKKaiEaWgGzOT1Y
c65babw+qExK1syF8cWlKaf+roWIHeDq2+9iNO5SJ5v2eZ+JZipwW5f0BibM
EQGCx4b+vcjJgN2rYxUYOsm0tyOj+MMi2MrHqLC5Ns4zwqBw29+Gz4x+RfW5
2mw/0zaBe9v5GG7SocCHSuLexYBXjJ5h7zx2lII38Bnz9M6OfaAzuFtSXAqH
VSs4+6BrksnvAdhJNh4eX21mF/zIrnatxIvzvZlkAkSlEzpB72ZU8fC1OH/X
3hWW
=LuyT
-----END PGP SIGNATURE-----
