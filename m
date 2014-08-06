From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH master] rbd.cc: add --force option at 'rbd import'
Date: Tue, 05 Aug 2014 18:10:07 -0700
Message-ID: <53E1806F.8050905@inktank.com>
References: <53C022CA.2050805@inktank.com> <1405676749-14204-1-git-send-email-bl.dimitris@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44077 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132AbaHFBJr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 21:09:47 -0400
In-Reply-To: <1405676749-14204-1-git-send-email-bl.dimitris@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitris Bliablias <bl.dimitris@gmail.com>, ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com

On 07/18/2014 02:45 AM, Dimitris Bliablias wrote:
> Extend the rbd utility with a new option named '--force'. This option
> will be used by the 'rbd import' command to allow overwriting an
> existing rbd image, something which is currently forbidden. If the image
> has snapshots, the command returns an error and nothing is imported. The
> force option will first remove the existing rbd image and then recreate
> it before importing the new data.
>
> This patch also updates the tests affected by the modified functions, to
> reflect the latest changes. In addition, updates the rbd man page
> accordingly to record the new '--force' option.
>
> Signed-off-by: Dimitris Bliablias <bl.dimitris@gmail.com>
> ---
> Hello,
>
> I've refactored the patch as you suggested, but I had to also drop the
> '-f' option and keep only the '--force' one. This was made due to the
> fact that the '-f' option is currently used along with the
> '--foreground' option that specifies whether the Ceph daemons should run
> in the foreground or not. The 'parse_argv' function of the
> 'src/common/config.h' file is called before the argument parsing of the
> rbd utility command line options and consequently it consumes the '-f'
> argument whenever it is supplied. Not sure if this is the intended
> behavior for the '-f' option.

This is a side-effect of the common args parsing infrastructure shared
by daemons (where this option makes sense) and command line tools.
Since this is triggered by global_init() which takes a daemon/utility
flag, it wouldn't be too hard to pass that down to the config code and
ignore daemon-only options like this for command line tools.

> Thanks,
> Dimitris
>
>   doc/man/8/rbd.rst                 | 12 +++++++-
>   qa/workunits/rbd/import_export.sh |  6 ++++
>   src/rbd.cc                        | 65 +++++++++++++++++++++++++++++++++++++--
>   src/test/cli/rbd/help.t           |  3 +-
>   4 files changed, 81 insertions(+), 5 deletions(-)
>
> diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
> index 5424547..46d7f21 100644
> --- a/doc/man/8/rbd.rst
> +++ b/doc/man/8/rbd.rst
> @@ -123,6 +123,11 @@ Parameters
>
>      Map the image read-only.  Equivalent to -o ro.
>
> +.. option:: --force
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
> +  the data from path).
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
> diff --git a/src/rbd.cc b/src/rbd.cc
> index c068ed6..a0cf544 100644
> --- a/src/rbd.cc
> +++ b/src/rbd.cc
> @@ -28,6 +28,7 @@
>
>   #include "include/compat.h"
>   #include "common/blkdev.h"
> +#include "librbd/internal.h"
>
>   #include <boost/scoped_ptr.hpp>
>   #include <errno.h>
> @@ -89,7 +90,7 @@ void usage()
>   "  rm <image-name>                             delete an image\n"
>   "  export <image-name> <path>                  export image to file\n"
>   "                                              \"-\" for stdout\n"
> -"  import <path> <image-name>                  import image from file\n"
> +"  import <path> <image-name> [--force]        import image from file\n"
>   "                                              (dest defaults\n"
>   "                                               as the filename part of file)\n"
>   "                                              \"-\" for stdin\n"
> @@ -150,6 +151,7 @@ void usage()
>   "  --no-progress                      do not show progress for long-running commands\n"
>   "  -o, --options <map-options>        options to use when mapping an image\n"
>   "  --read-only                        set device readonly when mapping image\n"
> +"  --force                            overwrite an existing image when importing\n"
>   "  --allow-shrink                     allow shrinking of an image when resizing\n";
>   }
>
> @@ -1290,7 +1292,7 @@ done_img:
>
>   static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
>   		     const char *imgname, int *order, const char *path,
> -		     int format, uint64_t features, uint64_t size)
> +		     int format, uint64_t features, uint64_t size, bool force)
>   {
>     int fd, r;
>     struct stat stat_buf;
> @@ -1310,6 +1312,7 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
>     ssize_t readlen;		// amount received from one read
>     size_t blklen = 0;		// amount accumulated from reads to fill blk
>     librbd::Image image;
> +  bool old_format;
>
>     bool from_stdin = !strcmp(path, "-");
>     if (from_stdin) {
> @@ -1346,6 +1349,53 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
>         size = (uint64_t) bdev_size;
>       }
>     }
> +  // check if the rbd image already exists, in either format
> +  r = librbd::detect_format(io_ctx, imgname, &old_format, NULL);

I'd rather avoid using librbd-internal functions (like
detect_format()). Trying to open the image image would accomplish the
same thing.

> +  if (r != -ENOENT) {
> +    if (force) {
> +      // using the force option when importing to an rbd image is only allowed
> +      // for images of the same format

I'm not sure why this restriction would be useful. What's the rationale?
To me the format is just another property of the image.

> +      bool format_match =
> +	old_format ? (format == 1) : (format == 2);
> +      if (format_match) {
> +        // force option supplied, remove the original image
> +        r = do_delete(rbd, io_ctx, imgname);
> +	if (r < 0) {
> +	  if (r == -ENOTEMPTY) {
> +	    cerr << "rbd: image has snapshots - these must be deleted"
> +		 << " with 'rbd snap purge' before the image can be removed."
> +		 << std::endl;
> +	  } else if (r == -EBUSY) {
> +	    cerr << "rbd: error: image still has watchers"
> +		 << std::endl
> +		 << "This means the image is still open or the client using "
> +		 << "it crashed. Try again after closing/unmapping it or "
> +		 << "waiting 30s for the crashed client to timeout."
> +		 << std::endl;
> +	  } else {
> +	    cerr << "rbd: error removing original image: " << cpp_strerror(-r)
> +		 << std::endl;
> +	  }

This section of do_delete() and print various error messages can go into 
a helper, called from here and main() for 'rbd rm'.

The rest looks good.

Thanks!
Josh

> +	goto done;
> +	}
> +      } else {
> +	cerr << "rbd: image " << imgname << " already exists in format "
> +	     << format << std::endl
> +	     << "Option '--force' is only valid for images of the same format."
> +	     << std::endl;
> +	r = -EEXIST;
> +	goto done;
> +      }
> +    } else {
> +      cerr << "rbd: image " << imgname << " already exists"
> +	   << std::endl
> +	   << "If you really know what you are doing, supply the"
> +	   << " '--force' option to overwrite this image."
> +	   << std::endl;
> +      r = -EEXIST;
> +      goto done;
> +    }
> +  }
>     r = do_create(rbd, io_ctx, imgname, size, order, format, features, 0, 0);
>     if (r < 0) {
>       cerr << "rbd: image creation failed" << std::endl;
> @@ -1972,6 +2022,7 @@ int main(int argc, const char **argv)
>     int order = 0;
>     bool format_specified = false, output_format_specified = false;
>     int format = 1;
> +  bool force = false;
>     uint64_t features = RBD_FEATURE_LAYERING;
>     const char *imgname = NULL, *snapname = NULL, *destname = NULL,
>       *dest_poolname = NULL, *dest_snapname = NULL, *path = NULL,
> @@ -1997,6 +2048,8 @@ int main(int argc, const char **argv)
>       } else if (ceph_argparse_flag(args, i, "-h", "--help", (char*)NULL)) {
>         usage();
>         return 0;
> +    } else if (ceph_argparse_flag(args, i, "--force", (char*)NULL)) {
> +      force = true;
>       } else if (ceph_argparse_flag(args, i, "--new-format", (char*)NULL)) {
>         format = 2;
>         format_specified = true;
> @@ -2190,6 +2243,12 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>       }
>     }
>
> +  if (force && opt_cmd != OPT_IMPORT) {
> +    cerr << "rbd: --force can only be used when"
> +	 << " importing an image" << std::endl;
> +    return EXIT_FAILURE;
> +  }
> +
>     if (format_specified && opt_cmd != OPT_IMPORT && opt_cmd != OPT_CREATE) {
>       cerr << "rbd: image format can only be set when "
>   	 << "creating or importing an image" << std::endl;
> @@ -2663,7 +2722,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>         return EINVAL;
>       }
>       r = do_import(rbd, dest_io_ctx, destname, &order, path,
> -		  format, features, size);
> +		  format, features, size, force);
>       if (r < 0) {
>         cerr << "rbd: import failed: " << cpp_strerror(-r) << std::endl;
>         return -r;
> diff --git a/src/test/cli/rbd/help.t b/src/test/cli/rbd/help.t
> index 3818ee3..1529efd 100644
> --- a/src/test/cli/rbd/help.t
> +++ b/src/test/cli/rbd/help.t
> @@ -16,7 +16,7 @@
>       rm <image-name>                             delete an image
>       export <image-name> <path>                  export image to file
>                                                   "-" for stdout
> -    import <path> <image-name>                  import image from file
> +    import <path> <image-name> [--force]        import image from file
>                                                   (dest defaults
>                                                    as the filename part of file)
>                                                   "-" for stdin
> @@ -77,4 +77,5 @@
>       --no-progress                      do not show progress for long-running commands
>       -o, --options <map-options>        options to use when mapping an image
>       --read-only                        set device readonly when mapping image
> +    --force                            overwrite an existing image when importing
>       --allow-shrink                     allow shrinking of an image when resizing
>

