From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: specifying secret in rbd map command
Date: Mon, 9 Jul 2012 12:32:17 -0400
Message-ID: <CACkq2mobAF+iBvkRvi3YZRdhWFkta_iUfoR33jgqzjKX11wzOA@mail.gmail.com>
References: <CACkq2mq_shqJkq5qyq--wmh1Q32__NN=D9YJqVx6Mkx-ToHZzA@mail.gmail.com>
 <Pine.LNX.4.64.1207090920480.20547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53948 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab2GIQcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 12:32:39 -0400
Received: by lbbgm6 with SMTP id gm6so20370014lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 09:32:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1207090920480.20547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Awesome.  Thanks, Sage.  I won't bother to try and fix up the docs,
then.  Though I might take a look at the branch and see if they have
been updated to capture the latest changes.

 - Travis

On Mon, Jul 9, 2012 at 12:22 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Travis,
>
> Sorry for the confusion!  There is a branch in git (wip-auth) that cleans
> up the rbd map code to be consistent with the rest of the system, so that
> you can use keyrings or explicit keys or keyfiles.  It should get merged
> for 0.50.
>
> sage
>
>
> On Mon, 9 Jul 2012, Travis Rhoden wrote:
>
>> Hey folks,
>>
>> I had a bit of unexpected trouble today using the "rbd map" command to
>> map an RBD to a kernel object.  I had previously been using the "echo
>> ... > /sys/bus/rbd..." method of manipulating RBDs.
>>
>> I was looking at the instructions here:
>> http://ceph.com/docs/master/rbd/rbd-ko/
>>
>> When I tried to use the given syntax,  "sudo rbd map {image-name}
>> --pool {pool-name} --name {client-name} --secret {client-secret}", I
>> found the following:
>>
>> 1. {client-secret} is really supposed to be a file, not the actual
>> secret.  An strace on the command shows an attempt to open a file with
>> the secret as its name
>> 2. If I give a keyring file as the client-secret, the command does not
>> parse out the key for the given client-name.  In other words, I gave
>> the name as "client.admin", then gave it the keyring file which
>> contained merely
>>
>> [client.admin]
>>       key = AQB67+BPGNX0NhAA9iK7Epcj72Jck1wOAQBetA==
>>
>> But the command wouldn't parse out the key.
>>
>> 3. I had to create a new file, containing only the text of the key,
>> and pass that to the command instead.  Then everything is happy.
>>
>>
>> I"m happy to update the docs to make this process clear.  But I wonder
>> if there might be any plans to modify the command behavior to accept a
>> keyring file and pull out the key belonging to specified client name.
>> Either way, I can update the docs to make it clear that you are
>> specifying a file, not the key string itself.
>>
>> Thanks,
>>
>>  - Travis
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
