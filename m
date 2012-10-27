From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: Using asphyxiate with Doxygen and Java?
Date: Sat, 27 Oct 2012 08:57:24 -0700
Message-ID: <508C0464.7060307@inktank.com>
References: <CAPrxi59wA80DbvwekCDYP5+1jHsAp9=uCn5J0_Mqqx6rZ9MHeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:62753 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759134Ab2J0P5c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Oct 2012 11:57:32 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1752363dak.19
        for <ceph-devel@vger.kernel.org>; Sat, 27 Oct 2012 08:57:32 -0700 (PDT)
In-Reply-To: <CAPrxi59wA80DbvwekCDYP5+1jHsAp9=uCn5J0_Mqqx6rZ9MHeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

TV is of the opinion that Asphyxiate was the right
direction to move in, and that the sloth problems
are solvable, but would require work.

On 10/26/2012 6:26 PM, Noah Watkins wrote:
> I stumbled upon Breathe, and then asphyxiate. The doxygenfile
> directive in the later doesn't seem to like what Doxygen produces from
> parsing JavaDoc markup, although I've read that the Doxygen produced
> should be compliant. Here is the error:
>
>     AssertionError: cannot handle compounddef kind=class
>
> Before going any further and I wanted to ping the list to see if
> anyone thinks it would be a good/bad idea to look into this. It'd be
> nice to have the Java documentation in Sphinx seamlessly. Any change
> Breathe has gotten faster over time?

