From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: UID/GID for ceph user and group
Date: Mon, 20 Feb 2017 20:49:49 +1000
Message-ID: <CAF-wwdEhot7H6Oua5bNX66=xay8y5CAp3w4i5LVYDE9ALdJbPQ@mail.gmail.com>
References: <24f3a600-fe0f-05ba-7404-f30db486a9e1@digiware.nl>
 <CAF-wwdEQckkwGu1ooUeAv70DwP9Vm0+kOzwUVLEsbp14ubL0Xg@mail.gmail.com> <77115ad3-c903-ff7d-4d36-fc34c0f89e7a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36033 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdBTKtv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 05:49:51 -0500
Received: by mail-io0-f177.google.com with SMTP id j13so24237109iod.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2017 02:49:51 -0800 (PST)
In-Reply-To: <77115ad3-c903-ff7d-4d36-fc34c0f89e7a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

>> On my centos7 box they are not defined when I installed the ceph package?

It was this statement that concerned me. Wondering why the ceph
user/group wasn't created during your CentOS install?

On Mon, Feb 20, 2017 at 7:53 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 20-2-2017 07:07, Brad Hubbard wrote:
>> On Fri, Feb 17, 2017 at 1:46 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> Is there a typical uid/gid that is selected on oterh platforms to assign
>>> to ceph:ceph?
>>
>> https://github.com/ceph/ceph/blob/master/ceph.spec.in#L970
>>
>> I wonder if that should be "%if 0%{?rhel} || 0%{?fedora} || 0%{?centos}" ?
>>
>> Seems odd you'd be the first to notice though?????
>>
>>>
>>> On my centos7 box they are not defined when I installed the ceph package?
>
> This is/was for my FreeBSD ceph port....
> And it seems that there is a bit of consensus on 167 IF IDs need to be <
> 1000. Which is the case for preassigned UID/GIDs on FreeBSD.
>
> So for now I took 167:167, which was still free.
>
> Thanx,
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
