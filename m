From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
Date: Wed, 04 Mar 2015 00:40:47 +0100
Message-ID: <54F6467F.2000708@bisect.de>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net>	<54F31D28.9050103@bisect.de>	<835936292.21191270.1425324075471.JavaMail.zimbra@redhat.com> <CAOXiiM=n6K7LjkB0pkDBj11ND7=UhAgioBZ2wgJOY90u79ZNkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33963 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756006AbbCCXkw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2015 18:40:52 -0500
In-Reply-To: <CAOXiiM=n6K7LjkB0pkDBj11ND7=UhAgioBZ2wgJOY90u79ZNkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepak Shetty <dpkshetty@gmail.com>, "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>
Cc: ceph-devel@vger.kernel.org

Am 03.03.2015 um 19:31 schrieb Deepak Shetty:
[...]
>> For us security is very critical, as the performance is too. The
>> first solution via ganesha is not what we prefer (to use CephFS
>> via p9 and NFS would not perform that well I guess). The second
>> solution, to use CephFS directly to the VM would be a bad
>> solution from the security point of view since we can't expose
>> the Ceph public network directly to the VMs to prevent all the
>> security issues we discussed already.
>> 
> 
> Is there any place the security issues are captured for the case
> where VMs access CephFS directly ?

No there isn't any place and this is the issue for us.

> I was curious to understand. IIUC Neutron provides private and
> public networks and for VMs to access external CephFS network, the
> tenant private network needs to be bridged/routed to the external
> provider network and there are ways neturon achives it.
> 
> Are you saying that this approach of neutron is insecure ?

I don't say neutron itself is insecure.

The problem is: we don't want any VM to get access to the ceph public
network at all since this would mean access to all MON, OSDs and MDS
daemons.

If a tenant VM has access to the ceph public net, which is needed to
use/mount native cephfs in this VM, one critical issue would be: the
client can attack any ceph component via this network. Maybe I misses
something, but routing doesn't change this fact.

Danny



