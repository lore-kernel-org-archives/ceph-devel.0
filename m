From: Sage Weil <sage@newdream.net>
Subject: Re: mkcephfs: error when creating journal file in a directory that
  differs from OSD data dir
Date: Thu, 3 Jun 2010 16:41:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006031641380.29455@cobra.newdream.net>
References: <AANLkTil_ohGJT2BXejGM0__A_WMdhXUQKdXQK7oKjdPR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54648 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277Ab0FCXld (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jun 2010 19:41:33 -0400
In-Reply-To: <AANLkTil_ohGJT2BXejGM0__A_WMdhXUQKdXQK7oKjdPR@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: CC Lien <cc_lien@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Applied this to unstable, thanks!

sage


On Thu, 3 Jun 2010, CC Lien wrote:

> Hi
> 
> I have a small fix for mkcephfs script, which fixed the problem mentioned
> below.
> 
> 
> mkcephfs creates osd data directory automatically, but it doesn't create a
> directory for the osd journal file.
> 
> When you have a journal file in a directory that differs from the osd data
> directory in your configuration, like:
> 
>        osd data = /osd/osd$id
> 
>        osd journal = /journal/osd$id
> 
> 
> You will receive a "mount failed to open journal /journal/osd0/journal: No
> such file or directory" error when doing mkcephfs
> 
> 
> * The patch is based on the latest "unstable" branch.
> 
> 
> cclien
> 
> 
> Signed-off-by: CC Lien <cc_lien@tcloudcomputing.com>
> ---
>  src/mkcephfs.in |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index 1caddf1..6c1f2dc 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -220,6 +220,7 @@ for name in $what; do
> 
>      if [ "$type" = "osd" ]; then
>   get_conf osd_data "" "osd data"
> + get_conf osd_journal "" "osd journal"
>   get_conf keyring "" "keyring"
>   get_conf btrfs_path "$osd_data" "btrfs path"  # mount point defaults so
> osd data
>   get_conf btrfs_devs "" "btrfs devs"
> @@ -228,6 +229,7 @@ for name in $what; do
>   [ -n "$btrfs_opt" ] && btrfs_opt="-o $btrfs_opt"
> 
>   do_cmd "test -d $osd_data || mkdir -p $osd_data"
> + [ -n "$osd_journal" ] && do_cmd "test -d $osd_journal || mkdir -p `dirname
> $osd_journal`"
> 
>   if [ $mkbtrfs -eq 1 ]; then
>      get_conf osd_user "root" "user"
> -- 
> 1.7.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
