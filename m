From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
Date: Wed, 04 Mar 2015 15:05:46 +0100
Message-ID: <54F7113A.1060702@bisect.de>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net>	<54F31D28.9050103@bisect.de>	<835936292.21191270.1425324075471.JavaMail.zimbra@redhat.com>	<CAOXiiM=n6K7LjkB0pkDBj11ND7=UhAgioBZ2wgJOY90u79ZNkA@mail.gmail.com>	<54F6467F.2000708@bisect.de> <CAOXiiMmBLRMdin7=O6x2dAG_eTHV3C=d0a09hi_--U6B3kxfhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58684 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754347AbbCDOFv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 09:05:51 -0500
In-Reply-To: <CAOXiiMmBLRMdin7=O6x2dAG_eTHV3C=d0a09hi_--U6B3kxfhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepak Shetty <dpkshetty@gmail.com>
Cc: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>, ceph-devel@vger.kernel.org

Am 04.03.2015 um 05:19 schrieb Deepak Shetty:
> On Wed, Mar 4, 2015 at 5:10 AM, Danny Al-Gaaf
> <danny.al-gaaf@bisect.de> wrote:
>> Am 03.03.2015 um 19:31 schrieb Deepak Shetty: [...]
[...]
>> 
>>> I was curious to understand. IIUC Neutron provides private and 
>>> public networks and for VMs to access external CephFS network,
>>> the tenant private network needs to be bridged/routed to the
>>> external provider network and there are ways neturon achives
>>> it.
>>> 
>>> Are you saying that this approach of neutron is insecure ?
>> 
>> I don't say neutron itself is insecure.
>> 
>> The problem is: we don't want any VM to get access to the ceph
>> public network at all since this would mean access to all MON,
>> OSDs and MDS daemons.
>> 
>> If a tenant VM has access to the ceph public net, which is needed
>> to use/mount native cephfs in this VM, one critical issue would
>> be: the client can attack any ceph component via this network.
>> Maybe I misses something, but routing doesn't change this fact.
>> 
> 
> Agree, but there are ways you can restrict the tenant VMs to
> specific network ports only using neutron security groups and limit
> what tenant VM can do. On the CephFS side one can use selinux
> labels to provide addnl level of security for Ceph daemons, where
> in only certain process can access/modify them, I am just thinking
> aloud here, i m not sure how well cephfs works with selinux 
> combined.

I don't see how neutron security groups would help here. The problem
is if a VM has access, in which way ever, to the Ceph network a
attacker/user can on one hand attack ALL ceph daemons and on the other
 also, if there is a bug, crash all daemons and you would lose the
complete cluster.

SELinux profiles can may help with preventing subvert security or gain
privileges it would not help in this case prevent the VM "user" to
crash the cluster.

> Thinking more, it seems like then you need a solution that goes via
> the serviceVM approach but provide native CephFS mounts instead of
> NFS ?

Another level of indirection. I really like the approach of filesystem
passthrough ... the only critical question is if virtfs/p9 is still
supported in some way (and the question if not: why?).

Danny
