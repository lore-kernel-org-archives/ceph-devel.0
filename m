From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 11:20:30 +0200
Message-ID: <4FE195DE.50108@profihost.ag>
References: <4FE1910A.3020708@profihost.ag> <4FE1943B.5060806@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:38951 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab2FTJUg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 05:20:36 -0400
In-Reply-To: <4FE1943B.5060806@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 20.06.2012 11:13, schrieb Wido den Hollander:
> On 06/20/2012 10:59 AM, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> i've some problems to find the correct combination of ceph.conf,
>> /etc/hosts for the init script to work correctly.
>>
>> My systems are named:
>> ssdstor000i
>> ssdstor001i
>> ssdstor002i
>>
> What does hostname | cut -d . -f 1 say?
It says ssdstor000i as the machine defaults to it's public IP.

Whouldn't it make sense to go through all aliases set in /etc/hosts 
which point to a local IP?

Stefan
