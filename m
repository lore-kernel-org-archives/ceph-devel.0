From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/4] libceph: use the right footer size when skipping a
 message
Date: Sat, 20 Feb 2016 14:15:33 -0600
Message-ID: <56C8C965.4010602@ieee.org>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
 <1455986729-12544-3-git-send-email-idryomov@gmail.com>
 <56C8B40D.90602@ieee.org>
 <CAOi1vP-3TvUMVL+SMcagJ_wf1RE7Z3PbeUhUzUvOUJkX+1D_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35754 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcBTUPg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 15:15:36 -0500
Received: by mail-io0-f173.google.com with SMTP id g203so142191297iof.2
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 12:15:35 -0800 (PST)
In-Reply-To: <CAOi1vP-3TvUMVL+SMcagJ_wf1RE7Z3PbeUhUzUvOUJkX+1D_Ww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Varada Kari <Varada.Kari@sandisk.com>

On 02/20/2016 02:05 PM, Ilya Dryomov wrote:
>>> >>
>>> >> +static size_t sizeof_footer(struct ceph_connection *con)
>> >
>> > I understand why this is named this way.  But it's supplying a
>> > connection as argument, but a footer is a message attribute.
>> > So I might call this con_msg_footer_size().
> The *size* of footer is a connection attribute though ;)

Yeah, I know.  That's why I suggested the con_msg_***().
But in any case, the code looks correct regardless of the
name.

					-Alex
