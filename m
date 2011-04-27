From: Fabio Kaminski <fabiokaminski@gmail.com>
Subject: Re: ceph block pointer abstractions
Date: Wed, 27 Apr 2011 16:42:44 -0300
Message-ID: <BANLkTiktRZYqpWb9c+=roAuu7GCum9qK8g@mail.gmail.com>
References: <BANLkTimWV7QUUa7tQkzLO688XvMYKFKshQ@mail.gmail.com>
	<5C6848CA1E2C4DC09E2F12612C447199@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64782 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab1D0Tmp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 15:42:45 -0400
Received: by fxm17 with SMTP id 17so1365750fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 12:42:44 -0700 (PDT)
In-Reply-To: <5C6848CA1E2C4DC09E2F12612C447199@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Ok, thats the way it should be.. :)

But specializing a little more the question..  whats the data
partition scheme between nodes, how can a user control it.. block
level? file level?
suppose that i have agregations that i want it to stick together in
nodes... even if replicated in several nodes.. but always together, to
get network roundtrips diminished..

thanks again

On Wed, Apr 27, 2011 at 4:24 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> We're not quite sure what construct you're referring to here with "block pointer"?
>
> Generally users of the Ceph client do not need to know about the position or movement of data on the storage cluster, though, if that answers your question. :)
> -Greg
> On Wednesday, April 27, 2011 at 12:18 PM, Fabio Kaminski wrote:
>> Suppose that i have a datastructure with a block pointer to another
>> item(block)..
>> how this pointer would work with ceph, if this block get moved to
>> another data node, would it still work?
>>
>> what is the best way to do it under ceph? im using cephs own userland libs..
>>
>> block pointers? its safe? how.. :)
>>
>> thanks,
>>
>> Fabio Kaminski
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
>
