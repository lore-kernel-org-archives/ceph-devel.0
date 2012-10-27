From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Using asphyxiate with Doxygen and Java?
Date: Fri, 26 Oct 2012 18:52:44 -0700
Message-ID: <508B3E6C.90308@inktank.com>
References: <CAPrxi59wA80DbvwekCDYP5+1jHsAp9=uCn5J0_Mqqx6rZ9MHeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:57168 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758292Ab2J0Bwu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 21:52:50 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1550772dak.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 18:52:50 -0700 (PDT)
In-Reply-To: <CAPrxi59wA80DbvwekCDYP5+1jHsAp9=uCn5J0_Mqqx6rZ9MHeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Tommi Virtanen <tv@eagain.net>

On 10/26/2012 06:26 PM, Noah Watkins wrote:
> I stumbled upon Breathe, and then asphyxiate. The doxygenfile
> directive in the later doesn't seem to like what Doxygen produces from
> parsing JavaDoc markup, although I've read that the Doxygen produced
> should be compliant. Here is the error:
>
>     AssertionError: cannot handle compounddef kind=class

Asphyxiate was written quickly to handle most of the markup used in
the librados C API documentation. Of course, this didn't include any
classes. It shouldn't be too difficult to add support for them,
or other markup, to asphyxiate. I can help with this if you like.

> Before going any further and I wanted to ping the list to see if
> anyone thinks it would be a good/bad idea to look into this. It'd be
> nice to have the Java documentation in Sphinx seamlessly. Any change
> Breathe has gotten faster over time?

It doesn't look like there's been much activity there in the last year.

> THanks,
> Noah
