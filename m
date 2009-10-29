From: Sage Weil <sage@newdream.net>
Subject: Re: (no subject)
Date: Wed, 28 Oct 2009 17:42:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0910281731450.27853@cobra.newdream.net>
References: <D32A0D11-5C03-401C-B165-2F067F04B2EA@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <D32A0D11-5C03-401C-B165-2F067F04B2EA@soe.ucsc.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: noah@noahdesu.com, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Wed, 28 Oct 2009, Noah Watkins wrote:

> Sage,
> 
> A few changes you might be interested in:
> 
> You can pull from:
> 
>       http://code.noahdesu.com/git/ceph-client-standalone.git/ for-sage

Applied.

>        ceph: add 'tags' to .gitignore

This one belongs in ceph-client-standalone.git...

>        ceph: replace list_entry with container_of
>        ceph: remove redundant use of le32_to_cpu

but in the future, can you apply these to a ceph-client.git tree?  The 
-standalone repo is entirely slaved off the main repo with some bash 
scripts.

Thanks!
sage


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
