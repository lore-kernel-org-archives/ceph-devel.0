From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Questions about ceph OSD
Date: Wed, 3 Nov 2010 11:43:32 +0800
Message-ID: <1288755812.9503.0.camel@osd1>
References: <1288750698.2317.18.camel@osd1>
	 <AANLkTin_45jzRLNjDogGpuRaX-u4ELtzomdQUeHkcRoq@mail.gmail.com>
	 <1288752797.2317.26.camel@osd1>
	 <AANLkTi=pOKg1JR51P8H0FmteqbtaR0zUGtW+geH_5_Dp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:40595 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752563Ab0KCDnW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Nov 2010 23:43:22 -0400
In-Reply-To: <AANLkTi=pOKg1JR51P8H0FmteqbtaR0zUGtW+geH_5_Dp@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, "colinm@hq.newdream.net" <colinm@hq.newdream.net>, "henry_c_chang@tcloudcomputing.com" <henry_c_chang@tcloudcomputing.com>, "joshd@hq.newdream.net" <joshd@hq.newdream.net>, "samuelj@hq.newdream.net" <samuelj@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yonggang Liu <myidpt@gmail.com>

hi yehuda,

Thanks again. i will try it .

Jeff.



=E5=9C=A8 2010-11-03=E4=B8=89=E7=9A=84 11:23 +0800=EF=BC=8CYehuda Sadeh=
 Weinraub=E5=86=99=E9=81=93=EF=BC=9A
> Originally, the client <-> mds messages contained the full path of th=
e
> files written, similar to cifs. This was a bit racy and problematic,
> but generally with a little modifications to the client code and to
> the protocol you'd be able to build and send that full path through
> with the osd I/O operations (again, I'm not sure what can of worms
> would be opened with the full-path, or whether it's actually feasible
> nowadays).
> The next thing you'd need is to modify the osd operations handling,
> and mirror each write operation to your ext3 partition. I think that'=
d
> be the easiest path to go, though somewhat hacky.
>=20
> Yehuda
>=20
> On Tue, Nov 2, 2010 at 7:53 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > Hi Yehuda,
> >
> > Thank you for your reply so quickly,your idea is very useful for us=
=2E
> > our design is that it only use ceph as our file system,
> > don't use NFS or CIFS . i will continue to study ceph codes ,thanks=
=2E
> >
> > Jeff.wu
> >
> >
> >
> >
> > =E5=9C=A8 2010-11-03=E4=B8=89=E7=9A=84 10:39 +0800=EF=BC=8CYehuda S=
adeh Weinraub=E5=86=99=E9=81=93=EF=BC=9A
> >> Hi,
> >>
> >>   there are probably a few directions that you can go, but I'm not
> >> sure which would be the easiest or whether it'd actually make sens=
e.
> >> Just to have an idea about what you're really looking for, why
> >> wouldn't doing nfs mount over secret/ work? Is there a real need f=
or
> >> that metadata to go through the mds?
> >>
> >> Yehuda
> >>
> >> On Tue, Nov 2, 2010 at 7:18 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote=
:
> >> > hi,
> >> >
> >> > Any ideas or suggestions about this? or , To solve this issue,i =
need
> >> > deeply look into what parts ceph codes ,OSD ,CRUSH ,.OSD cluster
> >> > expansion .. etc ? Thanks.
> >> >
> >> >
> >> > Jeff.Wu
> >> >
> >> >
> >> > ---------- Forwarded message ----------
> >> > From: Jeff Wu <cpwu@tnsoft.com.cn>
> >> > To: "sage@newdream.net" <sage@newdream.net>, "ceph-devel@vger.ke=
rnel.org" <ceph-devel@vger.kernel.org>
> >> > Date: Tue, 2 Nov 2010 14:49:58 +0800
> >> > Subject: Questions about ceph OSD
> >> > Hi ,
> >> >
> >> > I have recently been working the preliminary research whether ce=
ph
> >> > can use at our cloud computing storage system in the future ,
> >> > ceph is a very very excellent file system.But ,Now ,i hit a very
> >> > important problem for us:
> >> >
> >> > Normally, as ceph described , all of the data are saved at OSDs =
with
> >> > CRUSHMAP at ceph system.
> >> >
> >> > but my goal is to :
> >> > 1. add a ext3 disk to ceph system ,but doesn't set it as a OSD;
> >> > 2. save the normal data at the OSDs of a ceph system;
> >> > 3. save the special data to a local ext3 disk at a ceph system,
> >> >   the ext3 disk is not set as a ceph OSD,but its infos are added=
 to
> >> >  MDS and  MON,when Write the special data at a ceph client ,thes=
e
> >> > special data are not saved to ceph server OSDs ,but saved at the=
 local
> >> > ext3 disk.
> >> >
> >> > like this:
> >> > At ceph client:
> >> > $ mount.ceph 1.2.3.4:6789:/ /ceph
> >> > $ cd /ceph
> >> > $ ls
> >> > cloud user secret
> >> >
> >> > when do writing,"cloud and user" folder data are saved to ceph O=
SDs ,
> >> > but "secret" folder data are saved to a local ext3 disk .
> >> >
> >> > My question is:
> >> > Q1- If i add a new OSD to the ceph system ,but i do a special CR=
USH
> >> > placement map . Could this ways solved this problem ?,If can ,Ho=
w ?
> >> >
> >> > Q2 - If to implement this function as a patch myself, Could you =
give me
> >> > any ideas ? or what parts of ceph codes(server/client) that i ne=
ed look
> >> > into ?
> >> >
> >> > Thanks for all help and reply .
> >> >
> >> >
> >> > Jeff.Wu
> >> > Transoft.inc ,Sr.software engineer.
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
> >> >
> >> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
