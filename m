From: Sage Weil <sage@newdream.net>
Subject: Re: [RFC] v2 separate otw data from host data
Date: Fri, 6 Nov 2009 12:49:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911061245270.15146@cobra.newdream.net>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
	<3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052224121.24285@cobra.newdream.net>
	<1826697A-2DAB-4532-99B1-E1247AFDAD64@soe.ucsc.edu>
	<Pine.LNX.4.64.0911061138560.15146@cobra.newdream.net>
	<AF9F8769-3573-40CE-B786-433CD60245DE@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <AF9F8769-3573-40CE-B786-433CD60245DE@soe.ucsc.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Noah Watkins <noah@noahdesu.com>, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Fri, 6 Nov 2009, Noah Watkins wrote:

> > - should use 'wire' instead of 'otw' consistently?
> Up vote from me. I like 'wire' better than 'otw'.
> 
> > - the layout validation func is used by userspace, and should  
> > eventually
> > be used by the kclient
> Ahh, I'll restore this. And ceph_ioctl_set_layout does some basic  
> layout validation. These could be merged?

Yes please :)

> > - lost the comments on the struct in ceph_fs.h
> I bumped the inline comments to a block comment above the struct. Or  
> did you mean 'lose them' instead of 'lost' ?

Oh right.  Let's keep them inline.

> >> Looking over it again, perhaps just using some accessor macros is  
> >> the best.
> >
> > Yeah...  Well, at some point we should probably add a 'wire' suffix
> > (prefix?) to all the disk/wire types, though.  (I'll stick that in the
> > TODO.  It needs to be coordinated with the userspace change.)  This  
> > can
> > come after?
> If this is overall a step in the right direction then starting with  
> this patch, and re-visiting the topic as a larger iterative clean-up  
> seems reasonable.
> 
> This brings up a good point about the level at which nested  
> structures are labeled as 'wire'. For example, ceph_mds_reply_inode  
> is a struct that should be labeled as 'wire', but it would be ugly to  
> label all members of that struct as 'wire'.

The type naming should be consistent.  ceph_wire_ prefix?

sage

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
