From: Sage Weil <sage@newdream.net>
Subject: Re: (no subject)
Date: Wed, 28 Oct 2009 20:12:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0910282010310.27853@cobra.newdream.net>
References: <D32A0D11-5C03-401C-B165-2F067F04B2EA@soe.ucsc.edu>
	<Pine.LNX.4.64.0910281731450.27853@cobra.newdream.net>
	<F645251D-3111-4389-8F93-E685944C00DF@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <F645251D-3111-4389-8F93-E685944C00DF@soe.ucsc.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Wed, 28 Oct 2009, Noah Watkins wrote:

> > 
> > This one belongs in ceph-client-standalone.git...
> > 
> > >       ceph: replace list_entry with container_of
> > >       ceph: remove redundant use of le32_to_cpu
> 
> All three patches were against ceph-client-standalone.git. You want them
> re-submitted against ceph-client.git ?

No worries, I fixed these up and applied them.

The -standalone.git has a pull.sh and tries to mirror the git history for 
just commits affecting fs/ceph/.  A backport.sh maintains the backport 
branch.  There're not much use to anyone unless I forget to update 
-standalone.git and you want to pull the latest from the main repo.

sage

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
