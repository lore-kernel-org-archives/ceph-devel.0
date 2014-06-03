From: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Subject: =?koi8-r?Q?=EE=E1:_Official_Ceph_RPM_build_flags_needed?=
Date: Tue, 3 Jun 2014 16:19:56 +0000
Message-ID: <285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>
References: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com>,<CAJZMiudJFUfWncXhkVncYOhzOXzkSLCgRYLrU=vTrFwDNSZykw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from evbyminsa0102.epam.com ([217.21.63.37]:35873 "EHLO
	EVBYMINSA0102.epam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbaFCQUd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 12:20:33 -0400
In-Reply-To: <CAJZMiudJFUfWncXhkVncYOhzOXzkSLCgRYLrU=vTrFwDNSZykw@mail.gmail.com>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Sterling <sterling.daniel@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Daniel,

thank you for rapid response. "ceph.spec" file from the SRPM contains f=
ollowing lines:

-----------------------------------------------------------------------=
-----------------------------
=2E..
export RPM_OPT_FLAGS=3D`echo $RPM_OPT_FLAGS | sed -e 's/i386/i486/'`

%{configure}	CPPFLAGS=3D"$java_inc" \
		--prefix=3D/usr \
		--localstatedir=3D/var \
		--sysconfdir=3D/etc \
		--docdir=3D%{_docdir}/ceph \
		--with-nss \
		--without-cryptopp \
		--with-rest-bench \
		--with-debug \
		--enable-cephfs-java \
		$MY_CONF_OPT \
		%{?_with_ocf} \
		CFLAGS=3D"$RPM_OPT_FLAGS" CXXFLAGS=3D"$RPM_OPT_FLAGS"
=2E..
-----------------------------------------------------------------------=
-----------------------------

So it seems, that this is up to packager what to put to RPM_OPT_FLAGS e=
nvironment variable on packaging. Maybe someone knows what particular v=
alue is used?
Thank you!

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
=EF=D4: ceph-devel-owner@vger.kernel.org <ceph-devel-owner@vger.kernel.=
org> =CF=D4 =C9=CD=C5=CE=C9 Daniel Sterling <sterling.daniel@gmail.com>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 3 =C9=C0=CE=D1 2014 =C7. 20:06
=EB=CF=CD=D5: Ilya Storozhilov
=EB=CF=D0=C9=D1: ceph-devel@vger.kernel.org
=F4=C5=CD=C1: Re: Official Ceph RPM build flags needed

The compiler flags are in the source RPM, is that correct?


On Tue, Jun 3, 2014 at 11:56 AM, Ilya Storozhilov
<Ilya_Storozhilov@epam.com> wrote:
> Hello Ceph-developers,
>
> at the moment we are doing some performance testing of Ceph v0.72.2 o=
n ContOS 6.5, 64 bit. He have found, that Ceph from official RPM works =
faster that one which was compiled ourselves from sources. Do you know =
what compiler flags and configure options are actually used to build of=
ficial Ceph PRM for CentOS? Maybe you can give an advise where to dig t=
o find out what we need? :)
>
> Thank you very much!
>
> Best Regards,
> Ilya Storozhilov
> Lead Software Engineer
>
> EPAM Systems
> Tver office, Russia
> GMT+4
>
> EPAM Internal ext.:  55529
> Office phone:        +7 (4822) 630-070 ext. 55529
> Office fax:          +7 (4822) 630-073
> Mobile phone:        +7 (904) 021-0763
> E-mail:              Ilya_Storozhilov@epam.com
>
> http://www.epam.com
>
> CONFIDENTIALITY CAUTION AND DISCLAIMER
> This message is intended only for the use of the individual(s) or ent=
ity(ies) to which it is addressed and contains information that is lega=
lly privileged and confidential. If you are not the intended recipient,=
 or the person responsible for delivering the  message to the intended =
recipient, you are hereby notified that any dissemination, distribution=
 or copying of this communication is strictly prohibited. All unintende=
d recipients are obliged to delete this message and destroy any printed=
 copies.
>
>          --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
