From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [RFC] v2 separate otw data from host data
Date: Fri, 6 Nov 2009 12:19:22 -0800
Message-ID: <7FABE1C3-4511-4297-B0CF-BB33EFADF958@soe.ucsc.edu>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
	<3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052224121.24285@cobra.newdream.net>
	<1826697A-2DAB-4532-99B1-E1247AFDAD64@soe.ucsc.edu>
	<Pine.LNX.4.64.0911061138560.15146@cobra.newdream.net>
	<AF9F8769-3573-40CE-B786-433CD60245DE@soe.ucsc.edu>
	<a37615150911061208m2957b648hf99d11820bfefe6c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a37615150911061208m2957b648hf99d11820bfefe6c@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@lists.sourceforge.net, Noah Watkins <noah@noahdesu.com>
List-Id: ceph-devel.vger.kernel.org

> personally I prefer seeing those inline on the struct. That way one  
> feels the obligation to update the comments whenever the struct is  
> changed, and it is faster reading through the code.
I agree. I thought I had been noticing a trend of the block commented  
structs in other kernel code, but there is nothing about it in the  
coding style document. Reverted.
-n

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
