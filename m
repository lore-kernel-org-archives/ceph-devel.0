From: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Subject: qemu jemalloc support soon in master (applied in paolo
 upstream branch)
Date: Tue, 8 Sep 2015 12:58:15 +0200 (CEST)
Message-ID: <1583693791.33394679.1441709895629.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

Paolo Bonzini from qemu team has finally applied my qemu jemalloc patch 
in his for-upstream branch

https://github.com/bonzini/qemu/releases/tag/for-upstream
https://github.com/bonzini/qemu/tree/for-upstream

So,It'll be in qemu master soon and ready for qemu 2.5


I have write some small benchmark results with librbd in the commit itself
https://github.com/bonzini/qemu/commit/efc1e9f08020cd460eb2204e3092b39e408e1fa9


you simply need to compile qemu with --enable-jemalloc, to enable jemmaloc support.

Regards,

Alexandre
