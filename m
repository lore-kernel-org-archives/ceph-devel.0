From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: make with -j fails
Date: Fri, 2 Jul 2010 10:04:43 -0700
Message-ID: <AANLkTinhbEZtQmrjbeWRQQSCkAjmG-1ZQEjtCY8SAaqG@mail.gmail.com>
References: <i0k456$g5f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35866 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758747Ab0GBREp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jul 2010 13:04:45 -0400
Received: by fxm14 with SMTP id 14so2561217fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jul 2010 10:04:44 -0700 (PDT)
In-Reply-To: <i0k456$g5f$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

This is a longstanding but minor bug (it works without issue after the
initial compile); Sage fixed it in commit
9be976259a4630563e0aeaec390a217e40ae5c0f.

On Fri, Jul 2, 2010 at 12:23 AM, Thomas Mueller <thomas@chaschperli.ch>=
 wrote:
> hi
>
> as soon as I try to use the -j option the make fails. tried with -j2 =
and -
> j8
>
> is it supposed to work to call make with "-j" to speedup the compilat=
ion
> time?
>
> - Thomas
>
> if g++ -DHAVE_CONFIG_H -I. -I. -I. =A0 =A0-Wall -D__CEPH__ -
> D_FILE_OFFSET_BITS=3D64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -O2 -g =
-pipe -
> Wall -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -fstack-protector --param=
=3Dssp-
> buffer-size=3D4 -m64 -mtune=3Dgeneric -MT buffer.o -MD -MP -MF ".deps=
/
> buffer.Tpo" -c -o buffer.o `test -f 'common/buffer.cc' || echo
> './'`common/buffer.cc; \
> =A0 =A0 =A0 =A0then mv -f ".deps/buffer.Tpo" ".deps/buffer.Po"; else =
rm -f
> ".deps/buffer.Tpo"; exit 1; fi
> if g++ -DHAVE_CONFIG_H -I. -I. -I. =A0 =A0-Wall -D__CEPH__ -
> D_FILE_OFFSET_BITS=3D64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -O2 -g =
-pipe -
> Wall -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -fstack-protector --param=
=3Dssp-
> buffer-size=3D4 -m64 -mtune=3Dgeneric -MT debug.o -MD -MP -MF ".deps/
> debug.Tpo" -c -o debug.o `test -f 'common/debug.cc' || echo './'`comm=
on/
> debug.cc; \
> =A0 =A0 =A0 =A0then mv -f ".deps/debug.Tpo" ".deps/debug.Po"; else rm=
 -f ".deps/
> debug.Tpo"; exit 1; fi
> common/debug.cc:8:22: error: ceph_ver.h: No such file or directory
> make[2]: *** [debug.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[2]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc/src'
> Making all in man
> make[1]: Entering directory `/builddir/build/BUILD/ceph-0.21~rc/man'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc/man'
> make[1]: Entering directory `/builddir/build/BUILD/ceph-0.21~rc'
> make[1]: Nothing to be done for `all-am'.
> make[1]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc'
> make: *** [all-recursive] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.52754 (%build)
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
