From: brady <brady@lamphost.com>
Subject: Re: Vanity Hostnames Not Working
Date: Fri, 26 Apr 2013 09:26:01 -0700
Message-ID: <517AAA99.8050602@lamphost.com>
References: <5179AE60.2090700@lamphost.com> <CA+zLgM0Q3723J2_J1VkNZHQHswjByfQFOY2AHLpCE8MH0apCHA@mail.gmail.com> <CA+zLgM1qhUVWmNdcJqxH4Dqnao7JaAXTLuub0nYBTbhYmqr7yw@mail.gmail.com> <5179B8B2.6000709@lamphost.com> <CABBk=J_-Hc90O1CGs+ggxf28N+iF9==VnZAp2LM+-VW9C97E9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tux1.lamphost.net ([69.43.195.66]:52100 "EHLO tux1.lamphost.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755516Ab3DZQ0E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Apr 2013 12:26:04 -0400
In-Reply-To: <CABBk=J_-Hc90O1CGs+ggxf28N+iF9==VnZAp2LM+-VW9C97E9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Caleb Miles <caleb.miles@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks guys! Once we looked at the CNAME to get ready to paste it into 
the message, we noticed that the formatting was incorrect. Sorry to 
bother with such a trivial issue but thanks for pointing us in the right 
direction! Everything is working now.

-Brady


On 04/25/2013 04:39 PM, Yehuda Sadeh wrote:
> On Thu, Apr 25, 2013 at 4:13 PM, brady <brady@lamphost.com> wrote:
>> Hi,
>>
>> On 04/25/2013 03:56 PM, Caleb Miles wrote:
>>>
>>> Hello Brady,
>>>
>>> Have you also set up Dnsmasq or similar on your client(s) to point to your
>>> vanity name?
>>
>>
>> We are not specifically using Dnsmasq, but we have set up the DNS records,
>> including the CNAME pointing to the bucket at the correct IP.
>
> How does the CNAME record look like?
>
>>
>>
>>>
>>>> On Apr 25, 2013 6:49 PM, "brady" <brady@lamphost.com> wrote:
>>>>>
>>>>>
>>>>> Hello list,
>>>>>           We are running Bobtail on our cluster and currently attempting
>>>
>>> to make the vanity host names work in the radosGW configuration. Our rgw
>>> segment of the ceph.conf file looks like:
>>>>>
>>>>>
>>>>> [client.radosgw.rgw1]
>>>>>     host = ceph-rgw1
>>>>>     rgw dns name = objects.lamphost.net
>>>>>     rgw resolve cname = true
>>>>>     rgw enable usage log = true
>>>>>     keyring = /etc/ceph/keyring.radosgw.rgw1
>>>>>     rgw socket path = /run/radosgw.sock
>>>>>     log file = /var/log/ceph/radosgw.log
>>>>>
>>>>>           The DNS does not seem to route with the configuration above. Is
>>>
>>> there something else/different that is required to make this work? We have
>>> not seen any concrete examples of configurations for this despite the
>>> Vanity host names being listed as an addition in the Bobtail release
>>> notes.
>>>>>
>>>>>
>>>>>           Thanks in advance!
>>>>>
>>>>> -Brady
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>> -Brady
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

