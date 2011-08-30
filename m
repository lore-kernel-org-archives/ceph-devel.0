From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: userland nfs server
Date: Tue, 30 Aug 2011 18:07:59 -0400 (EDT)
Message-ID: <1255412388.94.1314742079622.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <Pine.LNX.4.64.1108301458300.16289@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([134.215.213.37]:2370 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165Ab1H3WIF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Aug 2011 18:08:05 -0400
In-Reply-To: <Pine.LNX.4.64.1108301458300.16289@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Yes, we're actively working on this.  We'd very much like assistance adapting the libceph changes for inclusion.  We can start by updating for recent Ceph.

FSAL_CEPH will definitely merge in Ganesha mainline in the next month or two.

Matt

----- "Sage Weil" <sage@newdream.net> wrote:

> Hi Matt,
> 
> On Fri, 29 Jul 2011, Matt W. Benjamin wrote:
> > Hi Sage,
> > 
> > We (Linux Box) have built and published a native FSAL for Ceph,
> which is 
> > pretty advanced, and we've submitted the FSAL driver code upstream
> for 
> > review Philippe Deniel.
> 
> Not sure if I said this before, but this is awesome!
> 
> > In addition, we're working on pNFS support in Ganesha and Ceph, and
> have 
> > a prototype file-based pNFS layout driver for the FSAL that takes 
> > advantage of Ceph OSDs for parallel IO.
> > 
> > We're actively extending these efforts and there should be some 
> > publication forthcoming.
> > 
> > We have an external git repository here:
> > 
> >     git://github.com/aemerson-linuxbox/ganesha.git
> 
> I just took a look at your ceph.git and it looks like there are
> several 
> changes you need to make to libceph.  It also looks like it's based on
> 
> v0.27 or thereabouts, which is pretty old now.  There seems to be a
> mix of 
> pretty simple/straighforward things that are easily merged upstream,
> and 
> some larger API additions that I have some questions about.
> 
> Are you guys actively working on this?  Can we work together to get
> these 
> libceph API changes merged into the mainline?  I would love to see
> this 
> run against the packaged libceph (and get the ceph FSAL upstream into
> 
> ganesha).
> 
> Thanks!
> sage
> 
> 
> 
> > 
> > We would really appreciate your feedback--and guidance on how to 
> > participate in Ceph, we'd like to.
> > 
> > Matt
> > 
> > ----- "Sage Weil" <sage@newdream.net> wrote:
> > 
> > > Has anyone looked at Genesha?
> > > 
> > > 	http://sourceforge.net/apps/trac/nfs-ganesha/
> > > 
> > > In principle it would probably be pretty straightforward to wire
> that
> > > up 
> > > to libceph and avoid the kernel NFS server for reexporting ceph
> via
> > > NFS...
> > > 
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
> > > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > 
> > -- 
> > 
> > Matt Benjamin
> > 
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> > 
> > http://linuxbox.com
> > 
> > tel. 734-761-4689
> > fax. 734-769-8938
> > cel. 734-216-5309
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Matt Benjamin

The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
