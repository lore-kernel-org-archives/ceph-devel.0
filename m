From: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [Manila] Ceph native driver for manila
Date: Wed, 04 Mar 2015 15:26:52 +0100
Message-ID: <54F7162C.1000900@bisect.de>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net>
 <54F31D28.9050103@bisect.de>
 <1011159141.22473140.1425478320272.JavaMail.zimbra@redhat.com>
Reply-To: "OpenStack Development Mailing List \(not for usage questions\)"
 <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1011159141.22473140.1425478320272.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.openstack.org/cgi-bin/mailman/options/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openstack.org/pipermail/openstack-dev>
List-Post: <mailto:openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Errors-To: openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
To: Csaba Henk <chenk-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "OpenStack Development Mailing List (not for usage questions)" <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Am 04.03.2015 um 15:12 schrieb Csaba Henk:
> Hi Danny,
> 
> ----- Original Message -----
>> From: "Danny Al-Gaaf" <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org> To: "OpenStack
>> Development Mailing List (not for usage questions)"
>> <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
>> Sent: Sunday, March 1, 2015 3:07:36 PM Subject: Re:
>> [openstack-dev] [Manila] Ceph native driver for manila
> ...
>> For us security is very critical, as the performance is too. The
>> first solution via ganesha is not what we prefer (to use CephFS
>> via p9 and NFS would not perform that well I guess). The second
>> solution, to use
> 
> Can you please explain that why does the Ganesha based stack
> involve 9p? (Maybe I miss something basic, but I don't know.)

Sorry, seems that I mixed it up with the p9 case. But the performance
is may still an issue if you use NFS on top of CephFS (incl. all the
VM layer involved within this setup).

For me the question with all these NFS setups is: why should I use NFS
on top on CephFS? What is the right to exist of CephFS in this case? I
would like to use CephFS directly or via filesystem passthrough.

Danny


__________________________________________________________________________
OpenStack Development Mailing List (not for usage questions)
Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev
