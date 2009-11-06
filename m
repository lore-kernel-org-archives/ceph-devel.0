From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [RFC] separate otw data from host data
Date: Thu, 5 Nov 2009 23:31:19 -0800
Message-ID: <3A366FD6-AFBA-4932-9693-575A683AA207@soe.ucsc.edu>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
	<3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052224121.24285@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0911052224121.24285@cobra.newdream.net>
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

> I suspect that's the way to go?  It'd also avoid a type called
> __ceph_file_layout, which isn't particularly obvious.
Good point, i'll make another pass on this, and we'll see how it
looks.

I've been motivated to clean-up some of the file layout and object  
mapping
code in the client because I've been thinking a lot about the idea of  
generalized
mappings, that go beyond the object/stripe paradigm, and perhaps have  
non-uniform
layouts determined programmatically on a per-file basis. There are  
lot of other issues...hah.

>  I've been using __
> throughout to mean something like "I'm already holding the relevant
> lock(s)" but that's not much better (tho hopefully it's at least  
> pretty
> consistent).
Yeh, that's pretty common practice. Using _otw_ is worth looking at, but
there probably isn't a really great way to solve it in the long run.  
Just look
at the mini-summit at Japan Linux Symposium that Thomas Gleixner held
for the single purpose of naming spinlock variants in the -rt patch.

I've been hacking on stuff as I run across it, but do you have bug  
tracker
or to-do lists online?

-n


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
