From: Anthony Alba <ascanio.alba7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: OSD systemd unit files makes it look failed
Date: Fri, 21 Nov 2014 05:52:40 +0800
Message-ID: <CADkWibeG2=V95xEABM2e5Q8qVEAai1-do0Wi1nPzNa85OX8vdw@mail.gmail.com>
References: <CADkWibfOvOEr7cFcKNFmKBi+0-GhtXGVZrj3RQFqryC68Stcfg@mail.gmail.com>
	<alpine.DEB.2.00.1411200652250.2374@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1411200652250.2374-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

HI Sage, Cephers

(I'm not on ceph-devel at the moment, will switch in a moment.)

Thanks. I am testing on  RHEL7/CentOS 7. As quick workaround setting
the .service file to

[Service]
Type=forking
ExecStart= ceph-osd -i   #without --foreground)
ExecPreStart = ....

works for the moment . Is there a reason the daemons shouldn't run in
forking mode under systemd?

Both ceph-mon@.service and ceph-radosgw@.service (<== self-created
based on the ceph-mon@.service unit file) work with


Type=forking
ExecStart=path_to_daemon_no_foreground

or
#Type=simple
ExecStart=path_to_daemon --foreground

BTW do you want a pull requrest for ceph-radosgw@.service?

- Anthony
