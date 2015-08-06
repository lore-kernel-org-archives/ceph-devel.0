From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: [ANN] ceph-deploy 1.5.27 released
Date: Wed, 5 Aug 2015 21:22:43 -0700
Message-ID: <CACkq2mp2O3-gc=X_0nmjr96LWZz+T6VmKPmgCnvWVpoL80MoSA@mail.gmail.com>
References: <CACkq2mqgjP-J3CFM0zA8uoXbi1oPjni8JbtTwvvE5K0hSDTQig@mail.gmail.com>
 <mpum4o$4ud$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35542 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbHFEXG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 00:23:06 -0400
Received: by obbop1 with SMTP id op1so47379354obb.2
        for <ceph-devel@vger.kernel.org>; Wed, 05 Aug 2015 21:23:03 -0700 (PDT)
In-Reply-To: <mpum4o$4ud$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nigel Williams <nigel.williams@utas.edu.au>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Nigel,

On Wed, Aug 5, 2015 at 9:00 PM, Nigel Williams
<nigel.williams@utas.edu.au> wrote:
> On 6/08/2015 9:45 AM, Travis Rhoden wrote:
>>
>> A new version of ceph-deploy has been released. Version 1.5.27
>> includes the following:
>
>
> Has the syntax for use of --zap-disk changed? I moved it around but it is no
> longer recognised; worked around by doing a ceph-disk zap before running
> ceph-deploy.

A few things in this area changed with 1.5.26. ceph-deploys options
are much more strictly attached only to the commands where they make
sense.

>
> This worked previously:
>
> ceph-deploy --overwrite-conf osd --zap-disk prepare ceph05:/dev/sdb:/dev/sdd

--zap-disk is an option to 'prepare', not to 'osd'.  "ceph-deploy osd
--zap-disk list" doesn't make any sense, for example.  The help menus
should make this clear:

# ceph-deploy osd --help
usage: ceph-deploy osd [-h] {list,create,prepare,activate} ...

# ceph-deploy osd prepare --help
usage: ceph-deploy osd prepare [-h] [--zap-disk] [--fs-type FS_TYPE]
                               [--dmcrypt] [--dmcrypt-key-dir KEYDIR]
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
