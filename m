From: Daniel Gryniewicz <dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RGW Beast frontend and ipv6 options
Date: Thu, 2 May 2019 10:08:23 -0400
Message-ID: <613006e7-62d9-a03f-f8d7-5a37ef1ffb88@redhat.com>
References: <87a7gdgngp.fsf@suse.com>
Reply-To: dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <87a7gdgngp.fsf-IBi9RG/b67k@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Based on past experience with this issue in other projects, I would 
propose this:

1. By default (rgw frontends=beast), we should bind to both IPv4 and 
IPv6, if available.

2. Just specifying port (rgw frontends=beast port=8000) should apply to 
both IPv4 and IPv6, if available.

3. If the user provides endpoint config, we should use only that 
endpoint config.  For example, if they provide only v4 addresses, we 
should only bind to v4.

This should all be independent of the bindv6only setting; that is, we 
should specifically bind our v4 and v6 addresses, and not depend on the 
system to automatically bind v4 when binding v6.

In the case of 1 or 2, if the system has disabled either v4 or v6, this 
should not be an error, as long as one of the two binds works.  In the 
case of 3, we should error out if any configured endpoint cannot be bound.

This should allow an orchestrator to confidently install a system, 
knowing what will happen, without needing to know or manipulate the 
bindv6only flag.

As for what happens if you specify an endpoint and a port, I don't have 
a strong opinion.  I see 2 reasonable possibilites:

a. Make it an error

b. Treat a port in this case as an endpoint of 0.0.0.0:port (v4-only)

Daniel

On 4/26/19 4:49 AM, Abhishek Lekshmanan wrote:
> 
> Currently RGW's beast frontend supports ipv6 via the endpoint
> configurable. The port option will bind to ipv4 _only_.
> 
> http://docs.ceph.com/docs/master/radosgw/frontends/#options
> 
> Since many Linux systems may default the sysconfig net.ipv6.bindv6only
> flag to true, it usually means that specifying a v6 endpoint will bind
> to both v4 and v6. But this also means that deployment systems must be
> aware of this while configuring depending on whether both v4 and v6
> endpoints need to work or not. Specifying both a v4 and v6 endpoint or a
> port (v4) and endpoint with the same v6 port will currently lead to a
> failure as the system would've already bound the v6 port to both v4 and
> v6. This leaves us with a few options.
> 
> 1. Keep the implicit behaviour as it is, document this, as systems are
> already aware of sysconfig flags and will expect that at a v6 endpoint
> will bind to both v4 and v6.
> 
> 2. Be explicit with endpoints & configuration, Beast itself overrides
> the socket option to bind both v4 and v6, which means that v6 endpoint
> will bind to v6 *only* and binding to a v4 will need an explicit
> specification. (there is a pr in progress for this:
> https://github.com/ceph/ceph/pull/27270)
> 
> Any more suggestions on how systems handle this are also welcome.
> 
> --
> Abhishek
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
