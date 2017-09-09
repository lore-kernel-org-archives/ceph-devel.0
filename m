From: kefu chai <tchaikov@gmail.com>
Subject: Re: [ceph-users] librados for MacOS
Date: Sun, 10 Sep 2017 02:12:33 +0800
Message-ID: <CAJE9aOMnx7u2657j2J0fVxh_mtA6aZyR-XoBk2S1=KP2H+t49g@mail.gmail.com>
References: <CANMxC7BAMJRxGPazPaUCQMs1b6SGjF2JRHG2B7KoEUBnrHUiMQ@mail.gmail.com>
 <CAF-wwdHN+No6edidKYD4iFjy1ui9bdm=1jRkftrjewJ4aDxyFg@mail.gmail.com> <a9353d6a-0404-e17a-0331-7281c6ff39ea@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36944 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdIISMe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Sep 2017 14:12:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id l9so3301011oib.4
        for <ceph-devel@vger.kernel.org>; Sat, 09 Sep 2017 11:12:34 -0700 (PDT)
In-Reply-To: <a9353d6a-0404-e17a-0331-7281c6ff39ea@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Brad Hubbard <bhubbard@redhat.com>, Martin Palma <martin@palma.bz>, ceph-devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

On Thu, Aug 3, 2017 at 4:41 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 03/08/2017 09:36, Brad Hubbard wrote:
>> On Thu, Aug 3, 2017 at 5:21 PM, Martin Palma <martin@palma.bz> wrote:
>>> Hello,
>>>
>>> is there a way to get librados for MacOS? Has anybody tried to build
>>> librados for MacOS? Is this even possible?

yes, once upon a time librados and even ceph-fuse compiled and ran[0]
fine on OSX. but since we have not worked on the port for a while, the
build is broken in master. but with this patch[1], at least librados
should build now.


--
[0] https://github.com/ceph/ceph/pull/9371
[1] https://github.com/ceph/ceph/pull/17615

>>
>> Yes, it is eminently possible, but would require a dedicated effort.
>>
>> As far as I know there is no one working on this atm.
>
> Looking at the code I've come across a few #ifdef's for OSX and sorts.
> So attempts have been tried, but I think that code has rotted.
> Now FreeBSD and MacOS have a partial similar background, so ATM I would
> expect a MacOS port not to be all complex. And build on some of the
> stuff I've done for FreeBSD. Not sure if the native compiler on Mac is
> Clang, but all Clang issues are already fixed. (If Clang on Mac is at
> least at 3.8)
>
> Liek Btad says:It does require persistence, and testing. But most
> important, it will also require maintenance.
>
> --WjW
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Regards
Kefu Chai
