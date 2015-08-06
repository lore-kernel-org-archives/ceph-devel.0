From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: radosgw + civetweb latency issue on Hammer
Date: Thu, 06 Aug 2015 10:51:14 -0500
Message-ID: <55C38272.2090703@redhat.com>
References: <CACAg-u97BjhmGbjRogKzmyTL_iPzj9C0qAbEgF28-ONFqe5Drw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: Srikanth Madugundi <srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Srikanth,

Can you make a ticket on tracker.ceph.com for this?  We'd like to not 
loose track of it.

Thanks!
Mark

On 08/05/2015 07:01 PM, Srikanth Madugundi wrote:
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
