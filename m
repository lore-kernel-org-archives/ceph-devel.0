From: kefu chai <tchaikov@gmail.com>
Subject: Re: [GSoC] Queries regarding the Project
Date: Fri, 24 Mar 2017 15:31:28 +0800
Message-ID: <CAJE9aOMqs+KiNqq-HWp3rhahZc37664o9L0JymJANBKGOdVAwg@mail.gmail.com>
References: <CAAXqJ+omQh-sSv06i0Wo50JEVzGsin7Zoe4zKYTW9q=Eu_QUUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33003 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdCXHbb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Mar 2017 03:31:31 -0400
Received: by mail-vk0-f42.google.com with SMTP id d188so6626674vka.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Mar 2017 00:31:30 -0700 (PDT)
In-Reply-To: <CAAXqJ+omQh-sSv06i0Wo50JEVzGsin7Zoe4zKYTW9q=Eu_QUUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Spandan,

Please do not email me privately, instead use the public mailing list,
which allows other developers to provide you help if I am unable to do
so. it also means that you can start interacting with the rest of the
community instead of only me (barely useful).

On Fri, Mar 24, 2017 at 2:38 PM, Spandan Kumar Sahu
<spandankumarsahu@gmail.com> wrote:
> Hi
>
> I couldn't figure out, why is this happening,
>
> "...Because once any of the storage device assigned to a storage pool is
> full, the whole pool is not writeable anymore, even there is abundant space
> in other devices."
> -- Ceph GSoC Project Ideas (Smarter reweight-by-utilisation)
>
> I went through this[1] paper on CRUSH, and according to what I understand,
> CRUSH pseudo-randomly chooses a device based on weights which can reflect
> various parameters like the amount of space available.

CRUSH is a variant of consistent hashing. Ceph cannot automatically
choose *another* OSD which is not chosen by CRUSH, even if that OSD is
not full and has abundant space.

>
> What I don't understand is, how will it stop a pool having abundant space on
> other devices, from getting selected, if one of its devices is full? Sure,
> the chances of getting selected might decrease, if one device is full, but
> how does it completely prevent writing to the pool?

if a PG are served by three OSDs. if any of them is full, how can we
continue creating/writing to objects which belong to that PG?


-- 
Regards
Kefu Chai
