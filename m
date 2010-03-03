From: Sage Weil <sage@newdream.net>
Subject: Re: users, 2.6.34
Date: Wed, 3 Mar 2010 13:59:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003031355290.1006@cobra.newdream.net>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
	<20100303011014.f4fb95b3.ctpm@ist.utl.pt>
	<261c158e1003030027p71278f92h5a4abd82b5ab6d57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <261c158e1003030027p71278f92h5a4abd82b5ab6d57@mail.gmail.com>
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
> Hey Sager! I am coming off the sidelines! :) I have been poking
> through the code for a while but just tried installing for the first
> time. Brand new clean debian 5.0.4 installation. The first issue is
> the "unauthenticated package" thing, does everyone just hit "y" here?

Yeah, the packages aren't signed by a trusted debian gpg key.

> Hmm, something's weird. No makefile! Also, the README has zero bytes.
> [...]
> Maybe a packaging goof?

Yeah, I forgot to backport the debian/rules fix to the stable branch.  
I uploaded fixed packages.

Did you ever try out the active object stuff?

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
