From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: low performance of ceph, why ?
Date: Thu, 26 Jul 2012 21:05:51 -0500
Message-ID: <5011F77F.8020507@inktank.com>
References: <loom.20120726T151236-360@post.gmane.org> <501164E9.7050401@inktank.com> <1ffadfdf.26.138c448f479.Coremail.18010151050@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59069 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab2G0CF6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 22:05:58 -0400
Received: by gglu4 with SMTP id u4so2688102ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 19:05:57 -0700 (PDT)
In-Reply-To: <1ffadfdf.26.138c448f479.Coremail.18010151050@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6ams5Zub?= <18010151050@126.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/26/2012 12:15 PM, =E9=A9=AC=E5=9B=9B wrote:
> Hi, Mark
> =E3=80=80=E3=80=80Thanks for your help. May I know some details about=
 your cluster that
> could support 250 000 metadata operations per second as described in =
the
> paper abstract:=E3=80=80
> =EF=BC=82Performance measurements=E3=80=80under a variety of workload=
s show that Ceph
> has excellent
> =E3=80=80I/O performance and calable metadata management,=E3=80=80sup=
portingmore than
> 250,000
> metadata operations=E3=80=80per second=EF=BC=8E=EF=BC=82
> How many mdses and osds are there in the cluster?

It looks like the 250,000 number likely came from the number of=20
openssh+include and openssh+lib opeartions/MDS/second that are shown on=
=20
page 10 when there are 128 MDSes active.  I believe Multi-MDS setups ar=
e=20
considered experimental at this time, so it isn't something you probabl=
y=20
want to do in production.

> Is the OSD supported by btrfs ?

I believe these tests were done with a filesystem that was originally=20
developed for ceph but replaced later with btrfs/others.

> Now, I have known that by separating journal and data of OSD and
> replacing ext3 with btrfs will
> speed up the system, could you prompt me more tips on optimizing the
> perfomance and
> may I have your config file ceph.conf ?

Putting the journal and data disks on seperate drives will certainly=20
help.  You will also want to mount the underlying filesystem with=20
noatime.  Turning off the filestore flusher may help or hurt performanc=
e=20
depending on what is going on.

A simple example conf file can be found here:
http://ceph.com/wiki/Cluster_configuration

> BTW, in P10, ie. Part 6.2, the paper talks about diskless MDS and MDS
> without a local disk, but
> look up through the configuration items of MDS, I just could not find
> the item for configure
> the local disk for MDS, could you tell me how to configure this ? Tha=
nks.

Honestly I'm not sure.  Sage may have more input here.

> Sincerely,
> Hosfore

Thanks,
Mark
--=20
Mark Nelson
Performance Engineer
Inktank
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
