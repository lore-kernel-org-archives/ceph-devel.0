From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Unexpected rmpool behavior
Date: Sun, 14 Mar 2010 22:29:38 -0700
Message-ID: <1471eea71003142229t30045d3bgdfd0529e995677fb@mail.gmail.com>
References: <20100314162323.GA83257@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100314162323.GA83257@ncolin.muc.de>
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

Christian:
I've just tested this and it sure looks to me like deleting a pool
deletes the objects in it. It's not necessarily instantaneous, though
-- stuff won't get deleted until the OSD gets a new OSDMap.
Try writing something (which will generally put new maps on all the
OSDs involved) and see if the pool and its contents disappear from the
OSD then. :)
-Greg

On Sun, Mar 14, 2010 at 9:23 AM, Christian Brunner <chb@muc.de> wrote:
> I've just noticed that "rados rmpool" does not remove the contents of the
> pool. I would have expected that the objects in the pool are deleted when
> the pool is removed. - This is probably something for the TODO list.
>
> Christian
> --
> Christian Brunner
>
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
