From: Gregory Farnum <greg@inktank.com>
Subject: Re: Can't start ceph mon
Date: Mon, 26 Nov 2012 15:04:32 -0800
Message-ID: <CAPYLRzjf1_7QJJStTbUzrL_XdP4+7_uMQq=mURxQARmpJLysbg@mail.gmail.com>
References: <50ABC929.3000107@bob-the-boat.me.uk>
	<CAPYLRzg_X2ipWLQeOkLE=hJ-_r9W-eS4=SWdQO525R58PpJxtg@mail.gmail.com>
	<50ABD056.5040103@bob-the-boat.me.uk>
	<CAPYLRzg5EpfKqg3XNYGeWm9stNLXzpMenOdm+p6j1PafRNeNBg@mail.gmail.com>
	<50ABD284.1060309@bob-the-boat.me.uk>
	<CAPYLRzgGrBaL7Ny7-e7QxhTASXUFtPapGWZ2xUm7cTPhhTKbuQ@mail.gmail.com>
	<50ABD518.3030900@bob-the-boat.me.uk>
	<0F20B62A6EC54AD7A6845CB7BD2714B2@inktank.com>
	<50AF32E9.2060809@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec517a9b2d2ab8904cf6df45f
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:46246 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755876Ab2KZXEf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 18:04:35 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so8499622iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 15:04:34 -0800 (PST)
In-Reply-To: <50AF32E9.2060809@bob-the-boat.me.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--bcaec517a9b2d2ab8904cf6df45f
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 12:25 AM, Dave (Bob) <dave@bob-the-boat.me.uk> wrot=
e:
> Greg,
>
> Is there any news on this?
>
> David

Hurray, there is! Your "latest" stashed version of the PGMap got
corrupted; knowing that helped me to track down a bug =97 we weren't
checking the return value of an fsync! Fixes to prevent this situation
in the future are coming shortly; in the mean time I managed to create
a replacement PGMap for you that *should* make things right in the
world again. Note that it's just blank, so some of your statistics
reporting will be wonky for a little while (but all the data is
replaceable and will be filled in gradually by the OSDs).
Take the attached "new_latest" file and replace the file at
"mon.vault01/pgmap/latest" with it, then restart your monitor and
everything should be good! Let me know if it's not.
-Greg

--bcaec517a9b2d2ab8904cf6df45f
Content-Type: application/octet-stream; name=new_latest
Content-Disposition: attachment; filename=new_latest
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ha07dkh80

BAQgAAAACNUAAgAAAAAAAAAAAAAAAD8AAAAAAAAAMzNzP5qZWT8=
--bcaec517a9b2d2ab8904cf6df45f--
