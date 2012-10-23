From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: running without cephx
Date: Tue, 23 Oct 2012 13:22:18 -0700
Message-ID: <CAC-hyiGDzPGMUjoRJH5A1eX1C_yia0LnT2r9JeJNSCSiE2o_4Q@mail.gmail.com>
References: <5086FAC1.3030706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61606 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964871Ab2JWUWU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 16:22:20 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1778429bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 13:22:19 -0700 (PDT)
In-Reply-To: <5086FAC1.3030706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Oct 23, 2012 at 1:14 PM, Dan Mick <dan.mick@inktank.com> wrote:
> So, I've discovered that to make "no cephx" work, you need to explicitly set
> "none" for the three options (thanks to Yehuda for the tip):
>
>         auth cluster required = none
>         auth service required = none
>         auth supported = none
>
> Since "blank" is not an error, but leads to a disagreement about
> authentication that's fairly hard to diagnose, should we make it an error to
> specify a blank entry for those items?
>
Maybe fix it so that blank entries would be equivalent to 'none'?

Yehuda
