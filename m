From: Giridhar Yasa <giridhar.yasa-ay2nrczjKqVWk0Htik3J/w@public.gmane.org>
Subject: Re: radosgw + civetweb latency issue on Hammer
Date: Tue, 22 Sep 2015 14:49:57 +0530
Message-ID: <CAKP7xVwJFTv7cnG7jMMK6VQBKsv=NcrWSZTTtQ-FG28iS2mHkw@mail.gmail.com>
References: <CACAg-u97BjhmGbjRogKzmyTL_iPzj9C0qAbEgF28-ONFqe5Drw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CACAg-u97BjhmGbjRogKzmyTL_iPzj9C0qAbEgF28-ONFqe5Drw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Srikanth Madugundi <srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I encountered the same issue in my setup (with an AWS SDK client) and
on further investigation found that 'rgw print continue' was set to
false for a civetweb driven rgw.

Updated http://tracker.ceph.com/issues/12640

Giridhar
--
Giridhar Yasa | Flipkart Engineering | http://www.flipkart.com/


On Thu, Aug 6, 2015 at 5:31 AM, Srikanth Madugundi
<srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> After upgrading to Hammer and moving from apache to civetweb. We
> started seeing high PUT latency in the order of 2 sec for every PUT
> request. The GET request lo
>
> Attaching the radosgw logs for a single request. The ceph.conf has the
> following configuration for civetweb.
>
> [client.radosgw.gateway]
> rgw frontends = civetweb port=5632
>
>
> Further investion reveled the call to get_data() at
> https://github.com/ceph/ceph/blob/hammer/src/rgw/rgw_op.cc#L1786 is
> taking 2 sec to respond. The cluster is running Hammer 94.2 release
>
> Did any one face this issue before? Is there some configuration I am missing?
>
> Regards
> Srikanth
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
