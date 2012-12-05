From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: VM Corruption on 0.54 when 'client cache = false'
Date: Wed, 05 Dec 2012 13:25:19 -0800
Message-ID: <50BFBBBF.6090600@inktank.com>
References: <38A500831D3DE24B90BD200D6C8701351BAE2396@Exchange2010-2.corit.local> <9cae09be7789e62ef6520f467a223e5b@hq.newdream.net> <38A500831D3DE24B90BD200D6C8701351BAE4F38@Exchange2010-2.corit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52336 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab2LEVZd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 16:25:33 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3896198pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Dec 2012 13:25:33 -0800 (PST)
In-Reply-To: <38A500831D3DE24B90BD200D6C8701351BAE4F38@Exchange2010-2.corit.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Anderson <matthewa@base3.com.au>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

On 12/05/2012 05:51 AM, Matthew Anderson wrote:
> Thanks for getting back to me Josh.
>
> I've updated to the new 0.55 release and I haven't been able to reproduce the problem. I have the feeling I may be to blame for the problem as when I updated to 0.55 qemu-img segfaulted with a librbd error because there was an old version of the librbd library in another path (which I think was from 0.54). Once I cleaned everything up it worked fine.

Good to hear.

>   One thing I didn't notice about the 0.55 release is that 'ceph osd create' no longer accepts arguments and gives '(22) Invalid argument' if you try to specify an OSD number. Running the command without an argument correctly creates an OSD with the next free osd number. I wasn't sure if this was a bug or that the command has changed for 0.55+ and the documentation hasn't been updated yet (Add/Remove OSD's page in the wiki refernces the command with arguments).

This actually changed from accepting an osd id to a uuid back in 0.47,
but 0.55 is the first version to reject a non-uuid. The docs were
updated by 36e7b077a77fa0a6c87289f400391c85dcdb1d42, but seem to
have been accidentally reverted during a reorganization. This is
fixed again now.

This thread has the rationale for the change from id to uuid:

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/8296

Josh
