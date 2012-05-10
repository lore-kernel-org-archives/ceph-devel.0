From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Compile error in rgw/rgw_xml.h in 0.46
Date: Thu, 10 May 2012 15:04:35 -0700
Message-ID: <CAC-hyiHvY19PKMaN7RU_ueMsJkfaFxazPdghxTNKczzt_u+Tyg@mail.gmail.com>
References: <3675148.h66agqk253@pc10>
	<CAC-hyiGvV_ePBJL=AEzbaMO5gCoYWV9ggKuTbF0VUJCXiURg7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39791 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761727Ab2EJWEg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 18:04:36 -0400
Received: by bkcji2 with SMTP id ji2so1748022bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 15:04:35 -0700 (PDT)
In-Reply-To: <CAC-hyiGvV_ePBJL=AEzbaMO5gCoYWV9ggKuTbF0VUJCXiURg7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Oops, missed posting it to the list (seeing Tommi's comment).

On Wed, May 9, 2012 at 11:04 AM, Yehuda Sadeh <yehuda@inktank.com> wrot=
e:
>
> On Wed, May 9, 2012 at 6:46 AM, Guido Winkelmann
> <guido-ceph@thisisnotatest.de> wrote:
> > Compiling Ceph 0.46 fails at rgw/rgw_dencoder.cc with the following
> > errors:
> >
> > In file included from rgw/rgw_dencoder.cc:7:
> > rgw/rgw_acl_s3.h:9:19: error: expat.h: No such file or directory
> > In file included from rgw/rgw_acl_s3.h:11,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from rgw/rgw_dencoder.cc:7:
> > rgw/rgw_xml.h:59: error: 'XML_Parser' does not name a type
> > make[3]: *** [ceph_dencoder-rgw_dencoder.o] Error 1
> > make[3]: Leaving directory `/root/ceph-0.46/src'
> > make[2]: *** [all-recursive] Error 1
> > make[2]: Leaving directory `/root/ceph-0.46/src'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/root/ceph-0.46/src'
> > make: *** [all-recursive] Error 1
> >
> > This is on CentOS 6.2.
> >
> > I managed to get it to compile by installing expat-devel first. May=
be
> > the
> > configure script should check for the existence of the expat header
> > files?
> >
> Actually, the config script checks for that, but only if rgw is
> enabled. We need to figure out what would be the best solution. I
> don't think expat should be a dependency when rgw is not enabled, so
> we should need to figure how to remove this dependency. It might be
> that the easiest solution would be to not compile all the rgw stuff
> into the dencoder when rgw is not enabled (which makes sense anyway).
> I opened bug #2390 to track this issue.
>
> Thanks,
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
