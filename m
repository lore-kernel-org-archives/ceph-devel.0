From: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Subject: =?koi8-r?Q?=EE=E1:_Official_Ceph_RPM_build_flags_needed?=
Date: Wed, 4 Jun 2014 08:59:55 +0000
Message-ID: <afd0a9cba5484946bb229aec7eb50580@EPBYMINSA0001.epam.com>
References: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com>
 <CAJZMiudJFUfWncXhkVncYOhzOXzkSLCgRYLrU=vTrFwDNSZykw@mail.gmail.com>
 <285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>,<CAPed3OFsc0GCaH22DsMAgJL5+Tnktzc+bOMxUOoxbsgfRpj8MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from evbyminsa0102.epam.com ([217.21.63.37]:60649 "EHLO
	EVBYMINSA0102.epam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbaFDJAQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 05:00:16 -0400
In-Reply-To: <CAPed3OFsc0GCaH22DsMAgJL5+Tnktzc+bOMxUOoxbsgfRpj8MQ@mail.gmail.com>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>, Jeff Darcy <jdarcy@redhat.com>
Cc: Daniel Sterling <sterling.daniel@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Ruben, Jeff, Daniel and others,

thank you very much for excellent assistance! :)

Best Regards,
Ilya Storozhilov
Lead Software Engineer

EPAM Systems
Tver office, Russia
GMT+4

EPAM Internal ext.:  55529
Office phone:        +7 (4822) 630-070 ext. 55529
Office fax:          +7 (4822) 630-073
Mobile phone:        +7 (904) 021-0763
E-mail:              Ilya_Storozhilov@epam.com

http://www.epam.com

CONFIDENTIALITY CAUTION AND DISCLAIMER
This message is intended only for the use of the individual(s) or entit=
y(ies) to which it is addressed and contains information that is legall=
y privileged and confidential. If you are not the intended recipient, o=
r the person responsible for delivering the message to the intended rec=
ipient, you are hereby notified that any dissemination, distribution or=
 copying of this communication is strictly prohibited. All unintended r=
ecipients are obliged to delete this message and destroy any printed co=
pies.


________________________________________
=EF=D4: Ruben Kerkhof <ruben@rubenkerkhof.com>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 4 =C9=C0=CE=D1 2014 =C7. 11:40
=EB=CF=CD=D5: Ilya Storozhilov
=EB=CF=D0=C9=D1: Daniel Sterling; ceph-devel@vger.kernel.org
=F4=C5=CD=C1: Re: Official Ceph RPM build flags needed

On Tue, Jun 3, 2014 at 6:19 PM, Ilya Storozhilov
<Ilya_Storozhilov@epam.com> wrote:
> So it seems, that this is up to packager what to put to RPM_OPT_FLAGS=
 environment variable on packaging. Maybe someone knows what particular=
 value is used?
> Thank you!

You can see what the actual value is by running:
$ rpm --eval '%{optflags}'
-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions
-fstack-protector --param=3Dssp-buffer-size=3D4 -m64 -mtune=3Dgeneric

Hope it helps,

Ruben Kerkhof
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
