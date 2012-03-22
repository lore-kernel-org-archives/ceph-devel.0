From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: leveldb build issues in 0.44
Date: Thu, 22 Mar 2012 10:29:14 -0700
Message-ID: <CACLRD_0eLA0fj-KajQTHz3Q=1qOD_GJi67vJcB_hKN5VXGoJ9w@mail.gmail.com>
References: <4F6AE7FF02000099000DD5F9@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53172 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab2CVR3P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 13:29:15 -0400
Received: by wgbdr13 with SMTP id dr13so1563252wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 10:29:14 -0700 (PDT)
In-Reply-To: <4F6AE7FF02000099000DD5F9@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

Hmm, leveldb/include must not be in the include path.  Anyone with
some rpm experience know how to fix that?
-Sam

On Thu, Mar 22, 2012 at 7:51 AM, Nick Couchman <Nick.Couchman@seakr.com=
> wrote:
> I'm trying to build ceph 0.44, but am running into some issues with l=
eveldb not compiling correctly. =C2=A0Here is the output:
>
> make =C2=A0all-recursive
> make[2]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/sr=
c'
> Making all in ocf
> make[3]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/sr=
c/ocf'
> make[3]: Nothing to be done for `all'.
> make[3]: Leaving directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src=
/ocf'
> Making all in leveldb
> make[3]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/sr=
c/leveldb'
> make =C2=A0all-am
> make[4]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/sr=
c/leveldb'
> =C2=A0CXX =C2=A0 =C2=A0builder.o
> In file included from ./db/builder.cc:5:0:
> ./db/builder.h:8:28: fatal error: leveldb/status.h: No such file or d=
irectory
> compilation terminated.
> make[4]: *** [builder.o] Error 1
> make[4]: Leaving directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src=
/leveldb'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src=
/leveldb'
>
> If I look in the src/leveldb/include directory, I see leveldb/status.=
h, so I'm not sure why it is failing here? =C2=A0Is there a dependency =
that I'm missing somewhere? =C2=A0This is an RPM build - if I download =
the tarball and compile manually it seems to work, though I am doing th=
at on a different system, so that may not be a great test.
>
> -Nick
>
>
>
> --------
> This e-mail may contain confidential and privileged material for the =
sole use of the intended recipient. =C2=A0If this email is not intended=
 for you, or you are not responsible for the delivery of this message t=
o the intended recipient, please note that this message may contain SEA=
KR Engineering (SEAKR) Privileged/Proprietary Information. =C2=A0In suc=
h a case, you are strictly prohibited from downloading, photocopying, d=
istributing or otherwise using this message, its contents or attachment=
s in any way. =C2=A0If you have received this message in error, please =
notify us immediately by replying to this e-mail and delete the message=
 from your mailbox. =C2=A0Information contained in this message that do=
es not relate to the business of SEAKR is neither endorsed by nor attri=
butable to SEAKR.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
