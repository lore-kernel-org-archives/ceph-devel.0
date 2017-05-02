From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: man pages no longer compressing during install?
Date: Tue, 2 May 2017 18:30:42 +0200
Message-ID: <ec370409-4a0e-1ff6-4559-a5e91282a8c1@digiware.nl>
References: <81511478-8a15-9cc7-73e5-84102231b1bc@digiware.nl>
 <CAJE9aONw-QhZ7ewqGQededt2CgTDFZUdA_K=ZuXaJTAi8r-+BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:26159 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdEBQbL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 2 May 2017 12:31:11 -0400
In-Reply-To: <CAJE9aONw-QhZ7ewqGQededt2CgTDFZUdA_K=ZuXaJTAi8r-+BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 2-5-2017 18:08, kefu chai wrote:
> On Sat, Apr 29, 2017 at 8:16 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> My FreeBSD port assumes that the manpages are installed compresses when
>> running `make install`.
>> That used to work, but that is no longer the case...
> 
> Willem, i don't think we used to compress manpages when doing "make install".
> 
>>
>> Now I can fix this in the package-building, but I was wondering why this
>> is an issue all of a sudden.
> 
> the last time doc/man/8/CMakeLists.txt got updated was Aug 23 13:32:47 2016.

Nope,

But your suggestion that we did discuss this before was the right
pointer. FreeBSD package building does that automagically IF the files
are in the correct location. Hence my PR to change the MANPATH.
But now the Makefile contains:
        -D CEPH_MAN_DIR:STRING=man	
Which gets the work done.

But your pointer was essential in this.
--WjW

