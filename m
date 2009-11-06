From: Sage Weil <sage@newdream.net>
Subject: Re: [RFC] separate otw data from host data
Date: Thu, 5 Nov 2009 21:33:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
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

On Thu, 5 Nov 2009, Noah Watkins wrote:

> Sage
> 
> A large number of le32_to_cpu (and the like) are used throughout the kernel
> client when referencing packed structs that are used OTW. However, I'd argue
> conversion should be done in only two places: before being sent or received.
> This allows non-packed versions of structs to be used only on the local
> machine, and use optimized alignment determined by gcc. Additionally it
> de-clutters the code of all the conversion routines. The patch I attached (not
> ready for use) demonstrates this for struct ceph_file_layout by introducing
> struct __ceph_file_layout for OTW, and does conversion only before sending or
> receiving over the network.
> 
> Comments, suggestions?

With the caveat that the performance advantages here are pretty minimal 
(most users are little endian, struct is i think already aligned), this 
does clean things up a bit.

I wouldn't change the types ceph_fs.[ch], msgr.h, rados.h if you can... 
these are all OTW types and shared between kernel and user space.  Maybe 
make __ceph_file_layout the internal type.  Maybe lose the fl_ prefix to 
catch accidental misuse.

Are there other types you were looking at?  I think most others are in the 
decode/use once category anyway?

sage

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
