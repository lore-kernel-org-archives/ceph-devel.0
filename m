From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: Space not freed when removing files
Date: Wed, 19 Oct 2011 23:56:21 +0800
Message-ID: <CANExM-PaC3i3Ffrwt=s=HNVTa-O+6xfNvma1OX1o=59N9j9D9w@mail.gmail.com>
References: <1300330817.383946.1319031737311.JavaMail.root@zmbs4.inria.fr>
	<240272892.383967.1319031822299.JavaMail.root@zmbs4.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49901 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab1JSP4W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Oct 2011 11:56:22 -0400
Received: by ggnb1 with SMTP id b1so1800114ggn.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2011 08:56:22 -0700 (PDT)
In-Reply-To: <240272892.383967.1319031822299.JavaMail.root@zmbs4.inria.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cedric Morandin <cedric.morandin@inria.fr>
Cc: ceph-devel@vger.kernel.org

Hi Cedric,

How many clients do you have? Are the files accessed by multiple
clients? If yes, I guess the problem is caused by Bug #630. You can
confirm that by umounting ceph on all clients, and see if the space is
released.

The bug has been there for a long time and has been set to very low pri=
ority. :(

Henry


2011/10/19 Cedric Morandin <cedric.morandin@inria.fr>:
> Hi everybody,
>
> I'm using ceph with ceph-fuse client.
>
> I have the same problem with version 0.36 or the new 0.37.
> I use ext4 as filesystem for OSDs partition.
> I have an application creating around 200 files for a total size arou=
nd 40G :
>
> du -sh /tmp/ceph/cmorandi/
> 37G /tmp/ceph/cmorandi/
>
> When I delete everything in this directory, the size with du is ok :
>
> du -sh /tmp/ceph/cmorandi/
> 512 /tmp/ceph/cmorandi/
>
> But the df -h on the ceph mount show exactly the same amount of used =
space.
> 'ceph pg stat' give exactly the same number for data before and after=
 deletion:
>
> [root@node91 ~]# ceph pg stat
> 2011-10-19 14:59:56.263368 mon <- [pg,stat]
> 2011-10-19 14:59:56.263910 mon.1 -> 'v6382: 792 pgs: 792 active+clean=
; 228 GB data, 229 GB used, 90122 MB / 334 GB avail' (0)
> [root@node91 ~]# ceph pg stat
> 2011-10-19 15:01:56.157879 mon <- [pg,stat]
> 2011-10-19 15:01:56.158889 mon.1 -> 'v6382: 792 pgs: 792 active+clean=
; 228 GB data, 229 GB used, 90122 MB / 334 GB avail' (0)
>
> If I stop, then start everything /etc/init.d/ceph -a [stop,start], th=
e space is freed:
>
> 2011-10-19 15:29:23.189312 pg v6407: 792 pgs: 792 active+clean; 210 G=
B data, 211 GB used, 105 GB / 334 GB avail
>
> Below the OSDs disk usage before and after restart :
>
> root@node0:~ # for i in {92..95};do ssh node$i "df -h /dev/sda5";done
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 57G 23G 72% /data/osd.0
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 47G 33G 59% /data/osd.1
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 56G 24G 71% /data/osd.2
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 71G 8.8G 89% /data/osd.3
>
> root@node0:~ # for i in {92..95};do ssh node$i "df -h /dev/sda5";done
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 52G 28G 66% /data/osd.0
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 43G 37G 55% /data/osd.1
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 52G 28G 65% /data/osd.2
> Filesystem Size Used Avail Use% Mounted on
> /dev/sda5 84G 66G 15G 83% /data/osd.3
>
> I can reproduce it if needed.
> I want to know if the problem might be related to a misconfiguration =
or if it sounds more like a bug ?
>
> Sincerely,
>
> --
>
> C=C3=A9dric Morandin - OASIS Research Team
> INRIA Sophia Antipolis
> 2004 route des lucioles - BP 93
> 06902 Sophia-Antipolis (France)
> Phone: +33 4 97 15 53 89
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
