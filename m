From: Sage Weil <sage@newdream.net>
Subject: Re: only 9 of 54 osds are starting in latest unstable
Date: Mon, 19 Oct 2009 11:57:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0910191155040.17490@cobra.newdream.net>
References: <35e3bf740910170716ld2976dfo6b560ee2449ef32c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <35e3bf740910170716ld2976dfo6b560ee2449ef32c@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Brian Koebbe <koebbe@wustl.edu>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

On Sat, 17 Oct 2009, Brian Koebbe wrote:

> Hi Sage,
> When you get a chance....
> 
> I've got a 54 osd 3 mon 1 mds cluster running the latest unstable.  I filled
> it about 6% full, stopped everything and tried to restart it all.  All but 9
> osds are refusing to start with the following:

This was due to a regression introduced just before v0.16 (part of the 
pgid name was being parsed in hex instead of decimal).  This was probably 
affecting anyone with more than 10 osds (although it may not have 
been crashing outright).  It's fixed in the unstable repo, and I'll be 
doing a new release shortly.

Thanks!
sage



> 
> ./include/buffer.h: In function 'void buffer::ptr::copy_out(unsigned
> int, unsigned int, char*) const':
> ./include/buffer.h:413: FAILED assert(_raw)
>  1: /usr/bin/cosd [0x4a02bb]
>  2: /usr/bin/cosd(_Z6decodeRN2PG4InfoERN6buffer4list8iteratorE+0x2b) [0x5253db]
>  3: /usr/bin/cosd(_ZN2PG10read_stateEP11ObjectStore+0x154) [0x51d614]
>  4: /usr/bin/cosd(_ZN3OSD8load_pgsEv+0xe0) [0x4c45c0]
>  5: /usr/bin/cosd(_ZN3OSD4initEv+0x23f) [0x4d2baf]
>  6: /usr/bin/cosd(main+0xf75) [0x44ed35]
>  7: /lib/libc.so.6(__libc_start_main+0xe6) [0x7fb7fdf385a6]
>  8: /usr/bin/cosd [0x44dae9]
> 
> 
> osd log:
> http://cgs.wustl.edu/~koebbe/osd.log
> 
> backtrace:
> http://cgs.wustl.edu/~koebbe/back
> 
> ceph osd dump:
> 
> http://cgs.wustl.edu/~koebbe/osd.dump
> 
> Let me know if you need any more info.
> Thanks,
> Brian
> 

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
