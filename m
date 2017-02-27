From: John Spray <jspray@redhat.com>
Subject: Re: Extend list of known distributions?
Date: Mon, 27 Feb 2017 14:25:30 +0000
Message-ID: <CALe9h7eqQ7CN8dXhs+7DvFwLZXCGx+w=0SbY69yxYYdeLDL3aA@mail.gmail.com>
References: <409b9481-4928-c5ea-8b00-ddb739f8ff96@oracle.com>
 <CALe9h7exfzURB7WpbZtxAX8Ae36CtcC7e16ZicXa0W5aOo5qdQ@mail.gmail.com> <17825d47-3081-fd78-ba7e-b5b724efccea@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36731 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdB0OZw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 09:25:52 -0500
Received: by mail-wm0-f43.google.com with SMTP id v77so62289342wmv.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 06:25:51 -0800 (PST)
In-Reply-To: <17825d47-3081-fd78-ba7e-b5b724efccea@oracle.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nikita Gerasimov <nikita.gerasimov@oracle.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 27, 2017 at 2:16 PM, Nikita Gerasimov
<nikita.gerasimov@oracle.com> wrote:
> On 27.02.2017 17:02, John Spray wrote:
>>
>> On Mon, Feb 27, 2017 at 1:40 PM, Nikita Gerasimov
>> <nikita.gerasimov@oracle.com> wrote:
>>>
>>> Hi All,
>>>
>>> Is it possible to add Oracle Linux[1] into list of Ceph known
>>> distributions?
>>> If so what is correct procedure to do it?
>>
>> Which list in particular are you asking about?  Something on a
>> website, or something in the code?
>
> I hope both, but main concern are places like
> https://github.com/ceph/ceph/blob/master/src/ceph-detect-init/ceph_detect_init/__init__.py#L59

That would just be a normal code update: send a pull request:
https://github.com/ceph/ceph/blob/master/SubmittingPatches.rst

John

>>
>> John
>>
>>> Oracle Linux provide API/ABI compatibility with RHEL so not many changes
>>> required. Mostly in right distro detection.
>>>
>>> [1]https://linux.oracle.com
>>>
>>> WBR, Nikita.
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
