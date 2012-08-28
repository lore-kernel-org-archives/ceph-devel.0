From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 14:20:54 -0700
Message-ID: <503D3636.40609@inktank.com>
References: <503D0A00.2080905@inktank.com> <20120828203235.45f1e3a5@dieter-t420s> <503D3214.4000503@hastexo.com> <CADvuQRHs_t0WT_eERPP_1Eb3wTM0yX5_v+WW3rRnY3JqWw2-3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51654 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab2H1VU5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 17:20:57 -0400
Received: by pbbrr13 with SMTP id rr13so10074079pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 14:20:57 -0700 (PDT)
In-Reply-To: <CADvuQRHs_t0WT_eERPP_1Eb3wTM0yX5_v+WW3rRnY3JqWw2-3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Plaetinck, Dieter" <dieter@vimeo.com>, Ross Turk <ross@inktank.com>

On 08/28/2012 02:15 PM, Tommi Virtanen wrote:
> On Tue, Aug 28, 2012 at 5:03 PM, Florian Haas <florian@hastexo.com> wrote:
>> I for my part, in the documentation space, would love for the admin
>> tools to become self-documenting. For example, I would love a "help"
>> subcommand at any level of the ceph shell, listing the supported
>> subcommands in that level. As in "ceph help", "ceph mon help", "ceph osd
>> getmap help".
>>
>> Even better, the ceph shell could support a general-purpose hook that
>> bash-completion can use (kind of like "hg" does in Mercurial), and this
>> and the above-conjectured help facility could arguably share quite a bit
>> of code.
>
> I would love to see all of that. But, a lot of the "ceph" tool
> functionality is implemented by shoveling strings in and out of the
> monitors. It largely doesn't understand what's happening.

It doesn't need to understand what's happening to give basic usage info 
though - the monitors can provide that themselves in the short term
while we don't have an admin api like you describe below.

I added a feature request for this a little while back:

http://www.tracker.newdream.net/issues/2894

> If we were to redo that from scratch, I'd convert that to have some
> sort of API to monitors, and make the cli understand all the relevant
> things. Understandably, that can feel a little bit more rigid; to add
> a command means adding it to both the server and a client, where as
> currently the client is very very generic.

