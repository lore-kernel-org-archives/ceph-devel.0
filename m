From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 14:54:04 -0700
Message-ID: <i2t1471eea71005061454l7eb0cdf7zbd3bcfe5bad360a9@mail.gmail.com>
References: <Pine.LNX.4.64.1005061430230.18563@cobra.newdream.net>
	 <784866.39317.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55010 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab0EFVyH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 17:54:07 -0400
Received: by pxi5 with SMTP id 5so203949pxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 May 2010 14:54:05 -0700 (PDT)
In-Reply-To: <784866.39317.qm@web36101.mail.mud.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Fick <mogulguy@yahoo.com>
Cc: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

2010/5/6 Martin Fick <mogulguy@yahoo.com>:
>> Yeah, you've got it right.=A0 The rbd image is striped
>> over small objects, which are independently assigned
>> to OSDs.=A0 The load should be very well distributed.
>
> How can that be on a 2 OSD setup with double redundancy?
> In this case, if all of a replicas smaller objects are
> not on a single node, how will it recover from an OSD
> failure?
>
> The only way I see this possible is if file foo is
> split into small objects A1 A2 A3 A4 and replicas B1
> B2 B3 B4 and you spread those across 2 OSDs like this:
>
> replica 1 (A1 B2 A3 B4)
> replica 2 (B1 A2 B3 A4)
>
> but then A1 has to know that it is the same as B1. =A0Is
> that the case?
The hashing probably isn't quite even enough to alternate the objects,
but yes -- different objects (even those forming a single "file") will
have different primary replicas even in a small system.
Since the default RBD unit is 4MB in size, and the disk is presumably
several to hundreds of gigabytes, you've got a reasonably well-striped
system.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
