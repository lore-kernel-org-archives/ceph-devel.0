From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: UID/GID for ceph user and group
Date: Mon, 20 Feb 2017 10:53:17 +0100
Message-ID: <77115ad3-c903-ff7d-4d36-fc34c0f89e7a@digiware.nl>
References: <24f3a600-fe0f-05ba-7404-f30db486a9e1@digiware.nl>
 <CAF-wwdEQckkwGu1ooUeAv70DwP9Vm0+kOzwUVLEsbp14ubL0Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:19375 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbdBTJzS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Feb 2017 04:55:18 -0500
In-Reply-To: <CAF-wwdEQckkwGu1ooUeAv70DwP9Vm0+kOzwUVLEsbp14ubL0Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20-2-2017 07:07, Brad Hubbard wrote:
> On Fri, Feb 17, 2017 at 1:46 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> Is there a typical uid/gid that is selected on oterh platforms to assign
>> to ceph:ceph?
> 
> https://github.com/ceph/ceph/blob/master/ceph.spec.in#L970
> 
> I wonder if that should be "%if 0%{?rhel} || 0%{?fedora} || 0%{?centos}" ?
> 
> Seems odd you'd be the first to notice though?????
> 
>>
>> On my centos7 box they are not defined when I installed the ceph package?

This is/was for my FreeBSD ceph port....
And it seems that there is a bit of consensus on 167 IF IDs need to be <
1000. Which is the case for preassigned UID/GIDs on FreeBSD.

So for now I took 167:167, which was still free.

Thanx,
--WjW


