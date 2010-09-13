From: Mag Gam <magawake@gmail.com>
Subject: Re: Questions about ceph
Date: Mon, 13 Sep 2010 19:54:34 -0400
Message-ID: <AANLkTinWjbgm7AaDBAb=kud-=iw9ws1bRn7PMbRMpQzb@mail.gmail.com>
References: <AANLkTi=3RgYs8yE6Q+yPjEEsMvX5Bt-x9qK__WzMs_JW@mail.gmail.com>
	<4C8E458D.5030908@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35343 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0IMXye convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Sep 2010 19:54:34 -0400
Received: by gwj17 with SMTP id 17so2211099gwj.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Sep 2010 16:54:34 -0700 (PDT)
In-Reply-To: <4C8E458D.5030908@sanger.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Great.

Well, currently we are running RHEL 5.2 and I would really like to try
ceph without fuse. Is this still possible? Are there any instructions
on how to do this?



On Mon, Sep 13, 2010 at 11:38 AM, Guy Coates <gmpc@sanger.ac.uk> wrote:
> On 13/09/10 12:16, Mag Gam wrote:
>> Hello,
>>
>
> Hi Mag,
>
> One of the nice ceph features that only work with btrfs as the backin=
g
> filesystem is the sub-directory accounting;
>
> ls -ald on a directory will show the size of all the files contained
> within in, and getfattr -d directory will show the number of files an=
d
> other accounting information. =C2=A0Invaluable for large file-systems=
!
>
> Cheers,
>
> Guy
>
>
> --
> Dr. Guy Coates, Informatics System Group
> The Wellcome Trust Sanger Institute, Hinxton, Cambridge, CB10 1HH, UK
> Tel: +44 (0)1223 834244 x 6925
> Fax: +44 (0)1223 496802
>
>
> --
> =C2=A0The Wellcome Trust Sanger Institute is operated by Genome Resea=
rch
> =C2=A0Limited, a charity registered in England with number 1021457 an=
d a
> =C2=A0company registered in England with number 2742969, whose regist=
ered
> =C2=A0office is 215 Euston Road, London, NW1 2BE.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
