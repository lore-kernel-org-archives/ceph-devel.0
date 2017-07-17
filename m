From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: CLI test for rbd
Date: Mon, 17 Jul 2017 14:59:21 +0200
Message-ID: <61127818-2272-0f44-56a4-0cae1abe1f31@digiware.nl>
References: <59aa8ba0-42e8-feaa-d6aa-ec16131fd062@digiware.nl>
 <CA+aFP1CU4igK=byYaRvkLbWndgaizzZC8_3sN0Gc3PCO_SwgtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:15311 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751358AbdGQM7Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Jul 2017 08:59:24 -0400
In-Reply-To: <CA+aFP1CU4igK=byYaRvkLbWndgaizzZC8_3sN0Gc3PCO_SwgtA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 17-7-2017 14:48, Jason Dillaman wrote:
> Feel free to disable that under FreeBSD -- I'm sure it's not the only
> test disabled. I don't want to remove the test outright since it
> exercises a normally untested code path and it helps to focus
> attention to the CLI documentation during reviews.

Right,
That is the other option I did, but even then it would be sort of like
cheating. So Mykola has some other changes up his sleeve, and supposedly
it is possible to differentiate for other platforms altogether.

--WjW

> On Sun, Jul 16, 2017 at 5:25 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> with the creation of rbd-ggate with FreeBSD we have run into a testing
>> snag..
>>
>> Of rbd tehere is a CLI command help test, that verifies that help generates
>> help.
>> But under FreeBSD that help is augmented with some ggate commands.
>>
>> Do we really want/need that test?
>> And might I suggest to remove it, as it is IMHO not al that informative.
>>
>> Otherwise we need to come up with something rather complex to make
>> run-cli-tests work on FreeBSD as well.
>>
>> --WjW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

