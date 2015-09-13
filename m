From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RGW Keystone interaction (was  Ceph.conf)
Date: Sun, 13 Sep 2015 02:20:17 -0400 (EDT)
Message-ID: <276152828.15916829.1442125217473.JavaMail.zimbra@redhat.com>
References: <1309337249.15903333.1442101488287.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1309337249.15903333.1442101488287.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Abhishek L <abhishek.lekshmanan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> Looked a bit more into this, swift apis seem to support the use
> of an admin tenant, user & token for validating the bearer token,
> similar to other openstack service which use a service tenant
> credentials for authenticating.

Yes, it's just working as middleware under Keystone.

>  Though it needs documentation, the configurables `rgw keystone admin
> tenant`, `rgw keystone admin user` and `rgw keystone admin password`
> make this possible, so as to avoid configuring the keystone shared
> admin password compoletely.

It's getting better but still problematic:

    keystonemiddleware.auth_token

> S3 APIs with keystone seem to be a bit more different, apparently

Yes, from codes point of view, it's a bit. But, architecture point of
view, it's not bit, I think.

> s3tokens interface does seem to allow authenticating without an
> `X-Auth-Token` in the headers and validates based on the access key,
> secret key provided to it. So basically not configuring
> `rgw_keystone_admin_password` seem to work, can you also see if this
> is the case for you.

Yes, I think so.

I do not say that Keystone is problem. Keystone itself is quite fine.

But what we have to make sure is that OpenStack becomes getting bigger
than we thought just 4 years ago.

There have been already more components like TripleO which was totally out
of scope of OpenStack at the beginning.

So it's impossible for Keystone to deal with every single request regarding
to identities about using OpenStack services properly.

In respect to our page:

  http://ceph.com/docs/giant/radosgw/keystone/

Probably it's better explain why we are using v1 not v2, if we have any
specific reason.

What do you think?

 Shinobu
