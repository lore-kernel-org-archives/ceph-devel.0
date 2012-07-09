From: Dan Mick <dan.mick@inktank.com>
Subject: Re: librbd: error finding header
Date: Mon, 09 Jul 2012 02:03:41 -0700
Message-ID: <4FFA9E6D.7030207@inktank.com>
References: <4FFA6F35.4040102@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37361 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab2GIJDp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 05:03:45 -0400
Received: by pbbrp8 with SMTP id rp8so18958706pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 02:03:45 -0700 (PDT)
In-Reply-To: <4FFA6F35.4040102@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

Vladimir: you can do some investigation with the rados command.  What does
rados -p rbd ls show you?

On 07/08/2012 10:42 PM, Vladimir Bashkirtsev wrote:
> Hello,
>
> I just hit this error:
>
> error opening image sip.logics.net.au: (2) No such file or directory
> 2012-07-09 15:03:59.935835 7ffbe0673780 -1 librbd: error finding 
> header: (2) No such file or directory
>
> Googled around and found that Oliver Francke had similar issue back in 
> March. Read your responses but still unclear where to start to dig. 
> Just upgraded from 0.47.3 to 0.48, done rolling upgrade and all RBD 
> images are OK with exception of this one. Notably as upgrade was done 
> while VM was up it continued to run unaffected (ie all data inside of 
> VM was written and read as nothing happened). It makes me think that 
> there no data loss but mere broken header.
>
> Of course I have a backup of VM and can pull it back in no time but I 
> am really interested (and I am sure other ceph users) how to recover 
> from such failures?
>
> Regards,
> Vladimir
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


