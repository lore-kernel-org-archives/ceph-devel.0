From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] Add X-Python-Version >=2.6 to debian control file.
Date: Mon, 04 Mar 2013 17:35:57 -0800
Message-ID: <51354BFD.4040700@inktank.com>
References: <1361966168-22618-1-git-send-email-philipgian@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:36627 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab3CEBga (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 20:36:30 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so3719060pbc.30
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 17:36:29 -0800 (PST)
In-Reply-To: <1361966168-22618-1-git-send-email-philipgian@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On 02/27/2013 03:56 AM, Filippos Giannakos wrote:
> python-ceph complains when installed to debian squeeze about the 'with'
> statement. Apparently installation tries to install the python-ceph package for
> python 2.5, which does not support the 'with' statement natively.
>
> Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>

Looks good to me. I added it to the wip-py26 branch along with the same
thing for the ceph package, since ceph-disk-* use python 2.6 features
too. I'll merge it once it builds.

Thanks!
Josh

> ---
>   debian/control |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/debian/control b/debian/control
> index eefb4ee..fbf517b 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -8,6 +8,7 @@ Maintainer: Laszlo Boszormenyi (GCS) <gcs@debian.hu>
>   Uploaders: Sage Weil <sage@newdream.net>
>   Build-Depends: debhelper (>= 6.0.7~), autotools-dev, autoconf, automake, libfuse-dev, libboost-dev (>= 1.34), libboost-thread-dev, libedit-dev, libnss3-dev, libtool, libexpat1-dev, libfcgi-dev, libatomic-ops-dev, libgoogle-perftools-dev [i386 amd64], pkg-config, libcurl4-gnutls-dev, libkeyutils-dev, uuid-dev, libaio-dev, python (>= 2.6.6-3~), libxml2-dev, javahelper, default-jdk, junit4, libboost-program-options-dev
>   Standards-Version: 3.9.3
> +X-Python-Version: >=2.6
>
>   Package: ceph
>   Architecture: linux-any
>

