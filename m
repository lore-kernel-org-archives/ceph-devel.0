From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Hammer 0.94.10 release - last call
Date: Thu, 5 Jan 2017 13:47:20 -0800
Message-ID: <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz> <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
 <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36495 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754425AbdAEVrX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2017 16:47:23 -0500
Received: by mail-wm0-f48.google.com with SMTP id c85so3308333wmi.1
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2017 13:47:22 -0800 (PST)
In-Reply-To: <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "Dachary, Loic" <ldachary@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>

May ceph-disk ?
Loic FYI

On Thu, Jan 5, 2017 at 1:36 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Is it possible to re-do this PR that went into Jewel for Hammer?
>>
>> http://tracker.ceph.com/issues/17754
>
>
> OK, https://github.com/ceph/ceph/pull/12805
>
> Any suggestions how to test it? I.e. do you know if there's a teuthology or
> ceph-qa-suite task that exercises ceph-create-keys?
>
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
