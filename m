From: Zach Brown <zab@zabbo.net>
Subject: Re: [RFC] separate otw data from host data
Date: Fri, 06 Nov 2009 09:47:35 -0800
Message-ID: <4AF46137.2050604@zabbo.net>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>	<Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>	<3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052224121.24285@cobra.newdream.net>
Mime-Version: 1.0
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


> My biggest concern with all of this is really just that the type names 
> don't clearly indicate which ones are OTW and which aren't.  The most 
> helpful cleanup may just be to include _otw_ or something similar in the 
> ceph_fs/msgr/rados headers.  (Though it's really on-disk and/or 
> over-the-wire.)  

In the past I've used _disk or _wire suffixes in various projects.  It
works out pretty well, I think.

- z

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
