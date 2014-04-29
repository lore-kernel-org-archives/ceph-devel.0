From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: xio-rados-firefly branch update
Date: Mon, 28 Apr 2014 17:42:50 -0700
Message-ID: <535EF58A.5010503@inktank.com>
References: <226225586.131.1398202885165.JavaMail.root@thunderbeast.private.linuxbox.com>	<2001054477.133.1398203420696.JavaMail.root@thunderbeast.private.linuxbox.com> <CAPYLRzhE8a=bXcONNYpAH_dXO-ffgCYXheGzNWZw+OLRA2WvbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:50983 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbaD2An1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Apr 2014 20:43:27 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so6480241pbc.30
        for <ceph-devel@vger.kernel.org>; Mon, 28 Apr 2014 17:43:27 -0700 (PDT)
In-Reply-To: <CAPYLRzhE8a=bXcONNYpAH_dXO-ffgCYXheGzNWZw+OLRA2WvbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

On 04/28/2014 04:40 PM, Gregory Farnum wrote:
> The buffer changes appear to have some unnecessary Xio class
> declarations in buffer.h, and it=E2=80=99d be nice if all of that was=
 guarded
> by HAVE_XIO blocks.

buffer.h is exposed by the librados c++ api, so hopefully nothing
xio-specific really needs to be exposed there.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
