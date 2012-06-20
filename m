From: Wido den Hollander <wido@widodh.nl>
Subject: Re: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 15:46:28 +0200
Message-ID: <4FE1D434.2080602@widodh.nl>
References: <4FE1910A.3020708@profihost.ag> <4FE1943B.5060806@widodh.nl> <4FE195DE.50108@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45140 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2FTNqb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 09:46:31 -0400
In-Reply-To: <4FE195DE.50108@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/20/2012 11:20 AM, Stefan Priebe - Profihost AG wrote:
> Am 20.06.2012 11:13, schrieb Wido den Hollander:
>> On 06/20/2012 10:59 AM, Stefan Priebe - Profihost AG wrote:
>>> Hello list,
>>>
>>> i've some problems to find the correct combination of ceph.conf,
>>> /etc/hosts for the init script to work correctly.
>>>
>>> My systems are named:
>>> ssdstor000i
>>> ssdstor001i
>>> ssdstor002i
>>>
>> What does hostname | cut -d . -f 1 say?
> It says ssdstor000i as the machine defaults to it's public IP.
>
> Whouldn't it make sense to go through all aliases set in /etc/hosts
> which point to a local IP?

Ceph is not really intended to work with public or private IP's.

The idea is that you have a Layer 2 or Layer 3 network over which all 
the daemons and clients connect over a routable network, peer-to-peer, 
no NAT in it's way.

You can however have a seperate "osd" network where the OSD's 
interconnect for their replication traffic, but that has nothing to do 
with the hostnames.

You can take a look at the configuration options "public_addr" and 
"cluster_addr" for these.

Besides that, Ceph would run on a "private" network. If you have KVM 
hosts these will have a WAN connection over which they (and their VM's) 
communicate with the outside world and over a dedicated NIC the host 
communicates with the Ceph cluster.

I'd recommend sticking with 1 IP-Address for each OSD, keep it simple.

Wido

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

