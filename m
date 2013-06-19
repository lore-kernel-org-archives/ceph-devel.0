From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Issue with RGW API
Date: Wed, 19 Jun 2013 08:37:30 -0700
Message-ID: <CABBk=J9F6iWywXprR=-nnB6kG4AxaH3AGaGmObao8UcCY6Ks4w@mail.gmail.com>
References: <CAPeWyqwZO6E8qtc9teerxY9ZyYg+Qe_46kw6UHkwVD98Uk7ctA@mail.gmail.com>
	<CABBk=J-GB3U7HSjdmsHF9xWUGwi4QkO-57SjjNnORWUJ07oJ1Q@mail.gmail.com>
	<C0B54484-F2D6-4FE3-87A4-F06C2B20903E@enovance.com>
	<51C18153.8040704@canoncial.com>
	<51C181F1.4080500@gmail.com>
	<CABBk=J-UfWB+wTU1GmDbhx8gnB17w3RjOcdymO6x59oz3y-nog@mail.gmail.com>
	<51C1CC83.7070206@canoncial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:50886 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab3FSPhb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 11:37:31 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz10so4185413veb.31
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 08:37:31 -0700 (PDT)
In-Reply-To: <51C1CC83.7070206@canoncial.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Edward Hope-Morley <edward.hope-morley@canonical.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, John Wilkins <john.wilkins@inktank.com>

On Wed, Jun 19, 2013 at 8:21 AM, Edward Hope-Morley
<edward.hope-morley@canonical.com> wrote:
> Yehuda,
>
> Thanks for your reply. Is this not a bit un-Swift like? I came across
> this while testing the backup service for Openstack Cinder. Cinder
> currently supports backup to Swift so I tested this against Rados
> Gateway but it does not work because the it uses the standard
> http://<server>/<version>/<account> format.

The url should not be built directly, but rather use the returned
storage-url that it got when authenticated with the auth service.
Swift happens to build it in that format.

>
> Also, there is an issue with PUTs where RGW returns a "411 Length
> Required" in case the content-length is not specified. Is content-length
> mandatory? Swift does not seem to complain. What are your thoughts on this?
>
A PUT without content length needs to be chunked. If the missing
content-length is missing, we require 'Transfer-Encoding: chunked'.


> (updated the subject since it was wrong)
>
> Ed.
>
> On 19/06/13 16:08, Yehuda Sadeh wrote:
>> On Wed, Jun 19, 2013 at 3:03 AM, Edward Hope-Morley
>> <opentastic@gmail.com> wrote:
>>> Apologies, premature send ;)
>>>
>>> On 19/06/13 11:00, Edward Hope-Morley wrote:
>>>> Hi guys, I'm having the following issue with the RGW swift API:
>>>>
>>>> The docs at http://ceph.com/docs/next/radosgw/swift/serviceops say that
>>>> for a GET request to list account contents I should do (as with Swift):
>>>>
>>>> GET /{api version}/{account} HTTP/1.1
>>>>
>>>>
>>>> but, if I put the account RGW treats this as a bucket.
>>>>
>>>> So the following works fine:
>>>>
>>>> curl -i http://192.168.1.201:80/swift/v1 -X GET -H "X-Auth-Token: $token"
>>>>
>>>> But this does not:
>>> curl -i http://192.168.1.201:80/swift/v1/$account -X GET -H
>>> "X-Auth-Token: $token"
>>>
>>> Am I doing something wrong or is this an anomaly in the RGW API?
>>>
>> The docs are wrong there, the account is determined by the auth token.
>>
>> Yehuda
>
