From: Sage Weil <sage@newdream.net>
Subject: Re: v0.19 released
Date: Thu, 18 Feb 2010 09:44:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002180934280.29308@cobra.newdream.net>
References: <Pine.LNX.4.64.1002171440270.10839@cobra.newdream.net>
	<8atytevila.fsf@faepop01.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8atytevila.fsf@faepop01.tu-graz.ac.at>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Andreas Hirczy <ahi@itp.tugraz.at>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

On Thu, 18 Feb 2010, Andreas Hirczy wrote:

> Sage Weil <sage@newdream.net> writes:
> 
> > The v0.19 release is finally here.  The focus this past cycle was on 
> > ...
> >     * For Debian packages see http://ceph.newdream.net/wiki/Debian
> 
> Hi!
> 
> It seems the debian packages for "ceph-kclient-source" miss a
> Makefile. I transplanted one from the git repo; this works as outlined
> in <http://ceph.newdream.net/wiki/Building_kernel_client>, but not with
> "make-kpkg":

Oops, I've added the Makefile to the .deb.  I'm not familiar with 
make-kpkg, or how it can be used to build individual modules.. maybe 
someone else with more packaging experience can help there.

Thanks-
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
