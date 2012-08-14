From: Sage Weil <sage@inktank.com>
Subject: Re: Search for srcdir/.git in check_version
Date: Tue, 14 Aug 2012 08:57:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208140857160.18862@cobra.newdream.net>
References: <orboieypq9.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54877 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2HNP5e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 11:57:34 -0400
In-Reply-To: <orboieypq9.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Applied to next branch (will become v0.51).

On Tue, 14 Aug 2012, Alexandre Oliva wrote:

> Support srcdir != . looking for .git in srcdir when computing the ceph
> release and git tag.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/check_version |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/check_version b/src/check_version
> index e31ca49..8600c55 100755
> --- a/src/check_version
> +++ b/src/check_version
> @@ -1,12 +1,13 @@
>  #!/bin/sh
>  
> -if [ ! -d ../.git ]; then
> -    echo "not updating .git_version (no ../.git)"
> +dname=`dirname $0`
> +
> +if [ ! -d $dname/../.git ]; then
> +    echo "not updating .git_version (no $dname/../.git)"
>      exit 0
>  fi
>  
> -dname=`dirname $0`
> -cur=`git rev-parse HEAD 2>/dev/null; git describe 2>/dev/null`
> +cur=`cd $dname && git rev-parse HEAD 2>/dev/null; git describe 2>/dev/null`
>  [ -e $1 ] && old=`cat $1`
>  
>  if [ "$cur" != "$old" ]; then
> -- 
> 1.7.7.6
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
