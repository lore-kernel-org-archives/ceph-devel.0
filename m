From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Using asphyxiate with Doxygen and Java?
Date: Sat, 27 Oct 2012 13:49:47 -0700
Message-ID: <CAPrxi58iukaDOgWVb9FH-DMqGJ3KJw7a43u=03aBOKuejxWwog@mail.gmail.com>
References: <CAPrxi59wA80DbvwekCDYP5+1jHsAp9=uCn5J0_Mqqx6rZ9MHeQ@mail.gmail.com>
	<508C0464.7060307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45627 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab2J0Uts (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Oct 2012 16:49:48 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so4149076vcb.19
        for <ceph-devel@vger.kernel.org>; Sat, 27 Oct 2012 13:49:48 -0700 (PDT)
In-Reply-To: <508C0464.7060307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Great, thanks guys. I'll see how far I get extending it to handle Java elements.

On Sat, Oct 27, 2012 at 8:57 AM, Mark Kampe <mark.kampe@inktank.com> wrote:
> TV is of the opinion that Asphyxiate was the right
> direction to move in, and that the sloth problems
> are solvable, but would require work.
>
>
> On 10/26/2012 6:26 PM, Noah Watkins wrote:
>>
>> I stumbled upon Breathe, and then asphyxiate. The doxygenfile
>> directive in the later doesn't seem to like what Doxygen produces from
>> parsing JavaDoc markup, although I've read that the Doxygen produced
>> should be compliant. Here is the error:
>>
>>     AssertionError: cannot handle compounddef kind=class
>>
>> Before going any further and I wanted to ping the list to see if
>> anyone thinks it would be a good/bad idea to look into this. It'd be
>> nice to have the Java documentation in Sphinx seamlessly. Any change
>> Breathe has gotten faster over time?
>
>
