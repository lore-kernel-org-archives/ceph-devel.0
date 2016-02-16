From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Messenger issues with Kernel RBD client
Date: Tue, 16 Feb 2016 13:04:12 +0100
Message-ID: <CAOi1vP9wygdBmFQs8tmr-qn4Es6c+T9u2LOnTVFt7svf3ifyfQ@mail.gmail.com>
References: <BLUPR0201MB19081EB79465EF9AA20A6FBCE2AD0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33330 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbcBPMER (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 07:04:17 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so188303819wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 16 Feb 2016 04:04:16 -0800 (PST)
In-Reply-To: <BLUPR0201MB19081EB79465EF9AA20A6FBCE2AD0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 16, 2016 at 11:57 AM, Varada Kari <Varada.Kari@sandisk.com> wrote:
> Hi all,
>
> Apologies for the long mail.
>
> We are testing the latest jewel branch with kernel RBD in our test
> clusters. When running some benchmark tests with various tools like
> vdbench and medusa, we are facing  io's getting timed out and some
> messenger issues when osd's in a particular node are not reachable(crashed).
>
> we simulated the same problem by killing the osds in a specific node.
> Here is some information about the use case what we are following.
> please note, steps listed are used for reproducing the problem.
>
> [...]
>
> Even retires seemed to be replied back to the client, but client is
> handling the request or not received by the libceph?
> Enabled logs on libceph end find any handle_reply messages, but they are
> present in the kernel logs for this tid, except some keep alives been
> sent to the osd. Have tried with latest stable kernel(4.4.1) to check if
> any recent fixes resolves the issues, but problem still persists.

I assume you mean aren't present?  If you have a matching set of osd
and kernel client logs, please compress and upload them somewhere so
I can take a look.

Could you try 4.5-rc4?  There is a related fix in 4.5-rc which isn't in
4.4.1 (although it's been scheduled for 4.4-stable).  4.5-rc4 would also
be easier to debug.

Thanks,

                Ilya
