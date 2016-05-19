From: Milosz Tanski <milosz@adfin.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW2NlcGgvY2VwaF0gV2lwIGFkZCBmbGFzaGNhY2hlICgjODc3Myk=?=
Date: Thu, 19 May 2016 12:58:49 -0400
Message-ID: <CANP1eJGUyw8YpmbKV7PQmDa7CD3ucY2u_GT9f-phFYQRB3idSg@mail.gmail.com>
References: <ceph/ceph/pull/8773@github.com>
	<ceph/ceph/pull/8773/c217543554@github.com>
	<3858597F7658604DB90E3F60F716249C047A8EB8@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33896 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbcESQ6v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 12:58:51 -0400
Received: by mail-lf0-f50.google.com with SMTP id m64so39714835lfd.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 09:58:50 -0700 (PDT)
In-Reply-To: <3858597F7658604DB90E3F60F716249C047A8EB8@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Houlinfei <hou.linfei@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 19, 2016 at 7:51 AM, Houlinfei <hou.linfei@h3c.com> wrote:
>
>
> Hi, the main ceph-disk interface added is part of the prepare. We add=
 fcache, fcache_size, fcache-uuid optional arguments. These are the onl=
y external interface. When you want to use flashcache, you must specify=
 flashcache disk and flashcache size such as
> ceph-disk prepare --fcache /dev/sdc --fcache_size 10 /dev/sda.
> I think we could add bcache and dm-cache in the same way if needed. W=
hat do you think?
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Sage Weil [mailto:notifications@github.c=
om]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2016=E5=B9=B45=E6=9C=887=E6=97=A5=
 3:58
> =E6=94=B6=E4=BB=B6=E4=BA=BA: ceph/ceph
> =E6=8A=84=E9=80=81: houlinfei 11802 (RD); Author
> =E4=B8=BB=E9=A2=98: Re: [ceph/ceph] Wip add flashcache (#8773)
>
> I think we want to make this more generic so that we can layer in any=
 caching option (flashcache, bcache, dm-cache). Can you send an email t=
o ceph-devel with the proposed ceph-disk interface change so we can get=
 feedback and settle one the approach? Thanks!


I think it's important to think about how these block caching
solutions handle O_DIRECT. Bluestore uses O_DIRECT + libaio which
bypasses the normal kernel (page) caches. I actually don't know the
answer to it but I think it's valuable to figure out if any of the
above are bypassed in the O_DIRECT case.

--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
