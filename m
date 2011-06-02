From: biyan chen <riby.chen@gmail.com>
Subject: Re: write file problems
Date: Thu, 2 Jun 2011 17:36:43 +0800
Message-ID: <BANLkTinZLaESH6pMkb7PAoKDaW9b72S-YA@mail.gmail.com>
References: <BANLkTimbwCo1yJ3vJ5qc6QbELAdZdwZGHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60039 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932883Ab1FBJgp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 05:36:45 -0400
Received: by gwaa18 with SMTP id a18so257683gwa.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2011 02:36:44 -0700 (PDT)
In-Reply-To: <BANLkTimbwCo1yJ3vJ5qc6QbELAdZdwZGHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sorry!

command:
   time dd if=3D/dev/zero of=3Dmmm bs=3D8k count=3D100


2011/6/2 biyan chen <riby.chen@gmail.com>:
> Ceph file systems, write file will be no reaction, namely dead state
>
> For example:
>
> Dd if =3D / a dev/zero of =3D MMM bs =3D 8k =3D 100 count
>
>
> Will have been waiting!
>
>
> And then other SSH window using command "ls -al" is no  reaction!
>
>
> Thanks!
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
