From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: ceph and network
Date: Tue, 24 May 2011 07:55:06 -0700
Message-ID: <BANLkTimTdB9zMKuLSz_BiSrCbyvBB42Q6Q@mail.gmail.com>
References: <4DDB82FF.4070100@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53243 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1EXOzG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 10:55:06 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so4988338vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 07:55:06 -0700 (PDT)
In-Reply-To: <4DDB82FF.4070100@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Tue, May 24, 2011 at 3:05 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi!
>
> I need to implement this scheme of servers connections:
>
> All servers of ceph cluster have 2 network addresses in different net=
s.
> One net - for ceph interconnect. I.e. for traffic between ceph server=
s
> (Suppose called "internal").
> One - for traffic between clients and cluster ("external").
>
> As I understand it - the client receives the address of the ceph serv=
ers
> frommon. And mon server needs to know about that it is necessary give=
 out
> "external" address, not "internal".
>
> How can I do?

There's a 'cluster addr' option which is intended to split the traffic
between multiple networks afaik.


>
> WBR,
> =A0 Fyodor.
>
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
