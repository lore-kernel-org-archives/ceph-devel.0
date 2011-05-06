From: tsk <aixt2006@gmail.com>
Subject: Re: rbd and Metaserver
Date: Fri, 6 May 2011 13:57:32 +0800
Message-ID: <BANLkTi=rZ6L_V0NqBe6Vi7JuJh6P2CZBkA@mail.gmail.com>
References: <4DC2DB6E.9010500@ufm.su>
	<2000619B57A3492DBDFCA82B0843792D@gmail.com>
	<BANLkTim-7Y5DKQ+O3o4_cUbvjZ9kYghAQA@mail.gmail.com>
	<Pine.LNX.4.64.1105052054060.14021@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53339 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab1EFF5e convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 01:57:34 -0400
Received: by wwk4 with SMTP id 4so85520wwk.1
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 22:57:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105052054060.14021@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

Hi  Sage,

If I use librados:

    int create(const std::string& oid, bool exclusive);
    int write(const std::string& oid, bufferlist& bl, size_t len, uint6=
4_t off);
    int read(const std::string& oid, bufferlist& bl, size_t len, uint64=
_t off);

MDS is not required to be running either?

What does the oid mean,  is there any relation between oid and the
object file name when it's dropped into an OSD server, like
"current/0.c5_head/10000000004.000001ba_head"?


Thx very much!


2011/5/6 Sage Weil <sage@newdream.net>:
> On Fri, 6 May 2011, tsk wrote:
>> 2011/5/6 Gregory Farnum <gregory.farnum@dreamhost.com>:
>> > Nope, the MDS is only required for the POSIX-compliant Ceph layer.
>> > -Greg
>>
>> May I know that who will maintain the rbd_image_info if there is no =
MDS?
>> From where, the api int rbd_list(rados_ioctx_t io, char *names, size=
_t
>> *size) =C2=A0will get the data it want?
>
> The rbd image header is stored as just another object in the object s=
tore.
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
