From: Tommi Virtanen <tv@inktank.com>
Subject: Re: cephfs: one cause of mount error 5 = Input/output error
Date: Thu, 2 Aug 2012 08:46:41 -0700
Message-ID: <CADvuQRENc8M_RBwxAjnnZ+DfNsDRwPkD26S1b+PCKjvZ_MvNhQ@mail.gmail.com>
References: <CAKG+gh-kgwFADFkXQZ+6vrMg+MUwSTDVxeM9hKTUbunov50H_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63504 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2HBPrC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 11:47:02 -0400
Received: by vbbff1 with SMTP id ff1so8249890vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 08:47:02 -0700 (PDT)
In-Reply-To: <CAKG+gh-kgwFADFkXQZ+6vrMg+MUwSTDVxeM9hKTUbunov50H_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 2, 2012 at 7:54 AM, =E8=94=A1=E6=AC=8A=E6=98=B1 <chuanyu@cs=
=2Enctu.edu.tw> wrote:
> I've found that a cause of Input/output error when I mount the cephfs=
,
> however, I'm not sure which part should be improved ( perhaps me ),
> but this error would occur when your client has more than 1 network a=
ddress.

To my knowledge no part of Ceph does IP-based accepting/rejecting of
connections. The log for the failure case showed no actual reason for
the failure. I don't think we've reached the full explanation of your
symptoms yet.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
