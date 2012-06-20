From: Wido den Hollander <wido@widodh.nl>
Subject: Re: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 11:13:31 +0200
Message-ID: <4FE1943B.5060806@widodh.nl>
References: <4FE1910A.3020708@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:32843 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab2FTJNe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 05:13:34 -0400
In-Reply-To: <4FE1910A.3020708@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/20/2012 10:59 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i've some problems to find the correct combination of ceph.conf,
> /etc/hosts for the init script to work correctly.
>
> My systems are named:
> ssdstor000i
> ssdstor001i
> ssdstor002i
>

What does hostname | cut -d . -f 1 say?

This is looked up by the init script, see: /usr/lib/ceph/ceph_common.sh

> These names point to the public external IP.
>
> These systems also have an alias (ssdstor000,ssdstor001) pointing to the
> internal IP which should be used by ceph.
>
> My ceph.conf looks like this:
>
> ...
> [osd.10]
> host= ssdstor000
> [osd.11]
> host= ssdstor000
> ...
>
> The ceph.init Script looks now for an entry called ssdstor000i but can't
> find one and so it does not start or stop any services.
>
> My /etc/hosts file:
> 192.168.0.100 ssdstor000.XYZ.de ssdstor000i
>
> 10.0.255.100 ssdstor000
>
> What is the correct way to archieve that the default hostname is still
> the public one but ceph uses the internal one?

You can specify --hostname with the init script, but I recommend using 
the hostnames which is set in /etc/hostname in your ceph.conf

Wido

>
> Greets
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

