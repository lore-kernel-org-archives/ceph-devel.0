From: biyan chen <riby.chen@gmail.com>
Subject: Re: ceph lock
Date: Wed, 6 Jul 2011 03:54:30 +0800
Message-ID: <CACR322iM=V0PWL5Wwx-TNvvnfZrwPTUptKGJ-RHVBfB2ZotO8Q@mail.gmail.com>
References: <CACR322iwXcEs6JwQtYaLb0KS7d-bY=kZo6eLvnToV0RaL4QGHA@mail.gmail.com>
	<Pine.LNX.4.64.1107051254290.5150@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43119 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab1GETyb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2011 15:54:31 -0400
Received: by ywe9 with SMTP id 9so2406736ywe.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jul 2011 12:54:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107051254290.5150@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks!

2011/7/6 Sage Weil <sage@newdream.net>:
> On Wed, 6 Jul 2011, biyan chen wrote:
>> HI everyone, I want to consult everybody ceph file system, whether t=
o
>> support the PHP flock ()?
>>
>> If that is not like NFS flock () support?
>
> flock() and fcntl() locks are support with the kernel client, but not=
 yet
> with the fuse-based client.
>
> sage
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
