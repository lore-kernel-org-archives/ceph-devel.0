From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH] ceph.spec.in: Move libcls_*.so from -devel to base package
Date: Wed, 22 Feb 2012 10:00:15 -0800
Message-ID: <CAF3hT9Cz6fe46t6dO137V+qoRG=UwO3eTNubVUpmBpFTVj-sZw@mail.gmail.com>
References: <20120215162908.GA22127@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48336 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab2BVSAQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2012 13:00:16 -0500
Received: by iacb35 with SMTP id b35so325705iac.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 10:00:15 -0800 (PST)
In-Reply-To: <20120215162908.GA22127@homac.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Holger Macht <hmacht@suse.de>
Cc: ceph-devel@vger.kernel.org

I didn't see him say so, but Sage pulled this in last week...thanks! :)
-Greg

On Wed, Feb 15, 2012 at 8:29 AM, Holger Macht <hmacht@suse.de> wrote:
> OSDs (src/osd/ClassHandler.cc) specifically look for libcls_*.so in
> /usr/$libdir/rados-classes, so libcls_rbd.so and libcls_rgw.so need t=
o
> be shipped along with the base package.
>
> Signed-off-by: Holger Macht <hmacht@suse.de>
> ---
> =A0ceph.spec.in | =A0 =A06 ++----
> =A01 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/ceph.spec.in b/ceph.spec.in
> index 48fd4ee..58c3af7 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -348,8 +348,8 @@ fi
> =A0%ghost %dir %{_localstatedir}/run/ceph/
> =A0%dir %{_sysconfdir}/ceph/
> =A0/usr/sbin/rcceph
> -%{_libdir}/rados-classes/libcls_rbd.so.*
> -%{_libdir}/rados-classes/libcls_rgw.so.*
> +%{_libdir}/rados-classes/libcls_rbd.so*
> +%{_libdir}/rados-classes/libcls_rgw.so*
>
> =A0##################################################################=
###############
> =A0%files fuse
> @@ -377,8 +377,6 @@ fi
> =A0%dir %{_includedir}/rbd
> =A0%{_includedir}/rbd/librbd.h
> =A0%{_includedir}/rbd/librbd.hpp
> -%{_libdir}/rados-classes/libcls_rbd.so
> -%{_libdir}/rados-classes/libcls_rgw.so
> =A0%{_libdir}/libcephfs.so
> =A0%{_libdir}/librbd.so
> =A0%{_libdir}/librgw.so
> --
> 1.7.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
