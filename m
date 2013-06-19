From: Edward Hope-Morley <opentastic@gmail.com>
Subject: Re: RGW and Keystone
Date: Wed, 19 Jun 2013 11:03:29 +0100
Message-ID: <51C181F1.4080500@gmail.com>
References: <CAPeWyqwZO6E8qtc9teerxY9ZyYg+Qe_46kw6UHkwVD98Uk7ctA@mail.gmail.com> <CABBk=J-GB3U7HSjdmsHF9xWUGwi4QkO-57SjjNnORWUJ07oJ1Q@mail.gmail.com> <C0B54484-F2D6-4FE3-87A4-F06C2B20903E@enovance.com> <51C18153.8040704@canoncial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:47179 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933830Ab3FSKDh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 06:03:37 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so2297501bkc.15
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 03:03:36 -0700 (PDT)
In-Reply-To: <51C18153.8040704@canoncial.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Edward Hope-Morley <edward.hope-morley@canonical.com>

Apologies, premature send ;)

On 19/06/13 11:00, Edward Hope-Morley wrote:
> Hi guys, I'm having the following issue with the RGW swift API:
>
> The docs at http://ceph.com/docs/next/radosgw/swift/serviceops say that
> for a GET request to list account contents I should do (as with Swift):
>
> GET /{api version}/{account} HTTP/1.1
>
>
> but, if I put the account RGW treats this as a bucket.
>
> So the following works fine:
>
> curl -i http://192.168.1.201:80/swift/v1 -X GET -H "X-Auth-Token: $token"
>
> But this does not:

curl -i http://192.168.1.201:80/swift/v1/$account -X GET -H
"X-Auth-Token: $token"

Am I doing something wrong or is this an anomaly in the RGW API?

Ed.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

