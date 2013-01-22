From: Neil Levine <neil.levine@inktank.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 11:35:50 -0800
Message-ID: <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
	<50FEDE7A.5070307@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:50806 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab3AVTfw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 14:35:52 -0500
Received: by mail-vb0-f50.google.com with SMTP id ft2so6513794vbb.9
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 11:35:50 -0800 (PST)
In-Reply-To: <50FEDE7A.5070307@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

Out of interest, would people prefer that the Ceph deployment script
didn't try to handle server-server file copy and just did the local
setup only, or is it useful that it tries to be a mini-config
management tool at the same time?

Neil

On Tue, Jan 22, 2013 at 10:46 AM, Xing Lin <xinglin@cs.utah.edu> wrote:
> If it is the command 'mkcephfs' that asked you for ssh password, then that
> is probably because that script needs to push some files (ceph.conf, e.g) to
> other hosts. If we open that script, we can see that it uses 'scp' to send
> some files. If I remember correctly, for every osd at other hosts, it will
> ask us ssh password seven times. So, we'd better set up public key first. :)
>
> Xing
>
>
> On 01/22/2013 11:24 AM, Gandalf Corvotempesta wrote:
>>
>> Hi all,
>> i'm trying my very first ceph installation following the 5-minutes
>> quickstart:
>> http://ceph.com/docs/master/start/quick-start/#install-debian-ubuntu
>>
>> just a question: why ceph is asking me  for SSH password? Is ceph
>> trying to connect to itself via SSH?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
