From: Muminul Islam Russell <misla011@fiu.edu>
Subject: Re: Selinux policy error in syslog
Date: Wed, 13 Jul 2016 13:32:30 -0700
Message-ID: <CAK=B8ybPc9ig=qaUpVb5msUsoWce7o_p8Q0mgcHtA1Zm59y6qA@mail.gmail.com>
References: <CAK=B8yZ-bykpECA=w+OoZjmqB_hAufWC4=uNK+75dgydmmnNZQ@mail.gmail.com>
 <CALqRxCyrCM1r38z5L55ZnaXPZu+ffuU__9XysshsxT499crUZA@mail.gmail.com> <CAK=B8yYt3u-w3Pc8cJfCGY4zNf2F9gyE0e2H5hgU4D6oRZjWWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36198 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcGMUcb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2016 16:32:31 -0400
Received: by mail-qk0-f178.google.com with SMTP id 82so55237168qko.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2016 13:32:31 -0700 (PDT)
In-Reply-To: <CAK=B8yYt3u-w3Pc8cJfCGY4zNf2F9gyE0e2H5hgU4D6oRZjWWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

FYI:

The issue is in later kernel i.e in may case 4.1.12.

Not reproducible in 3.8 or 3.10 kernel.

--
Muminul

On Wed, Jul 13, 2016 at 1:01 PM, Muminul Islam Russell <misla011@fiu.edu> wrote:
> I am using Kernel 4.1.12 and Ceph 10.2.2.
>
> Thanks,
> Muminul
>
> On Wed, Jul 13, 2016 at 12:14 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> Hi Muminul,
>>
>> Are you running with all the latest updates?
>>
>> Do you still experience issues with kernel 3.10.0-327.22.2.el7 ?
>>
>> - Ken
>>
>> On Wed, Jul 13, 2016 at 12:46 PM, Muminul Islam Russell
>> <misla011@fiu.edu> wrote:
>>> Hello,
>>>
>>> I got the following error while installing ceph-selinux.
>>>
>>> kernel: SELinux:  Permission audit_read in class capability2 not defined in
>>> policy.
>>> kernel: SELinux:  Class binder not defined in policy.
>>> kernel: SELinux: the above unknown classes and permissions will be allowed
>>>
>>> command to reproduce the error:
>>> /usr/sbin/semodule -i /usr/share/selinux/packages/ceph.pp
>>>
>>> Then check the output in syslog.
>>>
>>> Info:
>>> These are object classes and av permissions that were introduced in the
>>> newer kernel, but ceph-selinux policy is for the older kernel and thus does
>>> not know these new object classes and av permissions. So they will just be
>>> ignored (allowed). So other than a few warnings it really does not
>>> affect anything or change the behavior of the policy I believe.
>>>
>>> But we could just get rid of this warnings.
>>>
>>> Thanks,
>>> Muminul
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
