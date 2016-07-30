From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Sat, 30 Jul 2016 16:32:18 +0200
Message-ID: <CAOi1vP8htpHTwuxQo-_ie51FmoiqTVNVvkhyxNB1HuWDxRPHBQ@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
 <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
 <CAOi1vP_HwML=7+iZrJFzJpbRcSomKBX5r8RT2hnRGF23agN1FQ@mail.gmail.com>
 <CAE2NFgVVth4BRQNCy6SFOnLnLf0NQ=kgoHcuMLpnz5beG3w-nQ@mail.gmail.com>
 <CAOi1vP8fg4cmAvOOKQWZUcvNpiQ5CzpVr1q=rjhtTjasa85msQ@mail.gmail.com>
 <CAE2NFgXvtZYzD9EGp+GHxcSndS3AoKyvpZkwdmsTr2rB9KF__w@mail.gmail.com>
 <CAOi1vP_7dHOVnxTHEhfYsiXQGvd+e8ecsPf10cg0s33Ry4Vt9Q@mail.gmail.com>
 <CAOi1vP_X=60SHQzJ4v2yZ4JypYgXm+r3GNHn0_7tZkRcte-v3w@mail.gmail.com>
 <CAE2NFgXj0PpX0uN6RGNuXquwkmBncr7KHANaSK6c8SAVTWUVLQ@mail.gmail.com>
 <CAOi1vP-4ua0y=XAraG-wfGaj-5Y9tZ+XnExza3pt_oWceL-eGQ@mail.gmail.com>
 <CALXUmNTwDOKZm=S6mkA4=HzM8H=pHWSuX1VwJZg3dtTRd9e8Tw@mail.gmail.com>
 <CALXUmNQrmPGexE5_ArBwnK2pgOKr2WKfM_hqZRX4_RZ_z6aTkQ@mail.gmail.com>
 <CALXUmNS0dtX5T3++8JgtoWoBHVGB-Bgh+BZpqYiARtMG3qJVCA@mail.gmail.com>
 <CAFXAJ64a9KqF5A+f6BZsD_LtGUniqya+Wz0oMtcaLhxrnW1TFA@mail.gmail.com>
 <CALXUmNSkR92CYWX4DU37RuiwHm-nubYxq0egQPpnBqN-7=VTwg@mail.gmail.com> <CALXUmNSsZF5LNkqVjhpEV8anyiaZ=9S4MATT2PHdU59Jgj6wsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38255 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbcG3OcV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2016 10:32:21 -0400
Received: by mail-wm0-f45.google.com with SMTP id o80so187140456wme.1
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2016 07:32:20 -0700 (PDT)
In-Reply-To: <CALXUmNSsZF5LNkqVjhpEV8anyiaZ=9S4MATT2PHdU59Jgj6wsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Payno <vpayno@gaikai.com>
Cc: Cliff Pajaro <cpajaro@gaikai.com>, Patrick McLean <patrickm@gaikai.com>, Ceph Development <ceph-devel@vger.kernel.org>, Roderick Colenbrander <roderick@gaikai.com>, Rae Yip <ryip@gaikai.com>, Frank Reed <freed@gaikai.com>

On Sat, Jul 30, 2016 at 1:11 AM, Victor Payno <vpayno@gaikai.com> wrote:
> Thanks for the info on the 510 snapshot per rbd kernel limit.
>
> We're also wondering what the rbd metadata limits might be. Are the
> metadata key and value size limitations listed anywhere?
>
> We're planning on using key names with 64 characters (the same string
> as the snapshot name) with a string json payload in the value field.
>
> So on on an rbd with with 100 snapshots, we would also have 100
> metadata key/value pairs. The value/data would probably be at least
> 100 characters per key.

Those key/value numbers are reasonable.  I don't think there are any
particular librbd-imposed limits: image metadata is stored as omap on
the header object, so anything that could be stored in omap is fine.

The kernel client doesn't care.  Contrary to the snapshot info, image
metadata is never accessed.

Thanks,

                Ilya
