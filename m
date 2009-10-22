From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: _XOPEN_SOURCE redefined
Date: Thu, 22 Oct 2009 10:59:24 -0700 (PDT)
Message-ID: <2124777445.2161201256234364994.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

Sage, I'm getting this redefinition warning on a new box.
Should there be an:

#undef _XOPEN_SOURCE in ./include/buffer.h before Ceph's new definition?

-n

g++-4.3 -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT ExportControl.o -MD -MP -MF .deps/ExportControl.Tpo -c -o ExportControl.o `test -f 'auth/ExportControl.cc' || echo './'`auth/ExportControl.cc
In file included from ./include/cstring.h:12,
                 from ./include/nstring.h:8,
                 from ./include/object.h:28,
                 from ./include/types.h:53,
                 from ./msg/msg_types.h:18,
                 from ./config.h:32,
                 from auth/ExportControl.h:5,
                 from auth/ExportControl.cc:16:
./include/buffer.h:18:1: warning: "_XOPEN_SOURCE" redefined
In file included from /usr/include/c++/4.3/x86_64-linux-gnu/bits/os_defines.h:44,
                 from /usr/include/c++/4.3/x86_64-linux-gnu/bits/c++config.h:40,
                 from /usr/include/c++/4.3/bits/stl_algobase.h:65,
                 from /usr/include/c++/4.3/bits/stl_tree.h:67,
                 from /usr/include/c++/4.3/map:65,
                 from auth/ExportControl.h:4,
                 from auth/ExportControl.cc:16:
/usr/include/features.h:160:1: warning: this is the location of the previous definition

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
