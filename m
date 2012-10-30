From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Re: Ceph performance
Date: Tue, 30 Oct 2012 14:53:47 +0400
Message-ID: <508FB1BB.405@gmail.com>
References: <508E8C1C.4020605@gmail.com> <508ED184.50203@inktank.com> <508F8F8D.7010107@gmail.com> <CAPYLRzhfv08vS0CNEHP2d6+M1FpwNDgtU28DTYn9vjFmLnP9XA@mail.gmail.com> <CAGqxmDPfmX1-j5H+sJwAgJD1_1jPVsJfmPW1Bet+UuHAv1BKZg@mail.gmail.com> <508FAB9A.20307@gmail.com> <CAGqxmDN10ELB5dh3jyDr7BBZQ=KEsuR3gcg4nvJi3J50Ju56fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32966 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072Ab2J3Kxv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 06:53:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so101602lbo.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 03:53:49 -0700 (PDT)
In-Reply-To: <CAGqxmDN10ELB5dh3jyDr7BBZQ=KEsuR3gcg4nvJi3J50Ju56fA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?TWFjaWVqIEdhxYJraWV3aWN6?= <maciejgalkiewicz@ragnarson.com>
Cc: Gregory Farnum <greg@inktank.com>, Sam Lang <sam.lang@inktank.com>, ceph-devel@vger.kernel.org

On 30.10.2012 14:47, Maciej Ga=C5=82kiewicz wrote:
>> ServerA(mon+osd):
>> Filesystem            Size  Used Avail Use% Mounted on
>> /dev/sda1             9.2G  2.4G  6.4G  27% /
>> tmpfs                 5.9G     0  5.9G   0% /lib/init/rw
>> udev                  5.9G  148K  5.9G   1% /dev
>> tmpfs                 5.9G     0  5.9G   0% /dev/shm
>> /dev/sda7             674G  483M  629G   1% /var/lib/ceph/mon
>> /dev/sda6             917G  2.4G  868G   1% /var/lib/ceph/osd/ceph-4
> I see that you have separate partitions for osd and mon. Some of them
> are on the same disk as OS. I would strongly recommend having separat=
e
> disk (not just partition) for each osd.
>
> There is another problem probably more important. By default journal
> is stored in /var/lib/ceph/osd/$cluster-$id/journal which means you
> have data and journal on the same disk. It is what slows you down the
> most. I was amazed how faster the cluster can be just by putting the
> journal somewhere else (tmpfs - only for tests, another disk). From m=
y
> experiance, there is no need for separate disk for mon. It can go wit=
h
> OS.
>
> Run rados bench everytime you make an improvement in your cluster.
>
Oops, it's actually true!!!

Give me a moment to check this out and thank you for opening my eyes.
Let me to notify you about the results of implementing your recommendat=
ions.

I'm going to completely rebuild my cluster. Thank so much.

--=20
Kind regards,

R. Alekseev

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
