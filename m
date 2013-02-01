From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadowGW and multiple parts upload
Date: Fri, 1 Feb 2013 10:44:23 -0800
Message-ID: <CAC-hyiHERjdtY5ZN1PqFhVqz_pXOMN0hL6Va3FO7atGD07uc1g@mail.gmail.com>
References: <CAJH6TXgfL8CVKyV71fsobi6e=AxOWZczbZa-TjosYodGJCbzEg@mail.gmail.com>
	<CAC-hyiHi-GoPcjj+A08OjKdsQZiLf6c02mdyC+zPxT5jnU2CSA@mail.gmail.com>
	<CAJH6TXjeUAVdFosZTiuxeePUOVhLfXiZ_iQ-VfM-boC1fNyCbA@mail.gmail.com>
	<CAC-hyiEJd-zwtU5oeKBTeAyfN832TqZE3aPZmcGSe_O8iU2=pg@mail.gmail.com>
	<CAJH6TXgqaP59Ph4dRUYK75AfFeAhcZWTxEse55v9LnCniUFg2g@mail.gmail.com>
	<CAC-hyiGFfafct0zNnX4+N9y-Eaw9sjsgmoVyn4heTN7hhzfwXw@mail.gmail.com>
	<CAJH6TXiU2QG-5DzaL6dOzQYO9APb+2HsDa+fpvWvTBg-D=Oacg@mail.gmail.com>
	<CAC-hyiHkSC-9Y3_hhqtNBth5_RmTDZQS3wBbDriewtQDJtgL-A@mail.gmail.com>
	<CAJH6TXjq8or0ByvWWJRNX4i9Yy+CXm3=hwUbPYPmKFCA3t2drw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61725 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669Ab3BASoY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 13:44:24 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so3708775ieb.23
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 10:44:23 -0800 (PST)
In-Reply-To: <CAJH6TXjq8or0ByvWWJRNX4i9Yy+CXm3=hwUbPYPmKFCA3t2drw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

Then I think the next step would be to take tcp dump on the apache side.

On Fri, Feb 1, 2013 at 10:32 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> I'm using apache with your fastcgi module.
>
> Il giorno 01/feb/2013 19:31, "Yehuda Sadeh" <yehuda@inktank.com> ha scritto:
>
>> The client can hang up the sending side of the socket, while still
>> receiving data. It can also be an issue with some other middleman.
>> Which web server are you using, which fastcgi module?
>>
>> On Fri, Feb 1, 2013 at 10:26 AM, Gandalf Corvotempesta
>> <gandalf.corvotempesta@gmail.com> wrote:
>> > I don't think this is a client issue because if client disconnect early
>> > no
>> > request is made and no error 400 will be sent.
>> >
>> > How will you send a response if no request is made?
>> >
>> > Il giorno 01/feb/2013 19:19, "Yehuda Sadeh" <yehuda@inktank.com> ha
>> > scritto:
>> >
>> >> On Fri, Feb 1, 2013 at 9:51 AM, Gandalf Corvotempesta
>> >> <gandalf.corvotempesta@gmail.com> wrote:
>> >> > 2013/2/1 Yehuda Sadeh <yehuda@inktank.com>:
>> >> >> Can you get just the sequence that fails (not the entire history)?
>> >> >
>> >> > Is the following enough?
>> >> > http://pastebin.com/CS4MwdRf
>> >>
>> >>
>> >> From what I can see, it looks like it's just receiving part of the
>> >> expected data, might be the client disconnects early.
>> >>
>> >> Yehuda
