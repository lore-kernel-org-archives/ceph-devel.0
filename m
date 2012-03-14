From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: TOO SLOW data write speed and delete.. NEED HELP
Date: Wed, 14 Mar 2012 04:28:24 +0000 (UTC)
Message-ID: <loom.20120314T052312-964@post.gmane.org>
References: <loom.20120313T113524-750@post.gmane.org> <4F5FA114.7070806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40496 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab2CNEaH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Mar 2012 00:30:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7fqd-00040A-Pm
	for ceph-devel@vger.kernel.org; Wed, 14 Mar 2012 05:30:03 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 05:30:03 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 05:30:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Jo=C3=A3o Eduardo Lu=C3=ADs <jecluis <at> gmail.com> writes:

>=20
> On 03/13/2012 10:39 AM, madhusudhana wrote:
> > Hi all,
> > Can someone PLEASE help me to understand why data copying (simple c=
p
> > or rsync) is SO slow in CEPH ? And delete command (\rm -rf) for rem=
oving
> > a small (175M) directory is taking so much of time. Because of this=
,
> > i am not able to complete evaluation of ceph using my actual worklo=
ad.=20
> >=20
> > I am hereby requesting all to help me in finding out the reason for=
=20
> > slow write/delete in my ceph cluster. I am really trying hard to=20
> > complete the evaluation with actual workload but not able to copy t=
he
> > data whats required for evaluation to ceph cluster bcz of slow copy=
=2E
> >=20
> > I really appreciate any help on this.
> >=20
> > Thanks in advance
> > Madhusudhan
> >=20
>=20
> Hi Madhusudhan,
>=20
> Are you using Btrfs? And are you taking snapshots while you're
> performing those operations?
>=20
Joao,
Yes. all my OSD's are running on btrfs. I am not doing anything special
except running 'cp' or 'rsync' command. can you please let me know how
i can find if am taking snapshots while I do 'cp' or 'rsync' commands ?

One more concern is 'rm' command is also TOO slow. I am a newbie here a=
nd=20
i don't know to much about ceph working. I configured it in a simple wa=
y.
Install ceph and run mkcephfs and start ceph in all the servers in the=20
cluster.

I want to understand why basic operations like 'cp' and 'rm' are slow b=
cz=20
my actual workload does a lot of copy and delete operation. If I find t=
he
reason for the slowness and get a fix, then I think i can better compar=
e and=20
complete my ceph evaluation.=20

Thanks



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
