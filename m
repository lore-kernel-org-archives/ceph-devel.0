From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: powercycle suite with -k testing
Date: Tue, 22 Nov 2016 11:04:34 +0100
Message-ID: <CAOi1vP-UYNpVr7W4w1vypCH+M9zi7Mumai4ENNBR1Ryk-8i+KA@mail.gmail.com>
References: <93d7f6cb-5640-98fc-29ce-fed3f19ab5cb@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33037 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbcKVKEg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 05:04:36 -0500
Received: by mail-vk0-f45.google.com with SMTP id 137so9369561vkl.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 02:04:35 -0800 (PST)
In-Reply-To: <93d7f6cb-5640-98fc-29ce-fed3f19ab5cb@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 22, 2016 at 7:10 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Greetings:
>
> During hammer integration testing, I ran some powercycle suites with "-k
> testing" and found that I could reproduce
> http://tracker.ceph.com/issues/17984 not only on the hammer-backports
> branch, but in hammer and jewel as well. But it only fails with "-k testing"
> (i.e. the "testing" kernel).
>
> Can anyone shed light on this?

Hi Nathan,

Known 4.9 kernel regression [1], should be fixed by [2].  I've just
re-pushed testing branch with the fix, just in case you want to try it
out.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=177801
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0ce267ff95a0302cf6fb2a552833abbfb7861a43

Thanks,

                Ilya
