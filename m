From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Note about rbd_aio_write usage
Date: Fri, 7 Jul 2017 09:14:03 -0400
Message-ID: <CA+aFP1AuYLObYpNn1PGbxOm87wERLFZ7weziFZXc0hU6vcsj4w@mail.gmail.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
 <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
 <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com> <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
 <a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com> <CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
 <e39eba47-ae4d-05bb-41cd-928565324d6c@corp.ovh.com> <CA+aFP1CXkF914u1qboCC1OnK3Qqqs7w0NctDxG82u=gpmUcxmA@mail.gmail.com>
 <20170706192508.GG9832@mailware> <CA+aFP1B4iDjCLtpLsdPseuVfrysiatr3Bwb-i5OfZP8dt-WRpg@mail.gmail.com>
 <ab66c7b1-772e-910f-839e-158224ef0525@corp.ovh.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:32846 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdGGNOF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jul 2017 09:14:05 -0400
Received: by mail-yw0-f176.google.com with SMTP id x125so13148697ywa.0
        for <ceph-devel@vger.kernel.org>; Fri, 07 Jul 2017 06:14:05 -0700 (PDT)
In-Reply-To: <ab66c7b1-772e-910f-839e-158224ef0525@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Fri, Jul 7, 2017 at 2:48 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> Is this:
> https://github.com/yuyuyu101/ceph/commit/794b49b5b860c538a349bdadb16bb6ae97ad9c20#commitcomment-15707924
> the issue you mention? Because at this point I'm considering switching to
> C++ API and passing static bufferptr buried in my bufferlist instead of
> having extra copy done by C API rbd_aio_write (that way I'd at least control
> the allocations).

Yes, that is the issue along with the comment from Sage in your
previous thread [1] where I proposed a potential workaround w/o the
need to deeply perturb the messaging layer.

[1] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-January/015687.html

-- 
Jason
