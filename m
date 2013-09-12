From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: many report failed after mon election
Date: Thu, 12 Sep 2013 21:37:42 +0200
Message-ID: <CAMNMNTwCMewLfTXsZHotCzqBy_sKFtCkqEjCt88-Z3O5Ta8bJw@mail.gmail.com>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
Today i have some issues with ceph cluster.
After new mon election many osd has been marked failed.
Some time later osd boot and i think recover because meny slow request appear.
Cluster come back after about 20minutes.

cluster:
ceph version 0.56.6
6 servers x 26 osd

2013-09-12 07:11:40.920384 mon.1 10.177.64.5:6789/0 353 : [INF] mon.3
calling new monitor election
2013-09-12 07:12:40.992532 mon.3 10.177.64.7:6789/0 364 : [INF] mon.4
calling new monitor election
2013-09-12 07:12:41.024954 mon.4 10.177.64.8:6789/0 360 : [INF] mon.2
calling new monitor election
2013-09-12 07:13:02.782203 mon.2 10.177.64.6:6789/0 336 : [INF] mon.1
calling new monitor election
2013-09-12 07:13:02.783778 mon.3 10.177.64.7:6789/0 366 : [INF] mon.4
calling new monitor election
2013-09-12 07:13:10.852842 mon.3 10.177.64.7:6789/0 367 : [INF] mon.4
calling new monitor election
2013-09-12 16:17:09.484277 mon.4 10.177.64.8:6789/0 363 : [INF] mon.2
calling new monitor election
2013-09-12 16:17:09.497337 mon.3 10.177.64.7:6789/0 368 : [INF] mon.4
calling new monitor election
2013-09-12 16:17:09.523787 mon.0 10.177.64.4:6789/0 4369021 : [INF]
mon.0 calling new monitor election
2013-09-12 16:17:14.525282 mon.0 10.177.64.4:6789/0 4369022 : [INF]
mon.0@0 won leader election with quorum 0,1,2,3,4
...
2013-09-12 16:17:14.689555 mon.0 10.177.64.4:6789/0 4369027 : [DBG]
osd.130 10.177.64.9:6801/1401 reported failed by osd.121
10.177.64.7:6909/29496
2013-09-12 16:17:14.689584 mon.0 10.177.64.4:6789/0 4369028 : [DBG]
osd.131 10.177.64.9:6810/2435 reported failed by osd.121
10.177.64.7:6909/29496
2013-09-12 16:17:14.689600 mon.0 10.177.64.4:6789/0 4369029 : [DBG]
osd.132 10.177.64.9:6846/2885 reported failed by osd.121
10.177.64.7:6909/29496
2013-09-12 16:17:14.689615 mon.0 10.177.64.4:6789/0 4369030 : [DBG]
osd.134 10.177.64.9:6855/3223 reported failed by osd.121
10.177.64.7:6909/29496
2013-09-12 16:17:14.689630 mon.0 10.177.64.4:6789/0 4369031 : [DBG]
osd.136 10.177.64.9:6865/3559 reported failed by osd.121
10.177.64.7:6909/29496
2013-09-12 16:17:14.689645 mon.0 10.177.64.4:6789/0 4369032 : [DBG]
osd.141 10.177.64.9:6904/4259 reported failed by osd.121
10.177.64.7:6909/29496

-- 
Pozdrawiam
Dominik
