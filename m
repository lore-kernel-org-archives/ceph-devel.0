From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Compile error in rgw/rgw_xml.h in 0.46
Date: Thu, 10 May 2012 14:58:20 -0700
Message-ID: <CADvuQRF-r=vhK3Jug_vX3D20k27pYOd2oZVwFqYoQTbZGuJ=_Q@mail.gmail.com>
References: <3675148.h66agqk253@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40727 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761729Ab2EJV6k convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 17:58:40 -0400
Received: by pbbrp8 with SMTP id rp8so2442145pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 14:58:40 -0700 (PDT)
In-Reply-To: <3675148.h66agqk253@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Wed, May 9, 2012 at 6:46 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Compiling Ceph 0.46 fails at rgw/rgw_dencoder.cc with the following e=
rrors:
>
> In file included from rgw/rgw_dencoder.cc:7:
> rgw/rgw_acl_s3.h:9:19: error: expat.h: No such file or directory
> In file included from rgw/rgw_acl_s3.h:11,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from rgw/rgw_=
dencoder.cc:7:
> rgw/rgw_xml.h:59: error: 'XML_Parser' does not name a type
> make[3]: *** [ceph_dencoder-rgw_dencoder.o] Error 1
> make[3]: Leaving directory `/root/ceph-0.46/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/root/ceph-0.46/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ceph-0.46/src'
> make: *** [all-recursive] Error 1
>
> This is on CentOS 6.2.
>
> I managed to get it to compile by installing expat-devel first. Maybe=
 the
> configure script should check for the existence of the expat header f=
iles?

What commands did you run to get to that point?

configure.ac does have an explicit check that tries to use XML_Parse
from expat. It's a little bit intricate due to the nesting, but a
quick read says it should work just right. Getting the command you ran
and full output from your configure run would be helpful.

https://github.com/ceph/ceph/blob/master/configure.ac#L183
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
