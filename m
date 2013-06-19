From: Edward Hope-Morley <edward.hope-morley@canonical.com>
Subject: Re: RGW and Keystone
Date: Wed, 19 Jun 2013 11:00:51 +0100
Message-ID: <51C18153.8040704@canoncial.com>
References: <CAPeWyqwZO6E8qtc9teerxY9ZyYg+Qe_46kw6UHkwVD98Uk7ctA@mail.gmail.com> <CABBk=J-GB3U7HSjdmsHF9xWUGwi4QkO-57SjjNnORWUJ07oJ1Q@mail.gmail.com> <C0B54484-F2D6-4FE3-87A4-F06C2B20903E@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:52387 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934485Ab3FSKA6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 06:00:58 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf17so2277534bkc.35
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 03:00:57 -0700 (PDT)
Received: from [192.168.1.67] (host86-164-143-0.range86-164.btcentralplus.com. [86.164.143.0])
        by mx.google.com with ESMTPSA id kz11sm7442623bkb.11.2013.06.19.03.00.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 03:00:56 -0700 (PDT)
In-Reply-To: <C0B54484-F2D6-4FE3-87A4-F06C2B20903E@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi guys, I'm having the following issue with the RGW swift API:

The docs at http://ceph.com/docs/next/radosgw/swift/serviceops say that
for a GET request to list account contents I should do (as with Swift):

GET /{api version}/{account} HTTP/1.1


but, if I put the account RGW treats this as a bucket.

So the following works fine:

curl -i http://192.168.1.201:80/swift/v1 -X GET -H "X-Auth-Token: $token"

But this does not:
