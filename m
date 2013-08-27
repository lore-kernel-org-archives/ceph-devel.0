From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Aug 27 (ceph)
Date: Tue, 27 Aug 2013 12:02:46 -0700
Message-ID: <521CF7D6.5090807@infradead.org>
References: <20130827203008.1c54283d628ef706f51a866a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130827203008.1c54283d628ef706f51a866a@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 08/27/13 03:30, Stephen Rothwell wrote:
> Hi all,
> 
> I should know better than to take time off around -rc7 :-)
> 
> Changes since 20130822:
> 

on i386:

fs/built-in.o: In function `ceph_fallocate':
file.c:(.text+0x20b171): undefined reference to `__divdi3'


-- 
~Randy
