From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 1/2] support for xattrs in libceph
Date: Tue, 10 May 2011 13:30:22 -0700
Message-ID: <BANLkTinBDE4wCOYiuESQaXT3bCnAwBPwLA@mail.gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
	<1305056329-482-2-git-send-email-brchrisman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47053 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1EJUaX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 16:30:23 -0400
Received: by bwz15 with SMTP id 15so5164720bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:30:22 -0700 (PDT)
In-Reply-To: <1305056329-482-2-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org, Brian Chrisman <bchrisman@gmail.com>

On Tue, May 10, 2011 at 12:38 PM, Brian Chrisman <brchrisman@gmail.com>=
 wrote:
> @@ -5708,7 +5773,7 @@ int Client::ll_removexattr(vinodeno_t vino, con=
st char *name, int uid, int gid)
> =A0 tout << name << std::endl;
>
> =A0 // only user xattrs, for now
> - =A0if (strncmp(name, "user.", 5))
> + =A0if (strncmp(name, "user.", 5) && strncmp(name, "security.", 9) &=
& strncmp(name, "trusted.", 8))
> =A0 =A0 return -EOPNOTSUPP;
>
> =A0 Inode *in =3D _ll_get_inode(vino);

Good catch. That should be applied separately, and maybe go to the
stable branch too.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
