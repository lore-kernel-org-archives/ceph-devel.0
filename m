From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Tue, 5 Jun 2012 07:38:32 -0700
Message-ID: <CAPrxi58SJ26mWQuu_bU1QyMp1=NSxwB57F39Jt8pai7Hz6PyBg@mail.gmail.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
	<CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
	<DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu>
	<05C460A496DC45689D6578B20D699425@inktank.com>
	<217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu>
	<9C7F8B20FB3B49508B9FBEE725AB34EE@inktank.com>
	<CAPrxi59++wux__pY1M0qu+=YcVWAbkbLVWuxa95=ZLo8R64XiA@mail.gmail.com>
	<CAHwdYF1Uhg5ZriNZBJN9xXNdLEP=gLoFRechn8OKO3dxDkUt9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47750 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab2FEOid (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 10:38:33 -0400
Received: by yenm10 with SMTP id m10so4030441yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 07:38:32 -0700 (PDT)
In-Reply-To: <CAHwdYF1Uhg5ZriNZBJN9xXNdLEP=gLoFRechn8OKO3dxDkUt9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nam Dang <namd@de.cs.titech.ac.jp>
Cc: Greg Farnum <greg@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks for testing this, Nam.

On Tue, Jun 5, 2012 at 4:22 AM, Nam Dang <namd@de.cs.titech.ac.jp> wrote:
> Hi Noah,
>
> Thank you for the push. Now I don't have SIGSEGV anymore. By the way,
> is there any way to move the ceph_is_mounted() function into the java
> library's code instead of putting it in the main Ceph's code?

The state info needed to implement ceph_is_mounted() is private, so I
think yes it does need to be in Ceph. Am I misunderstanding your
question? I am going to post the Ceph mounting patch back to the
mailing list soon, so the devs may want to change it :)

- Noah
