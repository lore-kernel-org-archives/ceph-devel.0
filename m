From: Dave Spano <dspano@optogenics.com>
Subject: Re: OSD memory leaks?
Date: Wed, 9 Jan 2013 18:03:00 -0500 (EST)
Message-ID: <18367055.168.1357772580252.JavaMail.dspano@it1>
References: <CAOLwVUmrCXk2qRkBd3G3rB85+=K_y0rc9y6QWEGqKjdwJyUTww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rrcs-24-103-221-203.nys.biz.rr.com ([24.103.221.203]:52645 "EHLO
	mail.optogenics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3AIXDI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 18:03:08 -0500
In-Reply-To: <CAOLwVUmrCXk2qRkBd3G3rB85+=K_y0rc9y6QWEGqKjdwJyUTww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Thank you. I appreciate it!=20

Dave Spano=20
Optogenics=20
Systems Administrator=20



----- Original Message -----=20

=46rom: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
To: "Dave Spano" <dspano@optogenics.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel Just" <sam.just@=
inktank.com>=20
Sent: Wednesday, January 9, 2013 5:12:12 PM=20
Subject: Re: OSD memory leaks?=20

Dave, I share you my little script for now if you want it:=20

#!/bin/bash=20

for i in $(ps aux | grep [c]eph-osd | awk '{print $4}')=20
do=20
MEM_INTEGER=3D$(echo $i | cut -d '.' -f1)=20
OSD=3D$(ps aux | grep [c]eph-osd | grep "$i " | awk '{print $13}')=20
if [[ $MEM_INTEGER -ge 25 ]];then=20
service ceph restart osd.$OSD >> /dev/null=20
if [ $? -eq 0 ]; then=20
logger -t ceph-memory-usage "The OSD number $OSD has been restarted=20
since it was using $i % of the memory"=20
else=20
logger -t ceph-memory-usage "ERROR while=20
restarting the OSD daemon"=20
fi=20
else=20
logger -t ceph-memory-usage "The OSD number $OSD is=20
only using $i % of the memory, doing nothing"=20
fi=20
logger -t ceph-memory-usage "Waiting 60 seconds before testing the next=
 OSD..."=20
sleep 60=20
done=20

logger -t ceph-memory-usage "Ceph state after memory check operation=20
is: $(ceph health)"=20

Crons run with 10 min interval everyday for each storage node ;-).=20

Waiting for some Inktank guys now :-).=20
--=20
Regards,=20
S=C3=A9bastien Han.=20


On Wed, Jan 9, 2013 at 10:42 PM, Dave Spano <dspano@optogenics.com> wro=
te:=20
> That's very good to know. I'll be restarting ceph-osd right now! Than=
ks for the heads up!=20
>=20
> Dave Spano=20
> Optogenics=20
> Systems Administrator=20
>=20
>=20
>=20
> ----- Original Message -----=20
>=20
> From: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
> To: "Dave Spano" <dspano@optogenics.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel Just" <sam.jus=
t@inktank.com>=20
> Sent: Wednesday, January 9, 2013 11:35:13 AM=20
> Subject: Re: OSD memory leaks?=20
>=20
> If you wait too long, the system will trigger OOM killer :D, I alread=
y=20
> experienced that unfortunately...=20
>=20
> Sam?=20
>=20
> On Wed, Jan 9, 2013 at 5:10 PM, Dave Spano <dspano@optogenics.com> wr=
ote:=20
>> OOM killer=20
>=20
>=20
>=20
> --=20
> Regards,=20
> S=C3=A9bastien Han.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
