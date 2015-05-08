From: Gregory Farnum <greg@gregs42.com>
Subject: Re: No rule to make target `../src/gmock/lib/libgmock_main.la'
Date: Thu, 7 May 2015 21:57:57 -0700
Message-ID: <CAC6JEv_dBdhqgXkaqULm-6xumQRJJVjUCFE_nV3wkr3CMC8bag@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166435336@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38008 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbEHE56 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 00:57:58 -0400
Received: by igbhj9 with SMTP id hj9so12286539igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2015 21:57:58 -0700 (PDT)
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com. [209.85.213.173])
        by mx.google.com with ESMTPSA id q11sm3087295igr.3.2015.05.07.21.57.57
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 21:57:57 -0700 (PDT)
Received: by iget9 with SMTP id t9so24363488ige.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2015 21:57:57 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166435336@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

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
