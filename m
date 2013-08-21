From: Wido den Hollander <wido@42on.com>
Subject: Re: app design recommendations
Date: Wed, 21 Aug 2013 10:49:20 +0200
Message-ID: <52147F10.3030509@42on.com>
References: <CAHO6xe-FSmZdFTqDq56U9_QQ_hoPMnPqbFLjT1CLGETz-hCs7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:45357 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848Ab3HUItX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Aug 2013 04:49:23 -0400
In-Reply-To: <CAHO6xe-FSmZdFTqDq56U9_QQ_hoPMnPqbFLjT1CLGETz-hCs7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nulik Nol <nuliknol@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/20/2013 10:06 PM, Nulik Nol wrote:
> Hi,
> I am creating an email system which will handle whole company's email,
> mostly internal mail. There will be thousands of companies and
> hundreds of users per company. So I am planning to use one pool per
> company to store email messages. Can Ceph manage thousands or maybe
> hundred thousands of pools ? Could there be any slowdown at production
> with such design after some growth?
>

No, Ceph dan not handle thousands or even hundreds of pools. For each 
pool a certain (configurable) amount of placement groups is created. 
Each PG has to be tracked through the cluster and will consume CPU en 
Memory on your OSDs and even Monitors.

With a large amount of pools you will start consuming a huge amount of 
memory and CPU power.

To mitigate this RADOS namespaces have developed: 
http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/rados_namespaces

That will allow you to separate data in a pool without having to create 
multiple pools. Namespaces are cheap, so use them.

> Every email will be stored as an individual ceph object (emails will
> average 512 bytes and rarely have attachments) , is it ok to store
> them as a ceph objects or will it be less efficient than storing
> multiple emails in a ceph object,? What is the optimal ceph object
> size to store individually, so it would be preferable to do this
> instead of writing through omap with leveldb? (kind of "ceph object vs
> omap" benchmark question)
>

You can store billions of objects in a pool, that is not a problem. 
Their size doesn't matter either.

Larger objects might work better in recovery situations since you save 
yourself the opening and closing of a vast amount of small files on the 
OSD's filesystem. I have never benchmarked it though.

> Also I will be putting mini-chat sessions between users in a ceph
> object, each time a user sends a message to another user, I will
> append the text to the ceph object, so my question is, will Ceph
> rewrite the whole object into a new physical location on disk when I
> do an append? Or will it just rewrite the block that was modified?
>

As long as you use rados_append it will append to the object and the 
file on the OSD and it won't rewrite the complete file on the OSD's 
filesystem.

> And last questions: Which is faster, storing small key/value pairs in
> omap or in xattrs ? Will storing key/value pairs in xattrs result in
> space waste by allocating a block for zero-sized object on the OSD? (I
> won't write any data to the object, just use xattrs)
>

I'm not sure about the answer on this one, but you are aware of the fact 
that you can't search for objects? You can't ask RADOS to give you all 
objects where attr X has value Y.

Wido

> Will appreciate very much your comments.
>
> Best Regards
> Nulik
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
