From: Sage Weil <sage@newdream.net>
Subject: Re: userland nfs server
Date: Tue, 30 Aug 2011 15:02:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108301458300.16289@cobra.newdream.net>
References: <1843323934.77.1311957032511.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51786 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab1H3V5p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Aug 2011 17:57:45 -0400
In-Reply-To: <1843323934.77.1311957032511.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel@vger.kernel.org

Hi Matt,

On Fri, 29 Jul 2011, Matt W. Benjamin wrote:
> Hi Sage,
> 
> We (Linux Box) have built and published a native FSAL for Ceph, which is 
> pretty advanced, and we've submitted the FSAL driver code upstream for 
> review Philippe Deniel.

Not sure if I said this before, but this is awesome!

> In addition, we're working on pNFS support in Ganesha and Ceph, and have 
> a prototype file-based pNFS layout driver for the FSAL that takes 
> advantage of Ceph OSDs for parallel IO.
> 
> We're actively extending these efforts and there should be some 
> publication forthcoming.
> 
> We have an external git repository here:
> 
>     git://github.com/aemerson-linuxbox/ganesha.git

I just took a look at your ceph.git and it looks like there are several 
changes you need to make to libceph.  It also looks like it's based on 
v0.27 or thereabouts, which is pretty old now.  There seems to be a mix of 
pretty simple/straighforward things that are easily merged upstream, and 
some larger API additions that I have some questions about.

Are you guys actively working on this?  Can we work together to get these 
libceph API changes merged into the mainline?  I would love to see this 
run against the packaged libceph (and get the ceph FSAL upstream into 
ganesha).

Thanks!
sage



> 
> We would really appreciate your feedback--and guidance on how to 
> participate in Ceph, we'd like to.
> 
> Matt
> 
> ----- "Sage Weil" <sage@newdream.net> wrote:
> 
> > Has anyone looked at Genesha?
> > 
> > 	http://sourceforge.net/apps/trac/nfs-ganesha/
> > 
> > In principle it would probably be pretty straightforward to wire that
> > up 
> > to libceph and avoid the kernel NFS server for reexporting ceph via
> > NFS...
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> 
> Matt Benjamin
> 
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel. 734-761-4689
> fax. 734-769-8938
> cel. 734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
