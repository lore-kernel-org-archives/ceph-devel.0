From: Sage Weil <sage@newdream.net>
Subject: Re: [RFC] separate otw data from host data
Date: Thu, 5 Nov 2009 22:37:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911052224121.24285@cobra.newdream.net>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
	<3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
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

> > With the caveat that the performance advantages here are pretty minimal
> > (most users are little endian, struct is i think already aligned), this
> > does clean things up a bit.
> Yeah, it probably is aligned in its current form. Extending structs in the
> future
> might alter their aligned-by-chance factor, and separating the OTW/internal
> types will avoid this. I don't know what performance degradation due to
> unaligned memory accesses feels like, but certainly in the case of file layout
> information, it may be the most accessed Ceph data?
> (mapping calculation done for every access).

Right, just keep in mind swabbing these few bytes is nothing in comparison 
to the other work required per I/O.. allocating and filling out a request 
struct, on-wire message, sending a pile of data over the wire, waiting for 
ack, etc.  This is really about code readability, not speed.

> > I wouldn't change the types ceph_fs.[ch], msgr.h, rados.h if you can...
> > these are all OTW types and shared between kernel and user space.  Maybe
> > make __ceph_file_layout the internal type.
> I'll migrate the internal types to a new location. Any suggestion? If this is
> the only
> case of internal/OTW types then a new header is probably overkill.
> 
> > Maybe lose the fl_ prefix to
> > catch accidental misuse.
> Sure
> 
> > 
> > Are there other types you were looking at?  I think most others are in the
> > decode/use once category anyway?
> In general I think the internal/OTW type separation is appropriate for all
> instances that
> it applies to, if nothing but to help readability, but especially for easing
> future extensions.
> I think about it as a separation between core-Ceph and Ceph's user-space
> interface (OTW and IOCTL).
> 
> I haven't done a survey of other similar instances, but a quick grep shows a
> large amount
> of endianess conversions, and so the potential for a bit of clean-up.

Yeah, but like I said, they mostly all live in the message handlers that 
are in the business of decoding the on-wire structs.  The layout struct is 
pretty much the only one that is kept around in its prior form (swabbed or 
not).  The only other exception is in messenger.c itself, which is working 
with the request headers directly, but again I'm not sure how much it will 
improve readability.

My biggest concern with all of this is really just that the type names 
don't clearly indicate which ones are OTW and which aren't.  The most 
helpful cleanup may just be to include _otw_ or something similar in the 
ceph_fs/msgr/rados headers.  (Though it's really on-disk and/or 
over-the-wire.)  

I suspect that's the way to go?  It'd also avoid a type called 
__ceph_file_layout, which isn't particularly obvious.  I've been using __ 
throughout to mean something like "I'm already holding the relevant 
lock(s)" but that's not much better (tho hopefully it's at least pretty 
consistent).

sage

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
