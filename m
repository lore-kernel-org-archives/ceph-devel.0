From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph questions regarding auth and return on PUT from radosgw
Date: Mon, 11 Jun 2012 14:51:35 +0200
Message-ID: <4FD5E9D7.5010200@widodh.nl>
References: <CAMmJxtJyzaqwV2+BgrHwMZSWiLJKhM7948MUuEme-MGjZofuWw@mail.gmail.com> <4FD5E74A.8070903@widodh.nl> <CAMmJxtL_sGx6fSs2+CZet10JVDPJqebkqreJuHQzhgUxngM-nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:46430 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab2FKMvd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 08:51:33 -0400
In-Reply-To: <CAMmJxtL_sGx6fSs2+CZet10JVDPJqebkqreJuHQzhgUxngM-nw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org



On 06/11/2012 02:41 PM, John Axel Eriksson wrote:
> Oh sorry. I don't think I was clear on the auth question. What I meant
> was if the admin.keyring and keys for the osd:s are really necessary
> in a private ceph-cluster.

I'd say: Yes

With keys in place you can ensure that a rogue machine starts bringing 
down your cluster.

Scenario: You take a machine offline in a cluster, let it sit in storage 
for some while and a couple of months later somebody wonders what that 
machine does.

Plugs it into a switch, power and boots. Suddenly this old machine which 
is way behind on software starts participating in your cluster again and 
could potentially bring it all down.

But it could even be even more simple. You set up a second Ceph cluster 
for some tests, but while playing with the 'rados' command you 
accidentally connect to the wrong cluster and issue a "rmpool". Oops!

With auth in place you have a barrier against such situations.

Wido

>
> On Mon, Jun 11, 2012 at 2:40 PM, Wido den Hollander<wido@widodh.nl>  wrote:
>> Hi,
>>
>>
>> On 06/11/2012 02:32 PM, John Axel Eriksson wrote:
>>>
>>> Is there a point to having auth enabled if I run ceph on an internal
>>> network, only for use with radosgw (i.e the object storage part)?
>>> It seems to complicate the setup unnecessarily and ceph doesn't use
>>> encryption anyway as far as I understand, it's only auth.
>>> If my network is trusted and I know who has access (and I trust them)
>>> - is there a point to complicate the setup with key-based auth?
>>>
>>
>> The RADOS Gateway uses the S3 protocol and that requires authentication and
>> authorization.
>>
>> When creating a bucket/pool and storing objects, it has to be mapped to a
>> users inside the RADOS GW.
>>
>> I don't know what your exact use-case is, but if it's only internal, isn't
>> it a possibility to use RADOS natively?
>>
>>
>>> Also, when PUTting something through radosgw, does ceph/rgw return as
>>> soon as all data has been received or does it return
>>> when it has ensured N replicas? (I've seen quite a delay after all
>>> data has been sent before my PUT returns). I'm using nginx (1.2) by
>>> the way.
>>
>>
>> iirc it returns when all replicas have received and stored the object.
>>
>> Wido
>>
>>>
>>> Thanks!
>>>
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
