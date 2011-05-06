From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: rbd and Metaserver
Date: Thu, 5 May 2011 23:02:17 -0700
Message-ID: <BANLkTimuVAJS197twGV8=FT1_7+DxwgWcw@mail.gmail.com>
References: <4DC2DB6E.9010500@ufm.su>
	<2000619B57A3492DBDFCA82B0843792D@gmail.com>
	<BANLkTim-7Y5DKQ+O3o4_cUbvjZ9kYghAQA@mail.gmail.com>
	<Pine.LNX.4.64.1105052054060.14021@cobra.newdream.net>
	<BANLkTi=rZ6L_V0NqBe6Vi7JuJh6P2CZBkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64808 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab1EFGCS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 02:02:18 -0400
Received: by vxi39 with SMTP id 39so3088760vxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 23:02:18 -0700 (PDT)
In-Reply-To: <BANLkTi=rZ6L_V0NqBe6Vi7JuJh6P2CZBkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Thu, May 5, 2011 at 10:57 PM, tsk <aixt2006@gmail.com> wrote:
> Hi =A0Sage,
>
> If I use librados:
>
> =A0 =A0int create(const std::string& oid, bool exclusive);
> =A0 =A0int write(const std::string& oid, bufferlist& bl, size_t len, =
uint64_t off);
> =A0 =A0int read(const std::string& oid, bufferlist& bl, size_t len, u=
int64_t off);
>
> MDS is not required to be running either?

Sage can verify but as I understand it, all rados clients need is the
osd map from the mon server.
In other systems, that might be considered 'metadata', but in ceph,
the 'metadata' server (MDS) tracks filesystem metadata.


>
> What does the oid mean, =A0is there any relation between oid and the
> object file name when it's dropped into an OSD server, like
> "current/0.c5_head/10000000004.000001ba_head"?
>
>
> Thx very much!
>
>
> 2011/5/6 Sage Weil <sage@newdream.net>:
>> On Fri, 6 May 2011, tsk wrote:
>>> 2011/5/6 Gregory Farnum <gregory.farnum@dreamhost.com>:
>>> > Nope, the MDS is only required for the POSIX-compliant Ceph layer=
=2E
>>> > -Greg
>>>
>>> May I know that who will maintain the rbd_image_info if there is no=
 MDS?
>>> From where, the api int rbd_list(rados_ioctx_t io, char *names, siz=
e_t
>>> *size) =A0will get the data it want?
>>
>> The rbd image header is stored as just another object in the object =
store.
>>
>> sage
>>
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
