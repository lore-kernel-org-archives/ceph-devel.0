From: Sage Weil <sage@inktank.com>
Subject: Re: linux-next: Tree for Aug 27 (ceph)
Date: Tue, 27 Aug 2013 12:29:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308271229230.24783@cobra.newdream.net>
References: <20130827203008.1c54283d628ef706f51a866a@canb.auug.org.au> <521CF7D6.5090807@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <521CF7D6.5090807@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, 27 Aug 2013, Randy Dunlap wrote:
> On 08/27/13 03:30, Stephen Rothwell wrote:
> > Hi all,
> > 
> > I should know better than to take time off around -rc7 :-)
> > 
> > Changes since 20130822:
> > 
> 
> on i386:
> 
> fs/built-in.o: In function `ceph_fallocate':
> file.c:(.text+0x20b171): undefined reference to `__divdi3'

I've fixed this up in the ceph tree.

Thanks!
sage
 
