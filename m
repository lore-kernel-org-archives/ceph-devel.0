From: Muminul Islam Russell <misla011@fiu.edu>
Subject: Selinux policy error in syslog
Date: Wed, 13 Jul 2016 11:46:53 -0700
Message-ID: <CAK=B8yZ-bykpECA=w+OoZjmqB_hAufWC4=uNK+75dgydmmnNZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35771 "EHLO
	mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbcGMSrH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2016 14:47:07 -0400
Received: by mail-qt0-f182.google.com with SMTP id j35so30774281qtj.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2016 11:47:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I got the following error while installing ceph-selinux.

kernel: SELinux:  Permission audit_read in class capability2 not defined in
policy.
kernel: SELinux:  Class binder not defined in policy.
kernel: SELinux: the above unknown classes and permissions will be allowed

command to reproduce the error:
/usr/sbin/semodule -i /usr/share/selinux/packages/ceph.pp

Then check the output in syslog.

Info:
These are object classes and av permissions that were introduced in the
newer kernel, but ceph-selinux policy is for the older kernel and thus does
not know these new object classes and av permissions. So they will just be
ignored (allowed). So other than a few warnings it really does not
affect anything or change the behavior of the policy I believe.

But we could just get rid of this warnings.

Thanks,
Muminul
