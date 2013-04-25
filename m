From: brady <brady@lamphost.com>
Subject: Re: Vanity Hostnames Not Working
Date: Thu, 25 Apr 2013 16:13:54 -0700
Message-ID: <5179B8B2.6000709@lamphost.com>
References: <5179AE60.2090700@lamphost.com> <CA+zLgM0Q3723J2_J1VkNZHQHswjByfQFOY2AHLpCE8MH0apCHA@mail.gmail.com> <CA+zLgM1qhUVWmNdcJqxH4Dqnao7JaAXTLuub0nYBTbhYmqr7yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tux1.lamphost.net ([69.43.195.66]:47516 "EHLO tux1.lamphost.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758773Ab3DYXN4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Apr 2013 19:13:56 -0400
In-Reply-To: <CA+zLgM1qhUVWmNdcJqxH4Dqnao7JaAXTLuub0nYBTbhYmqr7yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Caleb Miles <caleb.miles@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 04/25/2013 03:56 PM, Caleb Miles wrote:
> Hello Brady,
>
> Have you also set up Dnsmasq or similar on your client(s) to point to your
> vanity name?

We are not specifically using Dnsmasq, but we have set up the DNS 
records, including the CNAME pointing to the bucket at the correct IP.

>
>> On Apr 25, 2013 6:49 PM, "brady" <brady@lamphost.com> wrote:
>>>
>>> Hello list,
>>>          We are running Bobtail on our cluster and currently attempting
> to make the vanity host names work in the radosGW configuration. Our rgw
> segment of the ceph.conf file looks like:
>>>
>>> [client.radosgw.rgw1]
>>>    host = ceph-rgw1
>>>    rgw dns name = objects.lamphost.net
>>>    rgw resolve cname = true
>>>    rgw enable usage log = true
>>>    keyring = /etc/ceph/keyring.radosgw.rgw1
>>>    rgw socket path = /run/radosgw.sock
>>>    log file = /var/log/ceph/radosgw.log
>>>
>>>          The DNS does not seem to route with the configuration above. Is
> there something else/different that is required to make this work? We have
> not seen any concrete examples of configurations for this despite the
> Vanity host names being listed as an addition in the Bobtail release notes.
>>>
>>>          Thanks in advance!
>>>
>>> -Brady
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-Brady
