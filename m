From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Questions about ceph OSD
Date: Wed, 3 Nov 2010 10:53:17 +0800
Message-ID: <1288752797.2317.26.camel@osd1>
References: <1288750698.2317.18.camel@osd1>
	 <AANLkTin_45jzRLNjDogGpuRaX-u4ELtzomdQUeHkcRoq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:16193 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392Ab0KCCxK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Nov 2010 22:53:10 -0400
In-Reply-To: <AANLkTin_45jzRLNjDogGpuRaX-u4ELtzomdQUeHkcRoq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, "colinm@hq.newdream.net" <colinm@hq.newdream.net>, "henry_c_chang@tcloudcomputing.com" <henry_c_chang@tcloudcomputing.com>, "joshd@hq.newdream.net" <joshd@hq.newdream.net>, "samuelj@hq.newdream.net" <samuelj@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yonggang Liu <myidpt@gmail.com>

Hi Yehuda,

Thank you for your reply so quickly,your idea is very useful for us.
our design is that it only use ceph as our file system,
don't use NFS or CIFS . i will continue to study ceph codes ,thanks.

Jeff.wu




=E5=9C=A8 2010-11-03=E4=B8=89=E7=9A=84 10:39 +0800=EF=BC=8CYehuda Sadeh=
 Weinraub=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
>   there are probably a few directions that you can go, but I'm not
> sure which would be the easiest or whether it'd actually make sense.
> Just to have an idea about what you're really looking for, why
> wouldn't doing nfs mount over secret/ work? Is there a real need for
> that metadata to go through the mds?
>=20
> Yehuda
>=20
> On Tue, Nov 2, 2010 at 7:18 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > hi,
> >
> > Any ideas or suggestions about this? or , To solve this issue,i nee=
d
> > deeply look into what parts ceph codes ,OSD ,CRUSH ,.OSD cluster
> > expansion .. etc ? Thanks.
> >
> >
> > Jeff.Wu
> >
> >
> > ---------- Forwarded message ----------
> > From: Jeff Wu <cpwu@tnsoft.com.cn>
> > To: "sage@newdream.net" <sage@newdream.net>, "ceph-devel@vger.kerne=
l.org" <ceph-devel@vger.kernel.org>
> > Date: Tue, 2 Nov 2010 14:49:58 +0800
> > Subject: Questions about ceph OSD
> > Hi ,
> >
> > I have recently been working the preliminary research whether ceph
> > can use at our cloud computing storage system in the future ,
> > ceph is a very very excellent file system.But ,Now ,i hit a very
> > important problem for us:
> >
> > Normally, as ceph described , all of the data are saved at OSDs wit=
h
> > CRUSHMAP at ceph system.
> >
> > but my goal is to :
> > 1. add a ext3 disk to ceph system ,but doesn't set it as a OSD;
> > 2. save the normal data at the OSDs of a ceph system;
> > 3. save the special data to a local ext3 disk at a ceph system,
> >   the ext3 disk is not set as a ceph OSD,but its infos are added to
> >  MDS and  MON,when Write the special data at a ceph client ,these
> > special data are not saved to ceph server OSDs ,but saved at the lo=
cal
> > ext3 disk.
> >
> > like this:
> > At ceph client:
> > $ mount.ceph 1.2.3.4:6789:/ /ceph
> > $ cd /ceph
> > $ ls
> > cloud user secret
> >
> > when do writing,"cloud and user" folder data are saved to ceph OSDs=
 ,
> > but "secret" folder data are saved to a local ext3 disk .
> >
> > My question is:
> > Q1- If i add a new OSD to the ceph system ,but i do a special CRUSH
> > placement map . Could this ways solved this problem ?,If can ,How ?
> >
> > Q2 - If to implement this function as a patch myself, Could you giv=
e me
> > any ideas ? or what parts of ceph codes(server/client) that i need =
look
> > into ?
> >
> > Thanks for all help and reply .
> >
> >
> > Jeff.Wu
> > Transoft.inc ,Sr.software engineer.
> >
> >
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
