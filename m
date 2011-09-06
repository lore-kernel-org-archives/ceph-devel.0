From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph kernel client cache
Date: Tue, 6 Sep 2011 09:53:06 -0700
Message-ID: <CAF3hT9By5rDBkz466ehDV0i3__v9zc0pEpJGQrjMDefRgcpn6w@mail.gmail.com>
References: <CAMwsgzNY10oX5J7ThthvUT+eiVFZPS6pEwkH=n99iUtvy4mKxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33933 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290Ab1IFQxH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2011 12:53:07 -0400
Received: by ywf7 with SMTP id 7so4147595ywf.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2011 09:53:07 -0700 (PDT)
In-Reply-To: <CAMwsgzNY10oX5J7ThthvUT+eiVFZPS6pEwkH=n99iUtvy4mKxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mowang da <whooya.xxl@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/9/5 mowang da <whooya.xxl@gmail.com>:
> Hi
> l tested ceph kernel client rereading with the latest version,I found
> no effect of cache=A3=ACbut in this case, only one client reading.
>  each read, the program is to free up cache=A3=ACThis is correct?
I'm not sure what you mean by this. What tests did you run, what were
the results, and what did you expect to have happen?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
