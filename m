From: Sage Weil <sage@newdream.net>
Subject: Re: bug report: ceph: && vs ||
Date: Sat, 20 Mar 2010 20:59:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003202058140.15445@cobra.newdream.net>
References: <20100320123926.GA30085@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100320123926.GA30085@bicker>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <error27@gmail.com>
Cc: ceph-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sat, 20 Mar 2010, Dan Carpenter wrote:
> 
> 
>   1772          /* correct session? */
>   1773          if (!req->r_session && req->r_session != session) {
> 
> 	Is this supposed to || here?  We know "session" is non-NULL at
> 	the point because we already dereferenced it.  If "req->r_session"
> 	is null then the second condition is always true.
> 
> 	Also we dereference "req->r_session" later on without checking.

Yeah, that check is clearly wrong.  A

	if (req->r_session != session) {

is sufficient because the passed session is always non-NULL.  Applied a 
fix.

Thanks-
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
