From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 11:40:39 +0200
Message-ID: <4FE19A97.4060300@profihost.ag>
References: <4FE1910A.3020708@profihost.ag> <4FE1943B.5060806@widodh.nl> <4FE195DE.50108@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52554 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab2FTJkp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 05:40:45 -0400
In-Reply-To: <4FE195DE.50108@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 20.06.2012 11:20, schrieb Stefan Priebe - Profihost AG:
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

I found mon addr to specify a different address than the hostname is set 
but i haven't found osd addr does this exist too?

So i'm able to set the hostname to the public IP but let ceph still use 
the internal ones.

Stefan
