From: Sage Weil <sage@newdream.net>
Subject: Re: users, 2.6.34
Date: Wed, 3 Mar 2010 14:54:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003031451250.1006@cobra.newdream.net>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
	<20100303011014.f4fb95b3.ctpm@ist.utl.pt>
	<261c158e1003030027p71278f92h5a4abd82b5ab6d57@mail.gmail.com>
	<Pine.LNX.4.64.1003031355290.1006@cobra.newdream.net>
	<261c158e1003031445k54caafd7i25ff6d0c70586328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <261c158e1003031445k54caafd7i25ff6d0c70586328@mail.gmail.com>
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
> make[2]: *** [/usr/src/modules/ceph/crypto.o] Error 1
> make[1]: *** [_module_/usr/src/modules/ceph] Error 2
> make[1]: Leaving directory `/usr/src/linux-headers-2.6.26-2-amd64'
> make: *** [all] Error 2
> xyz# pwd
> /usr/src/modules/ceph
> xyz#
> 
> Should that be config/crypto/hash.h ?
> 
> xyz# find /usr/src/linux-headers-2.6.26-2-common -name hash.h
> /usr/src/linux-headers-2.6.26-2-common/include/linux/hash.h

Oh, yeah, the backport #ifdefs only go back through 2.6.28 or so, sorry!  
You can get the latest kernel from debian sid...

> I did not, but I will! I started dragging my feet a little.
> 
> I had originally hoped I could try just the active object stuff using
> the beta hosted at DH. However, I will probably be more useful if I
> set up my own system so I will do that. But I would still use the beta
> if that's available too..

We're deploying the hardware now.  Loading the classes requires 
privileges, though, so we probably won't be loading any untested classes.  
You can start the system up just to test things with './vstart.sh -d -n' 
in ceph/src, though!

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
