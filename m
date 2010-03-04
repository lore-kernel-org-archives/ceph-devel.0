From: Sage Weil <sage@newdream.net>
Subject: Re: users, 2.6.34
Date: Thu, 4 Mar 2010 08:21:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003040818330.28379@cobra.newdream.net>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
	<20100303011014.f4fb95b3.ctpm@ist.utl.pt>
	<261c158e1003030027p71278f92h5a4abd82b5ab6d57@mail.gmail.com>
	<Pine.LNX.4.64.1003031355290.1006@cobra.newdream.net>
	<261c158e1003031445k54caafd7i25ff6d0c70586328@mail.gmail.com>
	<Pine.LNX.4.64.1003031451250.1006@cobra.newdream.net>
	<261c158e1003031537q20d98c3fy73c086e4337ac484@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <261c158e1003031537q20d98c3fy73c086e4337ac484@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Jack Culpepper <jackculpepper@gmail.com>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

On Wed, 3 Mar 2010, Jack Culpepper wrote:
> > Oh, yeah, the backport #ifdefs only go back through 2.6.28 or so, sorry!
> > You can get the latest kernel from debian sid...
> 
> Ok, I have to rebuild the kernel anyways to apply your two patches,
> right? Those are still necessary?

You probably won't hit those bugs with single client testing, but strictly 
speaking they're still there.  (Hopefully they'll finally get into .34.)  
I'd try things without the patches, and deal with applying them if you run 
into problems.

> I changed lenny to sid in my /etc/apt/sources.list , then ran apt-get
> update, apt-get upgrade.
> 
> Now I have kernel 2.6.32 and I'm following section 4.2 from the debian
> linux kernel handbook. After this is done I should be ready to apply
> your two kernel patches, right?

Sounds like it?  I'm not that familiar with debian's kernel building 
toolchain.  :)

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
