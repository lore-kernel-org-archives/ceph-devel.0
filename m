From: huang jun <hjwsm1989@gmail.com>
Subject: Re: use UUID mount btrfs failed
Date: Thu, 13 Oct 2011 08:03:04 +0800
Message-ID: <CABAwU-afqD=HBsp162k2SBX+zawD9yGv26KkgY8C2_14jG+ASA@mail.gmail.com>
References: <CABAwU-Z=VJ4DkVANPyw6ogMyLz1CoGxAWcTGEay0QUOodL+Yiw@mail.gmail.com>
	<CAFtEh-dwema2fWTbX_EHsPuPhK56kDiMqe5xEuev86nPCtHZRA@mail.gmail.com>
	<CABAwU-bS7gZscTkDUDTzBetSZ_v1GgQtcr0rH3VTa8Xj3ETTpA@mail.gmail.com>
	<j73j32$6fs$1@dough.gmane.org>
	<CABAwU-YKYKORm1gfWQkPeE73SYe_R=-Sg7S3+ZZnusk2miH-Cg@mail.gmail.com>
	<Pine.LNX.4.64.1110120901460.17393@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34063 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab1JMADE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 20:03:04 -0400
Received: by pzk1 with SMTP id 1so1278784pzk.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2011 17:03:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110120901460.17393@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Thomas Mueller <thomas@chaschperli.ch>, ceph-devel@vger.kernel.org

2011/10/13 Sage Weil <sage@newdream.net>:
> On Wed, 12 Oct 2011, huang jun wrote:
>> 2011/10/12 Thomas Mueller <thomas@chaschperli.ch>:
>> > On 12.10.2011 10:22, huang jun wrote:
>> >>
>> >> 2011/10/12 Damien Churchill<damoxc@gmail.com>:
>> >>>
>> >>> On 12 October 2011 02:22, huang jun<hjwsm1989@gmail.com> =A0wrot=
e:
>> >>>>
>> >>>> I use the UUID option to mount the btrfs disk,but i can not suc=
cess.
>> >>>> first, the disk is /dev/sdd1
>> >>>> then, i pull out the disk
>> >>>> and after mintues, pushed it again,at this time, it changes to =
/dev/sde1
>> >>>> at this time, if we use /etc/init.d/ceph restart, it will faile=
d, for
>> >>>> the current mount option is likely "/dev/sd** "
>> >>>> but the UUID didn't change.
>> >>>> why i can not mount it successfuly?
>
> Maybe a dumb question, but I'm assuming you've done 'btrfsctl -a' or
> 'btrfs device scan'? =A0Do you see lines like
>
> [ =A0237.100670] device fsid 78a8ca36-478b-402b-9110-b2be4915d5f3 dev=
id 1
> transid 4107 /dev/sde1
>
> with the UUID in question in the dmesg output?
>
> sage
>
>
yes,the demsg |tail show that. but i have uncomment the 'btrfsctl -a"
in /etc/init.d/ceph
maybe that isn't the problem.

thanks
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
