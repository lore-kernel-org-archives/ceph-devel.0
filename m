From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Query regarding storage of objects in ceph
Date: Wed, 7 Sep 2016 16:18:04 +1000
Message-ID: <20160907061804.GH5914@rskikr.localdomain>
References: <CAA8xDw2jFn_C-Cj1mZ5w9UUxNpe3Z4SeM-2=xcUPJGOg=v4R9w@mail.gmail.com>
 <CAF-wwdE0bg7vQ=HfMqzWqv5W5ZKB+3tCf2mCt6os_Jpf_tX8Ug@mail.gmail.com>
 <CAA8xDw1-BEaGmUTEhN=ZWH+uh7Dby_dxNuOh70Exy5toA9dG+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32822 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750856AbcIGGSW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2016 02:18:22 -0400
Received: by mail-pf0-f175.google.com with SMTP id g202so3191446pfb.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 23:18:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAA8xDw1-BEaGmUTEhN=ZWH+uh7Dby_dxNuOh70Exy5toA9dG+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 07, 2016 at 11:14:26AM +0530, Elita Lobo wrote:
> Hi,
> 
> Thanks , It was helpful. Could you please tell me how to trace local
> function calls made by ceph?
> I tried using gdb but it gave the following error.
> 
> https://paste.fedoraproject.org/423219/73227055/

Those errors look to be primarily because of missing debuginfo.

You can use command files in gdb or "-ex" commands on the command line to set a
breakpoint, dump a backtrace, continue and detach if you want to dump stacks
when known functions are hit. https://poormansprofiler.org/ is a good starting
point. Adding dout statements and looking at the logs can also be helpful to
understand what is going on. 

I'm sure others have more ideas.

-- 
Cheers,
Brad

> 
> On Tue, Sep 6, 2016 at 10:35 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> > On Tue, Sep 6, 2016 at 2:31 PM, Elita Lobo <loboelita@gmail.com> wrote:
> >> Hello,
> >>
> >> I am using Ceph in my research project and hence need to know a bit
> >> about how it works internally.  I would be grateful if someone would
> >> answer my queries.
> >>
> >>  When chunks of 2 objects have to be stored on an osd, are they put
> >> into the same file or are these chunks stored in separate file. Is
> >> there any way I could see this data using some command? And in which
> >> folder of the osd are they stored in?
> >
> > Working your way through this may help.
> >
> > http://cephnotes.ksperis.com/blog/2013/08/20/ceph-osd-where-is-my-data
> >
> >>
> >> Also, is there a way I can see the whole flow of function calls made
> >> when a node repair is going on?
> >>
> >> Lastly, could someone please suggest some resources ( other than docs)
> >> which would help me understand the internal implementation and give me
> >> an idea how to debug in ceph. (Attaching gdb to ceph daemons running
> >> in the background etc)
> >>
> >> Thanking you,
> >> Yours sincerely,
> >> Elita Lobo
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Cheers,
> > Brad
