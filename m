From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Don't crash during initialization when working without
 an osd journal.
Date: Thu, 7 Apr 2011 14:40:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104071440420.18507@cobra.newdream.net>
References: <ortyeayxvm.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46679 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab1DGVh1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 17:37:27 -0400
In-Reply-To: <ortyeayxvm.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

sage


On Thu, 7 Apr 2011, Alexandre Oliva wrote:

> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/os/FileStore.cc |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
> index 940662c..0fb99e6 100644
> --- a/src/os/FileStore.cc
> +++ b/src/os/FileStore.cc
> @@ -1471,7 +1471,8 @@ void FileStore::start_logger(int whoami, utime_t tare)
>    char name[80];
>    snprintf(name, sizeof(name), "osd.%d.fs.log", whoami);
>    logger = new ProfLogger(name, (ProfLogType*)&fs_logtype);
> -  journal->logger = logger;
> +  if (journal)
> +    journal->logger = logger;
>    logger_add(logger);  
>    logger_tare(tare);
>    logger_start();
> @@ -1481,7 +1482,8 @@ void FileStore::stop_logger()
>  {
>    dout(10) << "stop_logger" << dendl;
>    if (logger) {
> -    journal->logger = NULL;
> +    if (journal)
> +      journal->logger = NULL;
>      logger_remove(logger);
>      delete logger;
>      logger = NULL;
> -- 
> 1.7.4.2
> 
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
