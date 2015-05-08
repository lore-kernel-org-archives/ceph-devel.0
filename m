From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: No rule to make target `../src/gmock/lib/libgmock_main.la'
Date: Fri, 8 May 2015 09:37:08 -0400 (EDT)
Message-ID: <1713012883.13901760.1431092228519.JavaMail.zimbra@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166435336@SATLEXDAG01.amd.com> <CAC6JEv_dBdhqgXkaqULm-6xumQRJJVjUCFE_nV3wkr3CMC8bag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:47970 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbbEHNhN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 09:37:13 -0400
In-Reply-To: <CAC6JEv_dBdhqgXkaqULm-6xumQRJJVjUCFE_nV3wkr3CMC8bag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Tom Deneau <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

The fix is available on the master branch under commit 933332be.  You can workaround the issue by running "make check" to ensure gtest/gmock is compiled or run "configure --with-debug".

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


----- Original Message -----
From: "Gregory Farnum" <greg@gregs42.com>
To: "Tom Deneau" <tom.deneau@amd.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Friday, May 8, 2015 12:57:57 AM
Subject: Re: No rule to make target `../src/gmock/lib/libgmock_main.la'

Yeah; I see this too. It took me a while to recall but this was a
temporary bug and is resolved now. You should be able to find the fix
by going through the makefile commits, and things will work if you set
it up to build the unit tests as well.
-Greg

On Thu, May 7, 2015 at 8:24 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> I wanted to build v9.0.0 using
> I did
>         git clone http://github.com/ceph/ceph
>         git checkout v9.0.0
>         git submodule update --force --init --recursive
>         autogen; configure; make
>
> When I do so I get the following error
>
> make[3]: *** No rule to make target `../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'.  Stop.
>
> I did not have this problem when I had checked out 0.94.1
> Is there some submodule step I am missing?
>
> By the way, an rpmbuild of v9.0.0 from the tar.bz2 worked fine.
>
> -- Tom Deneau, AMD
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
