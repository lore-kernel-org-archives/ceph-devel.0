From: Brian Edmonds <mornir@gmail.com>
Subject: Re: ceph performance under xen?
Date: Fri, 29 Jun 2012 14:14:32 -0700
Message-ID: <CAMsVa3s8hEMcwPQdkWw=DhBwUU=as6CoKcFeOexPaNDoQ95OAA@mail.gmail.com>
References: <CAMsVa3t8foWYguozDeFCiHf0jrK6b2+L4pKtU__-G1mTVVHzWg@mail.gmail.com>
 <CAPYLRzgMAPuTKOeZC78J48V1wCuL_7v-5Aj6YQX2Q=0BgQ5Cuw@mail.gmail.com>
 <CAMsVa3tJOf0JcY6Maq2SJaor_=e-iMyxsOihuLJNSzTZ23ydtg@mail.gmail.com> <CAPYLRzjoNKEiG3UWxxyRGzpAmCFyGt5RvM9kkGpx8a+hu103EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57143 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab2F2VOy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 17:14:54 -0400
Received: by qcro28 with SMTP id o28so1986890qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 14:14:53 -0700 (PDT)
In-Reply-To: <CAPYLRzjoNKEiG3UWxxyRGzpAmCFyGt5RvM9kkGpx8a+hu103EQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 2:06 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> Okay, there's two things I'd do here. First, create a cluster that
> only has one MDS =97=A0the multi-MDS system is significantly less sta=
ble.

Ok, will do.

> Second, you've got 3 monitors doing frequent fsyncs, and 4 OSDs doing
> frequent syncs, which are all funneling into a single disk. That's
> going to go poorly no matter what you're doing. ;) Try doing a smalle=
r
> cluster with just one monitor, one or two OSDs, and one MDS.

Oh, I missed that part.  The disks on the dom0 are actually logical
volumes on top of a (software) RAID5 with four physical disks.  That
may, of course, not be a better situation. =3D)

In any case, I'll rebuild the current four machines into one MON, one
MDS and two OSDs and see how that goes.  Thanks for the advice.

Brian.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
