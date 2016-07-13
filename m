From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Selinux policy error in syslog
Date: Wed, 13 Jul 2016 13:14:45 -0600
Message-ID: <CALqRxCyrCM1r38z5L55ZnaXPZu+ffuU__9XysshsxT499crUZA@mail.gmail.com>
References: <CAK=B8yZ-bykpECA=w+OoZjmqB_hAufWC4=uNK+75dgydmmnNZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34172 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcGMTOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2016 15:14:52 -0400
Received: by mail-vk0-f44.google.com with SMTP id o63so79513745vkg.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2016 12:14:52 -0700 (PDT)
In-Reply-To: <CAK=B8yZ-bykpECA=w+OoZjmqB_hAufWC4=uNK+75dgydmmnNZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Muminul Islam Russell <misla011@fiu.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Muminul,

Are you running with all the latest updates?

Do you still experience issues with kernel 3.10.0-327.22.2.el7 ?

- Ken

On Wed, Jul 13, 2016 at 12:46 PM, Muminul Islam Russell
<misla011@fiu.edu> wrote:
> Hello,
>
> I got the following error while installing ceph-selinux.
>
> kernel: SELinux:  Permission audit_read in class capability2 not defined in
> policy.
> kernel: SELinux:  Class binder not defined in policy.
> kernel: SELinux: the above unknown classes and permissions will be allowed
>
> command to reproduce the error:
> /usr/sbin/semodule -i /usr/share/selinux/packages/ceph.pp
>
> Then check the output in syslog.
>
> Info:
> These are object classes and av permissions that were introduced in the
> newer kernel, but ceph-selinux policy is for the older kernel and thus does
> not know these new object classes and av permissions. So they will just be
> ignored (allowed). So other than a few warnings it really does not
> affect anything or change the behavior of the policy I believe.
>
> But we could just get rid of this warnings.
>
> Thanks,
> Muminul
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
