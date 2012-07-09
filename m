From: Florian Haas <florian@hastexo.com>
Subject: Re: specifying secret in rbd map command
Date: Mon, 9 Jul 2012 17:13:22 +0200
Message-ID: <CAPUexz9Z5em5-gci-TpreQJP7BHo_=Te15aJxfigpCZVHHPUBQ@mail.gmail.com>
References: <CACkq2mq_shqJkq5qyq--wmh1Q32__NN=D9YJqVx6Mkx-ToHZzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49678 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab2GIPNX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 11:13:23 -0400
Received: by qaas11 with SMTP id s11so1694481qaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 08:13:22 -0700 (PDT)
In-Reply-To: <CACkq2mq_shqJkq5qyq--wmh1Q32__NN=D9YJqVx6Mkx-ToHZzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 9, 2012 at 4:57 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> Hey folks,
>
> I had a bit of unexpected trouble today using the "rbd map" command to
> map an RBD to a kernel object.  I had previously been using the "echo
> ... > /sys/bus/rbd..." method of manipulating RBDs.
>
> I was looking at the instructions here:
> http://ceph.com/docs/master/rbd/rbd-ko/
>
> When I tried to use the given syntax,  "sudo rbd map {image-name}
> --pool {pool-name} --name {client-name} --secret {client-secret}", I
> found the following:
>
> 1. {client-secret} is really supposed to be a file, not the actual
> secret.  An strace on the command shows an attempt to open a file with
> the secret as its name
> 2. If I give a keyring file as the client-secret, the command does not
> parse out the key for the given client-name.  In other words, I gave
> the name as "client.admin", then gave it the keyring file which
> contained merely
>
> [client.admin]
>         key = AQB67+BPGNX0NhAA9iK7Epcj72Jck1wOAQBetA==
>
> But the command wouldn't parse out the key.
>
> 3. I had to create a new file, containing only the text of the key,
> and pass that to the command instead.  Then everything is happy.
>
>
> I"m happy to update the docs to make this process clear.  But I wonder
> if there might be any plans to modify the command behavior to accept a
> keyring file and pull out the key belonging to specified client name.
> Either way, I can update the docs to make it clear that you are
> specifying a file, not the key string itself.

I agree. This confuses quite a few people. Specifically because the
Ceph filesystem client supports "secret" and "secretfile" as mount
options, and expects a file only in the latter case. rbd acting
differently does violate POLA in that way.

Cheers,
Florian
