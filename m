From: Travis Rhoden <trhoden-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANN] ceph-deploy 1.5.28 released
Date: Wed, 26 Aug 2015 17:32:09 -0700
Message-ID: <CABcKxi_5kuzBhQPFGOz3j6Gb3iZXjASbvyQ3gTw5KBRpyabMPg@mail.gmail.com>
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi everyone,

A new version of ceph-deploy has been released. Version 1.5.28
includes the following:

 - A fix for a regression introduced in 1.5.27 that prevented
importing GPG keys on CentOS 6 only.
 - Will prevent Ceph daemon deployment on nodes that don't have Ceph
installed on them.
 - Makes it possible to go from 1 monitor daemon to 2 without a 5
minute hang/delay.
 - More systemd enablement work.


Full changelog is at [1].

Updated packages have been uploaded to
{rpm,debian}-{firefly,hammer,testing} repos on ceph.com, and to PyPI.

Cheers,

 - Travis

[1] http://ceph.com/ceph-deploy/docs/changelog.html#id2
