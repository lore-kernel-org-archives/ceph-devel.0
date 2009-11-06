From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [RFC] separate otw data from host data
Date: Thu, 5 Nov 2009 22:09:51 -0800
Message-ID: <3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <noah@noahdesu.com>, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

> With the caveat that the performance advantages here are pretty  
> minimal
> (most users are little endian, struct is i think already aligned),  
> this
> does clean things up a bit.
Yeah, it probably is aligned in its current form. Extending structs  
in the future
might alter their aligned-by-chance factor, and separating the OTW/ 
internal
types will avoid this. I don't know what performance degradation due to
unaligned memory accesses feels like, but certainly in the case of  
file layout
information, it may be the most accessed Ceph data?
(mapping calculation done for every access).

> I wouldn't change the types ceph_fs.[ch], msgr.h, rados.h if you  
> can...
> these are all OTW types and shared between kernel and user space.   
> Maybe
> make __ceph_file_layout the internal type.
I'll migrate the internal types to a new location. Any suggestion? If  
this is the only
case of internal/OTW types then a new header is probably overkill.

> Maybe lose the fl_ prefix to
> catch accidental misuse.
Sure

>
> Are there other types you were looking at?  I think most others are  
> in the
> decode/use once category anyway?
In general I think the internal/OTW type separation is appropriate  
for all instances that
it applies to, if nothing but to help readability, but especially for  
easing future extensions.
I think about it as a separation between core-Ceph and Ceph's user- 
space interface (OTW and IOCTL).

I haven't done a survey of other similar instances, but a quick grep  
shows a large amount
of endianess conversions, and so the potential for a bit of clean-up.

Thoughts?

-n


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
