From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: specifying secret in rbd map command
Date: Mon, 9 Jul 2012 11:07:03 -0400
Message-ID: <CACkq2mr06WhXkoXZaoH_eJKQPkwqEN_un-Qs=UMzpB-fPs0AOg@mail.gmail.com>
References: <CACkq2mq_shqJkq5qyq--wmh1Q32__NN=D9YJqVx6Mkx-ToHZzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59454 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab2GIPHZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 11:07:25 -0400
Received: by lbbgm6 with SMTP id gm6so20228584lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 08:07:23 -0700 (PDT)
In-Reply-To: <CACkq2mq_shqJkq5qyq--wmh1Q32__NN=D9YJqVx6Mkx-ToHZzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I should point out that I did notice (a little too late) the contents
of "rbd --help" has this:

For the map command:
  --user <username>            rados user to authenticate as
  --secret <path>              file containing secret key for use with cephx

I should have seen it sooner.  But, I still wonder if accepting a
keyring file would be nice.  And I can still update the docs to be
consistent with what is actually acceptable to the command.

- Travis

On Mon, Jul 9, 2012 at 10:57 AM, Travis Rhoden <trhoden@gmail.com> wrote:
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
>
> Thanks,
>
>  - Travis
