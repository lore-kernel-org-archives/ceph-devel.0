From: Gregory Farnum <greg@inktank.com>
Subject: Re: tiering of storage pools in ceph in general
Date: Sat, 24 Nov 2012 08:42:21 -0800
Message-ID: <D5EC0B0F4FD94E2BBF64CF5F2B1F2A50@inktank.com>
References: <5DC113BE-8B3F-44C1-8585-612CDE601856@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46200 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab2KXQmZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 11:42:25 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4115332pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 24 Nov 2012 08:42:24 -0800 (PST)
In-Reply-To: <5DC113BE-8B3F-44C1-8585-612CDE601856@tchpc.tcd.ie>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: ceph-devel@vger.kernel.org

On Thursday, November 22, 2012 at 4:33 AM, Jimmy Tang wrote:
> Hi All,
> =20
> Is it possible at this point in time to setup some form of tiering of=
 storage pools in ceph by modifying the crush map? For example I want t=
o have my most recently used data on a small set of nodes that have SSD=
's and over time migrate data from the SSD's to some bulk spinning disk=
 using a LRU policy?
There's no way to have Ceph do this automatically at this time. Tiering=
 in this fashion traditionally requires the sort of centralized metadat=
a that Ceph and RADOS are designed to avoid, and while interest in it i=
s heating up we haven't yet come up with a new solution. ;)

If your system allows you to do this manually, though =E2=80=94 yes. Yo=
u can create multiple (non-overlapping, presumably) trees within your C=
RUSH map, one of which would be an "SSD" storage group and one of which=
 would be a "normal" storage group. Then create a CRUSH rule which draw=
s from the SSD group and a rule which draws from the normal group, crea=
te a pool using each of those, and write to whichever one at the approp=
riate time.
Alternatively, you could also place all the primaries on SSD storage bu=
t the replicas on regular drives =E2=80=94 this won't speed up your wri=
tes much but will mean SSD-speed reads. :)
-Greg
 =20
> =20
> Regards,
> Jimmy Tang
> =20
> --
> Senior Software Engineer, Digital Repository of Ireland (DRI)
> Trinity Centre for High Performance Computing,
> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
> http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie (mailto:jtang@tchpc.tcd=
=2Eie)
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
