From: Florian Haas <florian@hastexo.com>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 14:03:16 -0700
Message-ID: <503D3214.4000503@hastexo.com>
References: <503D0A00.2080905@inktank.com> <20120828203235.45f1e3a5@dieter-t420s>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38587 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2H1VDT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 17:03:19 -0400
Received: by pbbrr13 with SMTP id rr13so10050747pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 14:03:19 -0700 (PDT)
In-Reply-To: <20120828203235.45f1e3a5@dieter-t420s>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Plaetinck, Dieter" <dieter@vimeo.com>, Ross Turk <ross@inktank.com>

On 08/28/2012 11:32 AM, Plaetinck, Dieter wrote:
> On Tue, 28 Aug 2012 11:12:16 -0700
> Ross Turk <ross@inktank.com> wrote:
> 
>>
>> Hi, ceph-devel! It's me, your friendly community guy.
>>
>> Inktank has an engineering team dedicated to Ceph, and we want to work 
>> on the right stuff. From time to time, I'd like to check in with you to 
>> make sure that we are.
>>
>> Over the past several months, Inktank's engineers have focused on core 
>> stability, radosgw, and feature expansion for RBD. At the same time, 
>> they have been regularly allocating cycles to integration work. 
>> Recently, this has consisted of improvements to the way Ceph works 
>> within OpenStack (even though OpenStack isn't the only technology that 
>> we think Ceph should play nicely with).
>>
>> What other sorts of integrations would you like to see Inktank engineers 
>> work on?
> 
> are we only supposed to give answers wrt. integration with other software?
> if not, I would suggest to write documentation.

If I may say so, the amount of work that John has poured into this in
recent week has been incredible (http://www.ceph.com/docs/master/). So
while it's definitely not complete nor perfect, I'm sure he would
appreciate a little more specific information as to where you believe
documentation is lacking.

I for my part, in the documentation space, would love for the admin
tools to become self-documenting. For example, I would love a "help"
subcommand at any level of the ceph shell, listing the supported
subcommands in that level. As in "ceph help", "ceph mon help", "ceph osd
getmap help".

Even better, the ceph shell could support a general-purpose hook that
bash-completion can use (kind of like "hg" does in Mercurial), and this
and the above-conjectured help facility could arguably share quite a bit
of code.

> and also integration with CM like puppet/chef

+1, although people are already working on both. So maybe this is just
about the need to tell more people about that. :)

Cheers,
Florian
