From: Sage Weil <sage@newdream.net>
Subject: Re: kvm driver
Date: Tue, 9 Mar 2010 15:05:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003091502070.32679@cobra.newdream.net>
References: <20100308054150.GA40223@ncolin.muc.de>
	<Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
	<20100309210038.GA50616@ncolin.muc.de>
	<20100309223114.GA50990@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100309223114.GA50990@ncolin.muc.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Tue, 9 Mar 2010, Christian Brunner wrote:

> > > Yehuda is taking a look at it now.  The signals are used to wake up 
> > > blocking read()/write()/connect(), but we should be able to use poll() or 
> > > select() instead (and clean things up in the process).
> > 
> > Great! - That was really a quick response. I will check out the current
> > git version tomorrow and will give it a try.
> 
> I couldn't resist to try it today. I had to make a minor change regarding
> pthread handling. Now everything seems to work well. An updated patch
> is attached. - Thanks for the quick solution.

Oh, I see the issue.  I changed the Ceph Thread class to mask signals on 
any new threads it creates, so you shouldn't need to worry about it all 
anymore.  (I think you got lucky before: librados does create threads for 
connecting to servers as it needs them, and those signals weren't getting 
masked.)

> I haven't changed the naming scheme yet. I will do this in a few days.

Sounds good.

Thanks!
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
