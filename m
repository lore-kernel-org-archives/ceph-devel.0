From: Dennis Chen <kernel.org.gnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Concurrent access of the object via Rados API...
Date: Tue, 17 Feb 2015 09:22:50 +0800
Message-ID: <CA+U0gVgPc76oaLaQka5WgeBEOWF3c+hjfpjtt7VBJs1FjkdgAA@mail.gmail.com>
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
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello,

For the case of multiple clients(separate process) accessing an object
in the cluster, is the exclusive protection of the shared object
needed for the caller?

Process A::rados::ioctx.write(obj, ...)
Process B::rados::ioctx.write(obj, ...)

or:

Process A::
    mylock.lock();
    ioctx.write(obj, ..)
    mylock.unlock()

Process B::
    mylock.lock();
    ioctx.write(obj, ..)
    mylock.unlock()

which one is correct?

-- 
Den
