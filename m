From: Joseph Glanville <joseph.glanville@orionvm.com.au>
Subject: Re: flashcache
Date: Sun, 20 Jan 2013 13:56:34 +1100
Message-ID: <CAOzFzEiC7ZUQ5wgF9pTOFm7XN__fjweGOaNg89mLnY0-JFDFzQ@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
	<CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
	<50F7FE9B.6050908@inktank.com>
	<44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
	<CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com>
	<F926561F-9D73-4B74-AFC7-F5B962810733@ornl.gov>
	<CABYiri8DDSdGj90geThMRygO7jNhuDS5nK5TRxwLsv0FgKV2gw@mail.gmail.com>
	<74BABD37-71E8-4D69-871E-93F40EBD15BC@ornl.gov>
	<CABYiri9jwpdw6d39NiSg30PYUs2mK6Gkhety4pQohwjJGMnPxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34641 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3ATC4h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 21:56:37 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so8008523ieb.20
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jan 2013 18:56:35 -0800 (PST)
In-Reply-To: <CABYiri9jwpdw6d39NiSg30PYUs2mK6Gkhety4pQohwjJGMnPxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: "Atchley, Scott" <atchleyes@ornl.gov>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> I assume it is now an EoIB driver. Does it replace the IPoIB driver?
>>
> Nope, it is upper-layer thing: https://lwn.net/Articles/509448/

Aye, its effectively a NAT translation layer that strips Ethernet
headers and grafts on IPoIB headers, thus using the same wire protocol
and allowing communication from EoIB to IPoIB.

However this approach is a little dirty and has been nacked by the
netdev community so we aren't likely to see it in the mainline
kernel.. basically ever.

Joseph.


-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
