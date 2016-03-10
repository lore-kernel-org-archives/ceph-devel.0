From: Shinobu Kinjo <shinobu.kj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: New added OSD always down when full flag of osdmap
 is set
Date: Thu, 10 Mar 2016 11:49:38 +0900
Message-ID: <CAFdRU70zv2_g3c5fjYQA1Q0xu1sL0hGsiO2jpt9BDHZfDgKqGg@mail.gmail.com>
References: <56E0DDE6.1040807@gmail.com>
Reply-To: skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <56E0DDE6.1040807-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: hzwulibin <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Mar 10, 2016 at 11:37 AM, hzwulibin <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi, cephers
>
> Recently, i found we could not add new osd in cluster when the full flag is set in osdmap.
>
> Shortly describe the scene here:
> 1. Some osd are full, and the osdmap has full flag

Are those OSDs usage really 100% which is not expected?

> 2. Add new osd
> 3. New osd service is running, but it's state always down
>
> Here is the issue:
> http://tracker.ceph.com/issues/15025
>
> Anyone know it's a normal way or a bug here?
>
> --------------
> hzwulibin
> 2016-03-10
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Email:
shinobu-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org
GitHub:
shinobu-x
Blog:
Life with Distributed Computational System based on OpenSource
