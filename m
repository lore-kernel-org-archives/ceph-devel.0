From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Fix ceph-mds --journal-reset
Date: Wed, 22 Feb 2012 21:51:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202222150230.27988@cobra.newdream.net>
References: <oripj01ri9.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45050 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab2BWFvW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 00:51:22 -0500
In-Reply-To: <oripj01ri9.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Hey-

Can you look at the wip-mds-resetter branch?  I think that is closer to 
the correct locking.  We need to hold the mutex for ms_dispatch (teh calls 
into objecter in particular), and to drop it when we block...

Thanks!
sage

On Tue, 21 Feb 2012, Alexandre Oliva wrote:

> Complete configuration initialization for special actions, and
> hold Resetter lock while running reset.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/ceph_mds.cc     |    1 +
>  src/mds/Resetter.cc |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/src/ceph_mds.cc b/src/ceph_mds.cc
> index acd88d2..23fafaf 100644
> --- a/src/ceph_mds.cc
> +++ b/src/ceph_mds.cc
> @@ -65,6 +65,7 @@ void usage()
>  static int do_cmds_special_action(const std::string &action,
>  				  const std::string &dump_file, int rank)
>  {
> +  common_init_finish(g_ceph_context);
>    SimpleMessenger *messenger = new SimpleMessenger(g_ceph_context);
>    int r = messenger->bind(g_conf->public_addr, getpid());
>    if (r < 0)
> diff --git a/src/mds/Resetter.cc b/src/mds/Resetter.cc
> index a10845c..f759881 100644
> --- a/src/mds/Resetter.cc
> +++ b/src/mds/Resetter.cc
> @@ -83,6 +83,7 @@ void Resetter::reset()
>    bool done;
>    int r;
>  
> +  this->lock.Lock();
>    lock.Lock();
>    journaler->recover(new C_SafeCond(&lock, &cond, &done, &r));
>    while (!done)
> @@ -142,5 +143,6 @@ void Resetter::reset()
>  
>    cout << "done" << std::endl;
>  
> +  this->lock.Unlock();
>    shutdown();
>  }
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
