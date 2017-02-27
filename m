From: Nikita Gerasimov <nikita.gerasimov@oracle.com>
Subject: Re: Extend list of known distributions?
Date: Mon, 27 Feb 2017 17:16:11 +0300
Message-ID: <17825d47-3081-fd78-ba7e-b5b724efccea@oracle.com>
References: <409b9481-4928-c5ea-8b00-ddb739f8ff96@oracle.com>
 <CALe9h7exfzURB7WpbZtxAX8Ae36CtcC7e16ZicXa0W5aOo5qdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44663 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdB0ORW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 09:17:22 -0500
In-Reply-To: <CALe9h7exfzURB7WpbZtxAX8Ae36CtcC7e16ZicXa0W5aOo5qdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 27.02.2017 17:02, John Spray wrote:
> On Mon, Feb 27, 2017 at 1:40 PM, Nikita Gerasimov
> <nikita.gerasimov@oracle.com> wrote:
>> Hi All,
>>
>> Is it possible to add Oracle Linux[1] into list of Ceph known distributions?
>> If so what is correct procedure to do it?
> Which list in particular are you asking about?  Something on a
> website, or something in the code?
I hope both, but main concern are places like 
https://github.com/ceph/ceph/blob/master/src/ceph-detect-init/ceph_detect_init/__init__.py#L59
>
> John
>
>> Oracle Linux provide API/ABI compatibility with RHEL so not many changes
>> required. Mostly in right distro detection.
>>
>> [1]https://linux.oracle.com
>>
>> WBR, Nikita.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

