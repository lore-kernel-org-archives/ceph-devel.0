From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 17:15:41 -0400
Message-ID: <CADvuQRHs_t0WT_eERPP_1Eb3wTM0yX5_v+WW3rRnY3JqWw2-3A@mail.gmail.com>
References: <503D0A00.2080905@inktank.com> <20120828203235.45f1e3a5@dieter-t420s>
 <503D3214.4000503@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54543 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab2H1VQD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 17:16:03 -0400
Received: by vbbff1 with SMTP id ff1so6311682vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 14:16:02 -0700 (PDT)
In-Reply-To: <503D3214.4000503@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Plaetinck, Dieter" <dieter@vimeo.com>, Ross Turk <ross@inktank.com>

On Tue, Aug 28, 2012 at 5:03 PM, Florian Haas <florian@hastexo.com> wrote:
> I for my part, in the documentation space, would love for the admin
> tools to become self-documenting. For example, I would love a "help"
> subcommand at any level of the ceph shell, listing the supported
> subcommands in that level. As in "ceph help", "ceph mon help", "ceph osd
> getmap help".
>
> Even better, the ceph shell could support a general-purpose hook that
> bash-completion can use (kind of like "hg" does in Mercurial), and this
> and the above-conjectured help facility could arguably share quite a bit
> of code.

I would love to see all of that. But, a lot of the "ceph" tool
functionality is implemented by shoveling strings in and out of the
monitors. It largely doesn't understand what's happening.

If we were to redo that from scratch, I'd convert that to have some
sort of API to monitors, and make the cli understand all the relevant
things. Understandably, that can feel a little bit more rigid; to add
a command means adding it to both the server and a client, where as
currently the client is very very generic.

>> and also integration with CM like puppet/chef
> +1, although people are already working on both. So maybe this is just
> about the need to tell more people about that. :)

Please do give constructive feedback on

http://ceph.com/docs/master/install/chef/
http://ceph.com/docs/master/config-cluster/chef/
