From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Assertion failed while buildign manpages
Date: Tue, 5 Dec 2017 15:03:25 +0100
Message-ID: <4e4ed958-b5cc-a118-3c2f-4dd43ee02d70@digiware.nl>
References: <6899bf17-d2cd-8088-97fe-0a23d001b6dc@digiware.nl>
 <CAC-Np1ynKuTVNqKncyPDHctSK88=7wXadSDb=wtaDRrbqNrPSw@mail.gmail.com>
 <e5fcda3e-b57a-e7d0-b94e-e3c81c89e799@digiware.nl>
 <CAC-Np1zj8s0pDFYb1CUm_S4JEnsZ6fWuysYotZPJfMXgTgdNJw@mail.gmail.com>
 <206aa921-d233-652a-1cf8-717ddf51add9@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:40401 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbdLEOD1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 09:03:27 -0500
In-Reply-To: <206aa921-d233-652a-1cf8-717ddf51add9@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 5-12-2017 13:48, Willem Jan Withagen wrote:
>> This turned out to be a problem introduced by my change updating the
>> title on ceph-disk's man page:
>>
>> https://github.com/ceph/ceph/pull/19241/commits/bd00560c20caeeb1ded211cb81533280338014d1
>>
>> This has since been reverted with
>> https://github.com/ceph/ceph/pull/19325 and all builds are now passing
>>
>> Plain asserts in Python aren't a good way to report errors, so it was
>> very difficult to identify what made this break.
> 
> Hi Alfredo,
> 
> Right, I'll enable manapages again. And we'll see in the next build.

Building is back to normal.

--WjW
