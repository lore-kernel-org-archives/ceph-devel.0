From: Cedric Morandin <cedric.morandin@inria.fr>
Subject: Fwd: Space not freed when removing files
Date: Wed, 19 Oct 2011 15:43:42 +0200 (CEST)
Message-ID: <240272892.383967.1319031822299.JavaMail.root@zmbs4.inria.fr>
References: <1300330817.383946.1319031737311.JavaMail.root@zmbs4.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:43556 "EHLO
	mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751890Ab1JSNno convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Oct 2011 09:43:44 -0400
In-Reply-To: <1300330817.383946.1319031737311.JavaMail.root@zmbs4.inria.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everybody,=20

I'm using ceph with ceph-fuse client.=20

I have the same problem with version 0.36 or the new 0.37.=20
I use ext4 as filesystem for OSDs partition.=20
I have an application creating around 200 files for a total size around=
 40G :=20

du -sh /tmp/ceph/cmorandi/=20
37G /tmp/ceph/cmorandi/=20

When I delete everything in this directory, the size with du is ok :=20

du -sh /tmp/ceph/cmorandi/=20
512 /tmp/ceph/cmorandi/=20

But the df -h on the ceph mount show exactly the same amount of used sp=
ace.=20
'ceph pg stat' give exactly the same number for data before and after d=
eletion:=20

[root@node91 ~]# ceph pg stat=20
2011-10-19 14:59:56.263368 mon <- [pg,stat]=20
2011-10-19 14:59:56.263910 mon.1 -> 'v6382: 792 pgs: 792 active+clean; =
228 GB data, 229 GB used, 90122 MB / 334 GB avail' (0)=20
[root@node91 ~]# ceph pg stat=20
2011-10-19 15:01:56.157879 mon <- [pg,stat]=20
2011-10-19 15:01:56.158889 mon.1 -> 'v6382: 792 pgs: 792 active+clean; =
228 GB data, 229 GB used, 90122 MB / 334 GB avail' (0)=20

If I stop, then start everything /etc/init.d/ceph -a [stop,start], the =
space is freed:=20

2011-10-19 15:29:23.189312 pg v6407: 792 pgs: 792 active+clean; 210 GB =
data, 211 GB used, 105 GB / 334 GB avail=20

Below the OSDs disk usage before and after restart :=20

root@node0:~ # for i in {92..95};do ssh node$i "df -h /dev/sda5";done=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 57G 23G 72% /data/osd.0=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 47G 33G 59% /data/osd.1=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 56G 24G 71% /data/osd.2=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 71G 8.8G 89% /data/osd.3=20

root@node0:~ # for i in {92..95};do ssh node$i "df -h /dev/sda5";done=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 52G 28G 66% /data/osd.0=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 43G 37G 55% /data/osd.1=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 52G 28G 65% /data/osd.2=20
=46ilesystem Size Used Avail Use% Mounted on=20
/dev/sda5 84G 66G 15G 83% /data/osd.3=20

I can reproduce it if needed.=20
I want to know if the problem might be related to a misconfiguration or=
 if it sounds more like a bug ?=20

Sincerely,=20

--=20

C=E9dric Morandin - OASIS Research Team=20
INRIA Sophia Antipolis=20
2004 route des lucioles - BP 93=20
06902 Sophia-Antipolis (France)=20
Phone: +33 4 97 15 53 89=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
