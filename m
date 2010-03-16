From: Christian Brunner <chb@muc.de>
Subject: Re: Unexpected rmpool behavior
Date: Tue, 16 Mar 2010 20:48:39 +0100
Message-ID: <20100316194839.GB97732@ncolin.muc.de>
References: <20100314162323.GA83257@ncolin.muc.de>
	<1471eea71003142229t30045d3bgdfd0529e995677fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1471eea71003142229t30045d3bgdfd0529e995677fb@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Mon, Mar 15, 2010 at 05:29:38AM +0000, Gregory Farnum wrote:
> Christian:
> I've just tested this and it sure looks to me like deleting a pool
> deletes the objects in it. It's not necessarily instantaneous, though
> -- stuff won't get deleted until the OSD gets a new OSDMap.
> Try writing something (which will generally put new maps on all the
> OSDs involved) and see if the pool and its contents disappear from the
> OSD then. :)
> -Greg

OK - I'm sorry. I was just to impatient. I did an rmpool and saw that the space was not freed immediately.

Christian


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
