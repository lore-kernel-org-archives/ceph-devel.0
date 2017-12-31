From: kefu chai <tchaikov@gmail.com>
Subject: Re: Moving to 1.66 Boost
Date: Sun, 31 Dec 2017 13:30:07 +0800
Message-ID: <CAJE9aOMaKpOyy180hSV39eebnpWShWHE821qT00WmYXgnqbFxw@mail.gmail.com>
References: <b4b3abf8-d7db-7037-a589-38c9563f078c@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46874 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdLaFaI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 31 Dec 2017 00:30:08 -0500
Received: by mail-qt0-f194.google.com with SMTP id r39so57975127qtr.13
        for <ceph-devel@vger.kernel.org>; Sat, 30 Dec 2017 21:30:08 -0800 (PST)
In-Reply-To: <b4b3abf8-d7db-7037-a589-38c9563f078c@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

+ ceph-devl

On Wed, Dec 27, 2017 at 5:47 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi Kefu,
>
> In FreeBSD the portmanager of Boost wants to move to 1.66, and so normally
> they do a test run on all 33.000 ports to see what breaks.
>
> Now one of the things that breaks is Ceph, but i a way I do not
> understand...
>
> When linking ceph-common references to the /usr/local/lib/libboost_*.so
> files on Boost 1.65 are now replaced by -lBoost::thread invocations 1.66??

could you pastebin the error message? Boost::thread is the library name. but I
don't think it can be passed to the linker. if you see this in the
command line,
something is wrong.

> Probably this is due to the fact that CMake also upgraded to 3.10.1 to make
> it aware of Boost 1.66.
>
> Any suggestions on why this changes could be?
>
> Thanx,
> --WjW
>



-- 
Regards
Kefu Chai
