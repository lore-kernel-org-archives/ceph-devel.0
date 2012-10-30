From: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?=
	<maciejgalkiewicz@ragnarson.com>
Subject: Re: Ceph performance
Date: Tue, 30 Oct 2012 11:47:02 +0100
Message-ID: <CAGqxmDN10ELB5dh3jyDr7BBZQ=KEsuR3gcg4nvJi3J50Ju56fA@mail.gmail.com>
References: <508E8C1C.4020605@gmail.com>
	<508ED184.50203@inktank.com>
	<508F8F8D.7010107@gmail.com>
	<CAPYLRzhfv08vS0CNEHP2d6+M1FpwNDgtU28DTYn9vjFmLnP9XA@mail.gmail.com>
	<CAGqxmDPfmX1-j5H+sJwAgJD1_1jPVsJfmPW1Bet+UuHAv1BKZg@mail.gmail.com>
	<508FAB9A.20307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:47623 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093Ab2J3KrD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 06:47:03 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so3078109wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 03:47:02 -0700 (PDT)
In-Reply-To: <508FAB9A.20307@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Sam Lang <sam.lang@inktank.com>, ceph-devel@vger.kernel.org

> ServerA(mon+osd):
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/sda1             9.2G  2.4G  6.4G  27% /
> tmpfs                 5.9G     0  5.9G   0% /lib/init/rw
> udev                  5.9G  148K  5.9G   1% /dev
> tmpfs                 5.9G     0  5.9G   0% /dev/shm
> /dev/sda7             674G  483M  629G   1% /var/lib/ceph/mon
> /dev/sda6             917G  2.4G  868G   1% /var/lib/ceph/osd/ceph-4

I see that you have separate partitions for osd and mon. Some of them
are on the same disk as OS. I would strongly recommend having separate
disk (not just partition) for each osd.

There is another problem probably more important. By default journal
is stored in /var/lib/ceph/osd/$cluster-$id/journal which means you
have data and journal on the same disk. It is what slows you down the
most. I was amazed how faster the cluster can be just by putting the
journal somewhere else (tmpfs - only for tests, another disk). From my
experiance, there is no need for separate disk for mon. It can go with
OS.

Run rados bench everytime you make an improvement in your cluster.

-- 
Regards
Maciej Galkiewicz
