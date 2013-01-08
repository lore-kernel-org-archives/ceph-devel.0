From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Tue, 08 Jan 2013 15:53:14 +0100
Message-ID: <50EC32DA.40307@ledeuns.net>
References: <50E81A3D.5070100@ledeuns.net> <50EB0518.9050304@ledeuns.net> <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com> <50EBDC5E.3090207@ledeuns.net> <50EC17A6.1080707@ledeuns.net> <AEBA0243790A484AA72D5CDF477159BC1CEB016A@SN2PRD0106MB178.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:30017 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455Ab3AHOxL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 09:53:11 -0500
Received: from [IPv6:2a01:728:103:1::21] (unknown [IPv6:2a01:728:103:1::21])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 86BCE93271
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 15:53:09 +0100 (CET)
In-Reply-To: <AEBA0243790A484AA72D5CDF477159BC1CEB016A@SN2PRD0106MB178.prod.exchangelabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Le 08/01/2013 14:51, Moore, Shawn M a =C3=A9crit :
> If you know the prefix (which is seems you do) and the original size =
of the rbd you should be able to use my utility.
>
> https://github.com/smmoore/ceph/blob/master/rbd_restore.sh
>
> You will need all the rados files in the current working directory yo=
u execute the script from.  We have used it many times so far and works=
 for us.  I have not had any outside feedback on it's usage.  But if yo=
u are truly missing any files, it will seek over them and your rbd migh=
t be corrupt.  Likewise if a file itself is damaged, it will write what=
 is in that file to the rebuild.
>

Thank you very much Shawn, that's your script that gave me the idea of=20
rebuiding the RBD from files ;-)

I coded my own script which find the RBD files itself.

Denis

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
