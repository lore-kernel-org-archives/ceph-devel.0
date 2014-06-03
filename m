From: Daniel Sterling <sterling.daniel@gmail.com>
Subject: Re: Official Ceph RPM build flags needed
Date: Tue, 3 Jun 2014 12:26:32 -0400
Message-ID: <CAJZMiue2fFqspkMAN5SXGSqpeDfrc2o0S-diEf5fjJ4WkHRiJQ@mail.gmail.com>
References: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com>
	<CAJZMiudJFUfWncXhkVncYOhzOXzkSLCgRYLrU=vTrFwDNSZykw@mail.gmail.com>
	<285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:43690 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932568AbaFCQ0d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 12:26:33 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so13409306qga.20
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jun 2014 09:26:32 -0700 (PDT)
In-Reply-To: <285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I believe the defaults for that come from the redhat-rpm-config package

On Tue, Jun 3, 2014 at 12:19 PM, Ilya Storozhilov
<Ilya_Storozhilov@epam.com> wrote:
> Hello Daniel,
>
> thank you for rapid response. "ceph.spec" file from the SRPM contains=
 following lines:
>
> ---------------------------------------------------------------------=
-------------------------------
> ...
> export RPM_OPT_FLAGS=3D`echo $RPM_OPT_FLAGS | sed -e 's/i386/i486/'`
>
> %{configure}    CPPFLAGS=3D"$java_inc" \
>                 --prefix=3D/usr \
>                 --localstatedir=3D/var \
>                 --sysconfdir=3D/etc \
>                 --docdir=3D%{_docdir}/ceph \
>                 --with-nss \
>                 --without-cryptopp \
>                 --with-rest-bench \
>                 --with-debug \
>                 --enable-cephfs-java \
>                 $MY_CONF_OPT \
>                 %{?_with_ocf} \
>                 CFLAGS=3D"$RPM_OPT_FLAGS" CXXFLAGS=3D"$RPM_OPT_FLAGS"
> ...
> ---------------------------------------------------------------------=
-------------------------------
>
> So it seems, that this is up to packager what to put to RPM_OPT_FLAGS=
 environment variable on packaging. Maybe someone knows what particular=
 value is used?
> Thank you!
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
 or the person responsible for delivering the message to the intended r=
ecipient, you are hereby notified that any dissemination, distribution =
or copying of this communication is strictly prohibited. All unintended=
 recipients are obliged to delete this message and destroy any printed =
copies.
>
>
> ________________________________________
> =D0=9E=D1=82: ceph-devel-owner@vger.kernel.org <ceph-devel-owner@vger=
=2Ekernel.org> =D0=BE=D1=82 =D0=B8=D0=BC=D0=B5=D0=BD=D0=B8 Daniel Sterl=
ing <sterling.daniel@gmail.com>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 3 =D0=B8=
=D1=8E=D0=BD=D1=8F 2014 =D0=B3. 20:06
> =D0=9A=D0=BE=D0=BC=D1=83: Ilya Storozhilov
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: ceph-devel@vger.kernel.org
> =D0=A2=D0=B5=D0=BC=D0=B0: Re: Official Ceph RPM build flags needed
>
> The compiler flags are in the source RPM, is that correct?
>
>
> On Tue, Jun 3, 2014 at 11:56 AM, Ilya Storozhilov
> <Ilya_Storozhilov@epam.com> wrote:
>> Hello Ceph-developers,
>>
>> at the moment we are doing some performance testing of Ceph v0.72.2 =
on ContOS 6.5, 64 bit. He have found, that Ceph from official RPM works=
 faster that one which was compiled ourselves from sources. Do you know=
 what compiler flags and configure options are actually used to build o=
fficial Ceph PRM for CentOS? Maybe you can give an advise where to dig =
to find out what we need? :)
>>
>> Thank you very much!
>>
>> Best Regards,
>> Ilya Storozhilov
>> Lead Software Engineer
>>
>> EPAM Systems
>> Tver office, Russia
>> GMT+4
>>
>> EPAM Internal ext.:  55529
>> Office phone:        +7 (4822) 630-070 ext. 55529
>> Office fax:          +7 (4822) 630-073
>> Mobile phone:        +7 (904) 021-0763
>> E-mail:              Ilya_Storozhilov@epam.com
>>
>> http://www.epam.com
>>
>> CONFIDENTIALITY CAUTION AND DISCLAIMER
>> This message is intended only for the use of the individual(s) or en=
tity(ies) to which it is addressed and contains information that is leg=
ally privileged and confidential. If you are not the intended recipient=
, or the person responsible for delivering the  message to the intended=
 recipient, you are hereby notified that any dissemination, distributio=
n or copying of this communication is strictly prohibited. All unintend=
ed recipients are obliged to delete this message and destroy any printe=
d copies.
>>
>>          --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
