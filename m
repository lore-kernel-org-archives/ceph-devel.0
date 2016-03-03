From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ceph mon failed to restart
Date: Thu, 3 Mar 2016 14:00:31 +0530
Message-ID: <CANA9Uk7foqUXQkbVBerBdHothy91CzohWeW+NfYMdtaTqHXwOw@mail.gmail.com>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I have tried to restart the one of the ceph mon , got the below error:
==

2016-03-03 08:16:00.120355 7f43b067d7c0 -1 obtain_monmap unable to find a monmap

2016-03-03 08:16:00.120374 7f43b067d7c0 -1 unable to obtain a monmap:
(2) No such file or directory

2016-03-03 08:16:00.124437 7f43b067d7c0 -1 mon.node-11@-1(probing) e0
not in monmap and have been in a quorum before; must have been removed

2016-03-03 08:16:00.124715 7f43b067d7c0 -1 mon.node-11@-1(probing) e0
commit suicide!

2016-03-03 08:16:00.124727 7f43b067d7c0 -1 failed to initialize

failed: 'ulimit -n 32768;  /usr/bin/ceph-mon -i node-11 --pid-file
/var/run/ceph/mon.node-11.pid -c /etc/ceph/ceph.conf --cluster ceph '

Starting ceph-create-keys on node-11...
===

Any hint appriciated...

Thanks
Swami
