From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Fri, 15 Apr 2016 15:21:05 +0200
Message-ID: <20160415152105.351ad4e6@bahia.huguette.org>
References: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e06smtp09.uk.ibm.com ([195.75.94.105]:35677 "EHLO
	e06smtp09.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcDONVQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 09:21:16 -0400
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <gkurz@linux.vnet.ibm.com>;
	Fri, 15 Apr 2016 14:21:14 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id EF0D8219004D
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 14:20:50 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3FDLCJj5308786
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 13:21:12 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3FDLBh1013467
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 07:21:12 -0600
In-Reply-To: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: berrange@redhat.com, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com

One more nit in configure. See below.

Cheers.

--
Greg

On Tue, 15 Mar 2016 00:02:48 +0800
Jevon Qiao <scaleqiao@gmail.com> wrote:

> Ceph as a promising unified distributed storage system is widely used in the
> world of OpenStack. OpenStack users deploying Ceph for block (Cinder) and
> object (S3/Swift) are unsurprisingly looking at Manila and CephFS to round out
> a unified storage solution. Since the typical hypervisor people are using is
> Qemu/KVM, it is necessary to provide a high performance, easy to use, file
> system service in it. VirtFS aims to offers paravirtualized system services and
> simple passthrough for directories from host to guest, which currently only
> support local file system, this patch wants to add CephFS support in VirtFS.
> 
> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
> ---
>  configure                         |  33 ++
>  fsdev/qemu-fsdev.c                |   1 +
>  fsdev/qemu-fsdev.h                |   3 +-
>  hw/9pfs/9p-cephfs.c               | 836 ++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/Makefile.objs             |   3 +
>  scripts/analyse-9p-simpletrace.py | 213 ----------
>  scripts/analyze-9p-simpletrace.py | 306 ++++++++++++++
>  trace-events                      |  33 ++
>  8 files changed, 1214 insertions(+), 214 deletions(-)
>  create mode 100644 hw/9pfs/9p-cephfs.c
>  delete mode 100755 scripts/analyse-9p-simpletrace.py
>  create mode 100755 scripts/analyze-9p-simpletrace.py
> 
> diff --git a/configure b/configure
> index 0c0472a..c48f1af 100755
> --- a/configure
> +++ b/configure
> @@ -275,6 +275,7 @@ trace_backends="log"
>  trace_file="trace"
>  spice=""
>  rbd=""
> +cephfs=""
>  smartcard=""
>  libusb=""
>  usb_redir=""
> @@ -1019,6 +1020,10 @@ for opt do
>    ;;
>    --enable-rbd) rbd="yes"
>    ;;
> +  --disable-cephfs) cephfs="no"
> +  ;;
> +  --enable-cephfs) cephfs="yes"
> +  ;;
>    --disable-xfsctl) xfs="no"
>    ;;
>    --enable-xfsctl) xfs="yes"
> @@ -1345,6 +1350,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    vhost-net       vhost-net acceleration support
>    spice           spice
>    rbd             rados block device (rbd)
> +  cephfs          Ceph File System
>    libiscsi        iscsi support
>    libnfs          nfs support
>    smartcard       smartcard support (libcacard)
> @@ -3087,6 +3093,28 @@ EOF
>  fi
> 
>  ##########################################
> +# cephfs probe
> +if test "$cephfs" != "no" ; then
> +  cat > $TMPC <<EOF
> +#include <stdio.h>
> +#include <cephfs/libcephfs.h>
> +int main(void) {
> +    struct ceph_mount_info *cmount;
> +    ceph_create(&cmount, NULL);
> +    return 0;
> +}
> +EOF
> +  cephfs_libs="-lcephfs"
> +  if compile_prog "" "$cephfs_libs" ; then
> +    cephfs=yes
> +  else
> +    if test "$cephfs" = "yes" ; then
> +      feature_not_found "cephfs" "Install libcephfs/ceph devel"
> +    fi
> +    cephfs=no
> +  fi
> +fi
> +##########################################
>  # libssh2 probe
>  min_libssh2_version=1.2.8
>  if test "$libssh2" != "no" ; then
> @@ -4760,6 +4788,7 @@ else
>  echo "spice support     $spice"
>  fi
>  echo "rbd support       $rbd"
> +echo "cephfs support    $cephfs"
>  echo "xfsctl support    $xfs"
>  echo "smartcard support $smartcard"
>  echo "libusb            $libusb"
> @@ -5224,6 +5253,10 @@ if test "$rbd" = "yes" ; then
>    echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
>    echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
>  fi
> +if test "$cephfs" = "yes" ; then
> +  echo "CONFIG_CEPHFS=m" >> $config_host_mak

I also had to turn this into CONFIG_CEPHFS=y to be able to build.

> +  echo "CEPHFS_LIBS=$cephfs_libs" >> $config_host_mak
> +fi
> 

