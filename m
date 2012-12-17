From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: Add --json flag for the showmapped command
Date: Mon, 17 Dec 2012 09:25:50 -0800
Message-ID: <50CF559E.9040504@inktank.com>
References: <50A6748C.7040303@inktank.com> <1355413032-18095-1-git-send-email-psomas@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:34122 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2LQRZx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 12:25:53 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2938599dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 09:25:52 -0800 (PST)
In-Reply-To: <1355413032-18095-1-git-send-email-psomas@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stratos Psomadakis <psomas@grnet.gr>
Cc: ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On 12/13/2012 07:37 AM, Stratos Psomadakis wrote:
> Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
> ---
> Hi Josh,
>
> This patch adds the '--json' flag to enable dumping the showmapped output in
> json format (as you suggested). I'm not sure if any other rbd subcommands could
> make use of this flag (so the patch is showmapped-specific atm).

Thanks, this looks good overall. Mainly some style nits below.

Other subcommands that could use json output would be:

info
ls [-l]
snap ls
lock list
children

> Comments?
>
> Thanks,
> Stratos
>
>   man/rbd.8  |    5 +++++
>   src/rbd.cc |   54 +++++++++++++++++++++++++++++++++++++++++-------------
>   2 files changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/man/rbd.8 b/man/rbd.8
> index 6004244..7bf4c39 100644
> --- a/man/rbd.8
> +++ b/man/rbd.8
> @@ -132,6 +132,11 @@ be open from more than one client at once, like during
>   live migration of a virtual machine, or for use underneath
>   a clustered filesystem.
>   .UNINDENT
> +.INDENT 0.0
> +.TP
> +.B \-\-json
> +Dump output in json format (currently used only by showmapped).
> +.UNINDENT
>   .SH COMMANDS
>   .INDENT 0.0
>   .TP

These man pages are actually generated from rst in ceph.git.
In this case the source file is docs/man/8/rbd.rst. Building
the documentation rebuilds the man pages as well [1], although
this could be more explicit in the docs.

If you send the rst change, I can rebuild the man pages.

> diff --git a/src/rbd.cc b/src/rbd.cc
> index 3db8978..82a72ba 100644
> --- a/src/rbd.cc
> +++ b/src/rbd.cc
> @@ -47,6 +47,8 @@
>   #include "include/rbd_types.h"
>   #include "common/TextTable.h"
>
> +#include "common/Formatter.h"
> +
>   #if defined(__linux__)
>   #include <linux/fs.h>
>   #endif
> @@ -126,7 +128,8 @@ void usage()
>   "                               format 2 supports cloning\n"
>   "  --id <username>              rados user (without 'client.' prefix) to authenticate as\n"
>   "  --keyfile <path>             file containing secret key for use with cephx\n"
> -"  --shared <tag>               take a shared (rather than exclusive) lock\n";
> +"  --shared <tag>               take a shared (rather than exclusive) lock\n"
> +"  --json                       dump output in json format (currently used only by showmapped)\n";
>   }
>
>   static string feature_str(uint64_t features)
> @@ -1198,7 +1201,7 @@ void do_closedir(DIR *dp)
>       closedir(dp);
>   }
>
> -static int do_kernel_showmapped()
> +static int do_kernel_showmapped(bool dump_json)
>   {
>     int r;
>     bool have_output = false;
> @@ -1220,12 +1223,18 @@ static int do_kernel_showmapped()
>       return r;
>     }
>
> +  JSONFormatter jsf(false);
>     TextTable tbl;
> -  tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
> -  tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
> -  tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
> -  tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
> -  tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
> +  if(dump_json == false) {

Missing space between if and (. Swapping the cases so if (dump_json)
came first would be a little nicer to read.

> +    tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
> +    tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
> +    tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
> +    tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
> +    tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
> +  }
> +  else {

} else {

> +    jsf.open_object_section("devices");
> +  }
>
>     do {
>       if (strcmp(dent->d_name, ".") == 0 || strcmp(dent->d_name, "..") == 0)
> @@ -1262,13 +1271,30 @@ static int do_kernel_showmapped()
>   	   << cpp_strerror(-r) << std::endl;
>         continue;
>       }
> -
> -    tbl << dent->d_name << pool << name << snap << dev << TextTable::endrow;
> +
> +    if (dump_json == false) {

same comment about swapping the cases

> +      tbl << dent->d_name << pool << name << snap << dev << TextTable::endrow;
> +    }
> +    else {

} else {

> +      jsf.open_object_section(dent->d_name);
> +      jsf.dump_string("pool", pool);
> +      jsf.dump_string("name", name);
> +      jsf.dump_string("snap", snap);
> +      jsf.dump_string("device", dev);
> +      jsf.close_section();
> +    }
>       have_output = true;
>
>     } while ((dent = readdir(device_dir.get())));
> -  if (have_output)
> -    cout << tbl;
> +
> +  if (dump_json == false) {

same comment about swapping the cases

> +    if (have_output)
> +      cout << tbl;
> +  }
> +  else {

} else {

> +    jsf.close_section();
> +    jsf.flush(cout);
> +  }
>
>     return 0;
>   }
> @@ -1505,7 +1531,7 @@ int main(int argc, const char **argv)
>     const char *poolname = NULL;
>     uint64_t size = 0;  // in bytes
>     int order = 0;
> -  bool format_specified = false;
> +  bool format_specified = false, dump_json = false;
>     int format = 1;
>     uint64_t features = RBD_FEATURE_LAYERING;
>     const char *imgname = NULL, *snapname = NULL, *destname = NULL,
> @@ -1579,6 +1605,8 @@ int main(int argc, const char **argv)
>         imgname = strdup(val.c_str());
>       } else if (ceph_argparse_witharg(args, i, &val, "--shared", (char *)NULL)) {
>         lock_tag = strdup(val.c_str());
> +    } else if (ceph_argparse_flag(args, i, "--json", (char *) NULL)) {
> +      dump_json = true;
>       } else {
>         ++i;
>       }
> @@ -2130,7 +2158,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>       break;
>
>     case OPT_SHOWMAPPED:
> -    r = do_kernel_showmapped();
> +    r = do_kernel_showmapped(dump_json);
>       if (r < 0) {
>         cerr << "rbd: showmapped failed: " << cpp_strerror(-r) << std::endl;
>         return EXIT_FAILURE;
>

It'd be nice to report an error and fail if the --json option (or
whatever it ends up being) is provided for a command that doesn't use
it.

Josh

[1] http://ceph.com/docs/master/dev/generatedocs/
