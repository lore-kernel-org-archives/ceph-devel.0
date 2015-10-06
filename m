From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Potential OSD deadlock?
Date: Tue, 6 Oct 2015 09:40:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510060939340.32037@cobra.newdream.net>
References: <CAANLjFpAXaDWQzumg1hCs=SC_0YvdYDd6vyodz5_ZBNvGWdkSw@mail.gmail.com>
	<alpine.DEB.2.00.1509221450490.11876@cobra.newdream.net>
	<CAANLjFoK4O-3GB_1b40xp-5RtbZhdSXJT5+ydUDX+dq=dBHR8w@mail.gmail.com>
	<CAANLjFrrAyhJ=JR0+K3SX6G1ZsdcUyhTqFzUn_A0+bSh0D=bkA@mail.gmail.com>
	<5602F921.3010204@redhat.com>
	<CAANLjFqTW3750rw6zCnNfcD41GjYxer05m--JAWx-YLnaxcg-Q@mail.gmail.com>
	<CAANLjFrw0AtqvHu5ioRPH7yKjV5ZqfnGKou+fKLTZukLTnLbgw@mail.gmail.com>
	<CAANLjFoafHQ1X8U7LUrvhh2h8fu3WgNpUsMDR+QkSWpfW8ad0g@mail.gmail.com>
	<alpine.DEB.2.00.1510040646020.5233@cobra.newdream.net>
	<CAANLjFqgJbLEsBYEW=bk0h+Lmop-MLX=eA7qx98h-3Z6M1x7_Q@mail.gmail.com>
	<CAANLjFruw-1yySqO=aY05c0bzuqdkBH0-WcKmyP_+JtSyA1kpQ@mail.gmail.com>
	<alpine.DEB.2.00.1510060534010.32037@cobra.newdream.net>
	<CAANLjFo==i7wivrGR9LJFs3GOrD2iQHLdCpEfR-AruHyOMLi-w@mail.gmail.com>
	<alpine.DEB.2.00.1510060737480.32037@cobra.newdream.net>
	<CALqRxCw=tV5h-xfaxsCwwqhK=zLiP=m_iGTn+dF0Op=Uth_vPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALqRxCw=tV5h-xfaxsCwwqhK=zLiP=m_iGTn+dF0Op=Uth_vPA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Tue, 6 Oct 2015, Ken Dreyer wrote:
> On Tue, Oct 6, 2015 at 8:38 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Oh.. I bet you didn't upgrade the osds to 0.94.4 (or latest hammer build)
> > first.  They won't be allowed to boot until that happens... all upgrades
> > must stop at 0.94.4 first.
> 
> This sounds pretty crucial. is there Redmine ticket(s)?

It's documented in the (draft) release notes, which discuss how to 
upgrade.  There's no bug...

sage
