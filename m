From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH master] rbd.cc: add --force option at 'rbd import'
Date: Fri, 11 Jul 2014 10:45:46 -0700
Message-ID: <53C022CA.2050805@inktank.com>
References: <1403091761-26148-1-git-send-email-bl.dimitris@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50374 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbaGKRpc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jul 2014 13:45:32 -0400
In-Reply-To: <1403091761-26148-1-git-send-email-bl.dimitris@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitris Bliablias <bl.dimitris@gmail.com>, ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com

On 06/18/2014 04:42 AM, Dimitris Bliablias wrote:
> Extend the rbd utility with a new option named '--force'. This option
> will be used by the 'rbd import' command to allow overwriting an
> existing rbd image, something which is currently forbidden. If the image
> has snapshots, the command returns an error and nothing is imported. The
> force option will first remove the existing rbd image and then recreate
> it before importing the new data.

It makes sense to add a --force option to rbd import.

> This patch also updates the tests affected by the modified functions, to
> reflect the latest changes. In addition, updates the rbd man page
> accordingly to record the new '--force' option.

Excellent, it's great to see tests, all bindings, and the man page
updated in the right place.

> Signed-off-by: Dimitris Bliablias <bl.dimitris@gmail.com>
> ---
>   doc/man/8/rbd.rst                    |  12 +++-
>   qa/workunits/rbd/import_export.sh    |   6 ++
>   src/include/rbd/librbd.h             |   9 ++-
>   src/include/rbd/librbd.hpp           |   7 +-
>   src/librbd/internal.cc               |  61 +++++++++++++---
>   src/librbd/internal.h                |   4 +-
>   src/librbd/librbd.cc                 |  29 ++++----
>   src/pybind/rbd.py                    |  11 +--
>   src/rbd.cc                           |  27 +++++---
>   src/rbd_fuse/rbd-fuse.c              |   2 +-
>   src/test/bench/small_io_bench_rbd.cc |   2 +-
>   src/test/cli/rbd/help.t              |   3 +-
>   src/test/librbd/fsx.c                |   5 +-
>   src/test/librbd/test_librbd.cc       | 131 +++++++++++++++++++++++++----------
>   14 files changed, 227 insertions(+), 82 deletions(-)
>
> diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
> index 215aa92..95cd7d3 100644
> --- a/doc/man/8/rbd.rst
> +++ b/doc/man/8/rbd.rst
> @@ -123,6 +123,11 @@ Parameters
>
>      Map the image read-only.  Equivalent to -o ro.
>
> +.. option:: --f, --force
> +
> +   Overwrite an existing rbd image. This option is only used by the rbd import
> +   command. See import section (below) for more details.
> +
>
>   Commands
>   ========
> @@ -176,11 +181,16 @@ Commands
>   :command:`export` [*image-name*] [*dest-path*]
>     Exports image to dest path (use - for stdout).
>
> -:command:`import` [*path*] [*dest-image*]
> +:command:`import` [*path*] [*dest-image*] [--force]
>     Creates a new image and imports its data from path (use - for
>     stdin).  The import operation will try to create sparse rbd images
>     if possible.  For import from stdin, the sparsification unit is
>     the data block size of the destination image (1 << order).
> +  Using the --force option will overwrite the destination image if it exists.
> +  Overwriting images using a different format is not supported. If the image
> +  has snapshots, import fails and nothing is imported. (Note: using --force
> +  will first remove the original rbd image, and then re-create it to import
> +  the data from path.
>
>   :command:`export-diff` [*image-name*] [*dest-path*] [--from-snap *snapname*]
>     Exports an incremental diff for an image to dest path (use - for stdout).  If
> diff --git a/qa/workunits/rbd/import_export.sh b/qa/workunits/rbd/import_export.sh
> index 29fcb6c..1b1b291 100755
> --- a/qa/workunits/rbd/import_export.sh
> +++ b/qa/workunits/rbd/import_export.sh
> @@ -54,6 +54,12 @@ rbd rm testimg
>   cmp /tmp/img /tmp/img2
>   cmp /tmp/img /tmp/img3
>
> +# import using --force option
> +rbd create testimg $RBD_CREATE_ARGS --size 10
> +rbd import $RBD_CREATE_ARGS /tmp/img testimg && exit 1 || true   # should fail
> +rbd import $RBD_CREATE_ARGS /tmp/img testimg --force
> +rbd rm testimg
> +
>   rm /tmp/img /tmp/img2 /tmp/img3
>
>
> diff --git a/src/include/rbd/librbd.h b/src/include/rbd/librbd.h
> index a9a3318..9da6f5d 100644
> --- a/src/include/rbd/librbd.h
> +++ b/src/include/rbd/librbd.h
> @@ -25,6 +25,7 @@ extern "C" {
>   #elif defined(__FreeBSD__)
>   #include <sys/types.h>
>   #endif
> +#include <stdbool.h>
>   #include <string.h>
>   #include "../rados/librados.h"
>   #include "features.h"
> @@ -69,9 +70,10 @@ void rbd_version(int *major, int *minor, int *extra);
>
>   /* images */
>   int rbd_list(rados_ioctx_t io, char *names, size_t *size);
> -int rbd_create(rados_ioctx_t io, const char *name, uint64_t size, int *order);
> +int rbd_create(rados_ioctx_t io, const char *name, uint64_t size, int *order,
> +	       bool force);
>   int rbd_create2(rados_ioctx_t io, const char *name, uint64_t size,
> -		uint64_t features, int *order);
> +		uint64_t features, int *order, bool force);

However, this is changing the ABI, which breaks existing users.
Why not implement this in the command line tool instead of as part of
librbd? Trying to create(), and then removing and recreating if EEXIST
is returned should work just as well.

Josh
