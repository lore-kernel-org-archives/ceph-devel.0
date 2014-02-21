From: Ken Dreyer <ken.dreyer@inktank.com>
Subject: Re: Fixes for missing and replicated files in ceph.spec.in
Date: Fri, 21 Feb 2014 13:28:21 -0700
Message-ID: <CAOpHjdDFygeaDfzOrB5HDOLc1tp-yvmBsnuvhYKKCDYcSWU0ww@mail.gmail.com>
References: <CABAwU-ZCSVbkLUOvZBd8=+uHD1L6tVS5iAkpDNUS0_myP5Xndw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:44355 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaBUU2m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 15:28:42 -0500
Received: by mail-ve0-f176.google.com with SMTP id jx11so3726104veb.35
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 12:28:42 -0800 (PST)
In-Reply-To: <CABAwU-ZCSVbkLUOvZBd8=+uHD1L6tVS5iAkpDNUS0_myP5Xndw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 21, 2014 at 4:27 AM, huang jun <hjwsm1989@gmail.com> wrote:
> Signed-off-by: hjwsm1989<hjwsm1989@gmail.com>
>
> --
> diff --git a/ceph.spec.in b/ceph.spec.in
> index 3caa849..facba6c 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -429,6 +429,7 @@ fi
> @@ -429,6 +429,7 @@ fi
>  %{_libdir}/rados-classes/libcls_log.so*
> diff --git a/ceph.spec.in b/ceph.spec.in
> index 3caa849..facba6c 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -429,6 +429,7 @@ fi
>  %{_libdir}/rados-classes/libcls_replica_log.so*
>  %{_libdir}/rados-classes/libcls_statelog.so*
> +%{_libdir}/rados-classes/libcls_user.so*

Thanks for catching this.


> @@ -690,6 +689,7 @@ fi
>  %{_bindir}/ceph_test_rados_list_parallel
>  %{_bindir}/ceph_test_rados_open_pools_parallel
>  %{_bindir}/ceph_test_rados_watch_notify
> +%{_bindir}/ceph_test_rgw_manifest
>  %{_bindir}/ceph_test_signal_handlers
>  %{_bindir}/ceph_test_snap_mapper


It seems like we have to deal with this sort of thing over and over.
Anyone have objections to simply using a wildcard to capture all the
test files? Something like %{_bindir}/ceph_test_* ?

- Ken
