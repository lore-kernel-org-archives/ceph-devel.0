From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: mount errors
Date: Mon, 22 Aug 2011 21:29:34 -0700
Message-ID: <CA+qbEUPRDRDg+xz4BzhfBXk+Xi4g+VcaY76+_qjYr6FeTykQ0A@mail.gmail.com>
References: <CAJD3hpWa7VXDNcEc7sOCZWUfm84Uo4vDxZ4OceNf+6OKt7RFGA@mail.gmail.com>
	<CAJD3hpUZ6N-kkbOvjzBVFOuvpBJQ_zezXUrswqe5C8=ZBUJMjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55460 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1HWE3h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2011 00:29:37 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D1BA9C064
	for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2011 21:32:16 -0700 (PDT)
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 7F2C5C062
	for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2011 21:32:16 -0700 (PDT)
Received: by fxh19 with SMTP id 19so3685836fxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2011 21:29:34 -0700 (PDT)
In-Reply-To: <CAJD3hpUZ6N-kkbOvjzBVFOuvpBJQ_zezXUrswqe5C8=ZBUJMjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 22, 2011 at 6:11 PM, Jojy Varghese <jojy.varghese@gmail.com=
> wrote:
> Also,when i try to "mkceph" i get the error:
>
> failed: AdminSocket::bind_and_listen: failed to bind the UNIX domain
> socket to '/var/run/ceph/osd.0.asok': error 2: No such file or
> directory
>
> Could this cause a fs creation issue?
>
> -Jojy

Probably /var/run/ceph does not exist?

cheers,
Colin

>
> On Mon, Aug 22, 2011 at 6:08 PM, Jojy Varghese <jojy.varghese@gmail.c=
om> wrote:
>> Hi
>> =A0I am getting "libceph: bad fsid, had
>> e49ae577-0f7b-24e0-1c75-10ae17d9f86b got
>> 3c9b15ef-c2d0-1318-4d12-3508025ccd97" on attempting to mount the fs.
>> Any quick fixes?
>>
>> thanks
>> -Jojy
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
