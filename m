From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: cmds segfault on pdj-fstest (ceph.git unstable)
Date: Thu, 10 Jun 2010 09:11:26 -0700
Message-ID: <AANLkTikMYO91t3Y1euaFybiZLlhXq4EcTps--A-Uq0GX@mail.gmail.com>
References: <hundgq$ums$1@dough.gmane.org>
	<huqcjt$khk$1@dough.gmane.org>
	<AANLkTikoEestUHujD0_TcG0haFOcOX4pYPVodpr6NOKF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f204.google.com ([209.85.211.204]:46205 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab0FJQL2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jun 2010 12:11:28 -0400
Received: by ywh42 with SMTP id 42so146005ywh.15
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jun 2010 09:11:27 -0700 (PDT)
In-Reply-To: <AANLkTikoEestUHujD0_TcG0haFOcOX4pYPVodpr6NOKF@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: Thomas Mueller <thomas@chaschperli.ch>, ceph-devel@vger.kernel.org

Thanks guys, fixed in 8be5b029d6dc4c5a1b6314eebf026907ccaf811a and
673fdc7aa29adb0826ad71b7c8faf32e1480267b.
(Would've just pushed yours, Harry, but I didn't see it in time -- sorr=
y!)
-Greg

On Thu, Jun 10, 2010 at 4:38 AM, Henry C Chang
<henry_c_chang@tcloudcomputing.com> wrote:
>>
>> =A0 =A0add checks for being a snapshot root to dir_is_nonempty
>>
>> :040000 040000 6c45c68b84800b105299133374f0f91d82948659 2c1b290125ae=
435679ab29d6fbab7f5b8f81e4b9 M =A0 =A0 =A0src
>>
>
> I also got this segfault today. The segfault is caused by:
> _dir_is_nonempty() has already done reply_request(), but the caller,
> handle_client_unlink(), did it again.
>
> I suggest to move out reply_request() from _dir_is_nonempty(), and
> leave it to the caller.
> Maybe as below:
>
> Henry
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index 29d0a32..4a90f4e 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -3976,7 +3976,6 @@ bool Server::_dir_is_nonempty(MDRequest *mdr, C=
Inode *in)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 << dir->inode->get_projected_inode()->dir=
stat.size()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 << " on " << *dir->inode
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 << dendl;
> - =A0 =A0 =A0reply_request(mdr, -ENOTEMPTY);
> =A0 =A0 =A0 return true;
> =A0 =A0 }
>
> @@ -4070,8 +4069,10 @@ void Server::handle_client_rename(MDRequest *m=
dr)
> =A0 =A0 }
>
> =A0 =A0 // non-empty dir?
> - =A0 =A0if (oldin->is_dir() && _dir_is_nonempty(mdr, oldin))
> + =A0 =A0if (oldin->is_dir() && _dir_is_nonempty(mdr, oldin)) {
> + =A0 =A0 =A0reply_request(mdr, -ENOTEMPTY);
> =A0 =A0 =A0 return;
> + =A0 =A0}
> =A0 }
>
> =A0 // -- some sanity checks --
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
