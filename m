From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: When ceph synchronizes journal to disk?
Date: Mon, 04 Mar 2013 21:47:05 -0700
Message-ID: <513578C9.4040602@cs.utah.edu>
References: <513343D8.8050402@cs.utah.edu> <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:58732 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506Ab3CEErI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 23:47:08 -0500
In-Reply-To: <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Maybe it is easier to tell in this way.

What we want to see is that the newly written data to stay in the=20
journal disk for as long as possible such that write workloads do not=20
compete for disk headers for read workloads. Any way to achieve that in=
=20
Ceph? Thanks,

Xing

On 03/04/2013 09:55 AM, Gregory Farnum wrote:
> The "journal [min|max] sync interval" values specify how frequently
> the OSD's "FileStore" sends a sync to the disk. However, data is stil=
l
> written into the normal filesystem as it comes in, and the normal
> filesystem continues to schedule normal dirty data writeouts. This is
> good =97 it means that when we do send a sync down you don't need to
> wait for all (30 seconds * 100MB/s) 3GB or whatever of data to go to
> disk before it's completed.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
