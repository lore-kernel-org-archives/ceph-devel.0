From: Samuel Just <sam.just@inktank.com>
Subject: Re: ceph 0.50 - error compiling on arch
Date: Wed, 15 Aug 2012 15:49:37 -0700
Message-ID: <CA+4uBUY5RE274bBSezqN7e7H3TRAKuwS-sC0pV1wcrUCC-xS5Q@mail.gmail.com>
References: <822d1df7fba4cc32933718e462b84d04@kepler.cl>
	<502C02C2.5080001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55702 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab2HOWti convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Aug 2012 18:49:38 -0400
Received: by vbbff1 with SMTP id ff1so1918662vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Aug 2012 15:49:37 -0700 (PDT)
In-Reply-To: <502C02C2.5080001@free.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: alphe salas <asalasmichels@gmail.com>
Cc: ceph-devel@vger.kernel.org

master/next/testing should now have the intrusive_ptr errors fixed.
-Sam

On Wed, Aug 15, 2012 at 1:12 PM, alphe salas <asalasmichels@gmail.com> =
wrote:
>
>
>
> /usr/include/boost/smart_ptr/intrusive_ptr.hpp: In instantiation of
> 'boost::intrusive_ptr<T>::intrusive_ptr(T*, bool) [with T =3D MOSDPGL=
og]':
> osd/PG.h:871:26:   required from here
> /usr/include/boost/smart_ptr/intrusive_ptr.hpp:67:34: error:
> 'intrusive_ptr_add_ref' was not declared in this scope, and no
> declarations were found by argument-dependent lookup at the point of
> instantiation [-fpermissive]
> osd/PG.cc:5717:6: note: 'void boost::intrusive_ptr_add_ref(PG*)'
> declared here, later in the translation unit
> In file included from /usr/include/boost/intrusive_ptr.hpp:16:0,
>                   from /usr/include/boost/statechart/event_base.hpp:1=
5,
>                   from /usr/include/boost/statechart/event.hpp:11,
>                   from osd/PG.h:19,
>                   from osd/PG.cc:15:
> /usr/include/boost/smart_ptr/intrusive_ptr.hpp: In instantiation of
> 'boost::intrusive_ptr<T>::~intrusive_ptr() [with T =3D MOSDPGLog]':
> osd/PG.h:871:26:   required from here
> /usr/include/boost/smart_ptr/intrusive_ptr.hpp:96:23: error:
> 'intrusive_ptr_release' was not declared in this scope, and no
> declarations were found by argument-dependent lookup at the point of
> instantiation [-fpermissive]
> osd/PG.cc:5718:6: note: 'void boost::intrusive_ptr_release(PG*)'
> declared here, later in the translation unit
> In file included from /usr/include/boost/intrusive_ptr.hpp:16:0,
>                   from /usr/include/boost/statechart/event_base.hpp:1=
5,
>                   from /usr/include/boost/statechart/event.hpp:11,
>                   from osd/PG.h:19,
>                   from osd/PG.cc:15:
> /usr/include/boost/smart_ptr/intrusive_ptr.hpp: In instantiation of
> 'boost::intrusive_ptr<T>::intrusive_ptr(const boost::intrusive_ptr<T>=
&)
> [with T =3D MOSDPGLog; boost::intrusive_ptr<T> =3D
> boost::intrusive_ptr<MOSDPGLog>]':
> /usr/include/boost/smart_ptr/intrusive_ptr.hpp:128:9:   required from
> 'boost::intrusive_ptr<T>& boost::intrusive_ptr<T>::operator=3D(const
> boost::intrusive_ptr<T>&) [with T =3D MOSDPGLog; boost::intrusive_ptr=
<T> =3D
> boost::intrusive_ptr<MOSDPGLog>]'
> osd/PG.cc:5201:16:   required from here
> /usr/include/boost/smart_ptr/intrusive_ptr.hpp:91:23: error:
> 'intrusive_ptr_add_ref' was not declared in this scope, and no
> declarations were found by argument-dependent lookup at the point of
> instantiation [-fpermissive]
> osd/PG.cc:5717:6: note: 'void boost::intrusive_ptr_add_ref(PG*)'
> declared here, later in the translation unit
> make[3]: *** [libosd_a-PG.o] Error 1
> make[3]: Leaving directory
> `/home/netruner/cephinstall/ceph-0.50/src/ceph-0.50/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory
> `/home/netruner/cephinstall/ceph-0.50/src/ceph-0.50/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
> `/home/netruner/cephinstall/ceph-0.50/src/ceph-0.50/src'
> make: *** [all-recursive] Error 1
>
> libboost used: 1.50
> archlinux 64 bits
>
> works fine with 0.48
> So my guess ceph 0.50 has changed anough to trigger that error.
>
> See the attached diff files betwin osd/PG.cc and osd/PG.h 0.50 and 0.=
48
>
> best regards
> --
> Alph=E9 Salas
>   Ingeniero T.I
>
> Kepler Data Recovery - Kepler Backup
>
> Asturias 97, Las Condes
>   Santiago- Chile
> ((56 2) 362 7529
> asalas@kepler.cl
> www.kepler.cl
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
