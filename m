From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: questions on networks and hardware
Date: Mon, 21 Jan 2013 09:19:47 +0100
Message-ID: <CAJH6TXhxCBeB7-0vw3mbVO05zckH=F5JiVBJG7woW2SfwrBFBQ@mail.gmail.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
	<CAJH6TXi40uB5Xup3xob+zVJaf6q=4dKjdgs4+NkD-fa5Bh2z0Q@mail.gmail.com>
	<6C6B937F81BD480D8B439B27D504FE9C@inktank.com>
	<CAJH6TXiutMfJ51G3itP83=-eSX+W9xtdPftNj0j0xcg+rHANmw@mail.gmail.com>
	<BA913A5056344C77AE4476417C3197A3@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44328 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab3AUITu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 03:19:50 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so874320wgb.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 00:19:48 -0800 (PST)
In-Reply-To: <BA913A5056344C77AE4476417C3197A3@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

2013/1/21 Gregory Farnum <greg@inktank.com>:
> I'm not quite sure what you mean=85the use of the "cluster network" a=
nd "public network" are really just intended as conveniences for people=
 with multiple NICs on their box. There's nothing preventing you from r=
unning everything on the same network=85(and more specifically, from di=
fferent speed grades to different boxes, but keeping them all on the sa=
me network).

I mean using two cluster network and two pubic networks. 4 NICs in tota=
l.
Our cluster network will be 10GBe or Infiniband DDR/QDR, making a
fully redundany cluster network (two nics on each server, two
switches) will double our costs.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
