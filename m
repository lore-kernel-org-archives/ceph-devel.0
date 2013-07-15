From: Andrey Korolyov <andrey-5vqebrSIFTo@public.gmane.org>
Subject: OSD crash upon pool creation
Date: Tue, 16 Jul 2013 02:24:40 +0400
Message-ID: <CABYiri84bM5G=ENVb0P8guE2qvuvxm3UiyKAYvi=Ld+CjdBHpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello,

Using db2bb270e93ed44f9252d65d1d4c9b36875d0ea5 I had observed some
disaster-alike behavior after ``pool create'' command - every osd
daemon in the cluster will die at least once(some will crash times in
a row after bringing back). Please take a look on the
backtraces(almost identical) below. Issue #5637 is created in the
tracker.

Thanks!

http://xdel.ru/downloads/poolcreate.txt.gz
http://xdel.ru/downloads/poolcreate2.txt.gz
