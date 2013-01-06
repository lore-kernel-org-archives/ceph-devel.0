From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: which Linux kernel version corresponds to 0.48argonaut?
Date: Sat, 05 Jan 2013 20:08:27 -0700
Message-ID: <50E8EAAB.9030501@cs.utah.edu>
References: <50D35ECA.4040602@cs.utah.edu> <50D3BD69.8010305@cs.utah.edu> <CAPYLRzhi2h_YDP7zdobMQepGA8ntQOqQgY+rP4AKvjvH3=-+WA@mail.gmail.com> <alpine.DEB.2.00.1301041633340.6109@cobra.newdream.net> <50E8D99F.3090008@cs.utah.edu> <50E8E8D1.6010000@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:34455 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab3AFDI3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 22:08:29 -0500
In-Reply-To: <50E8E8D1.6010000@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

Thanks for your reply. I do not think I am running the packaged version. 
The output shows it is my version (0.48.2argonaut.fast at commit 000...).

root@client:/users/utos# rbd -v
ceph version 0.48.2argonaut.fast 
(commit:000000000000000000000000000000000000000000000)
root@client:/users/utos# /usr/bin/rbd -v
ceph version 0.48.2argonaut 
(commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
root@client:/users/utos# /usr/local/bin/rbd -v
ceph version 0.48.2argonaut.fast 
(commit:000000000000000000000000000000000000000000000)

Xing

On 01/05/2013 08:00 PM, Mark Kirkwood wrote:
> I'd hazard a guess that you are still (accidentally) running the 
> packaged binary - the packaged version installs in /usr/bin (etc) but 
> your source build will probably be in /usr/local/bin. I've been 
> through this myself and purged the packaged version before building 
> and installing from source (just to be sure).
>
> Cheers
>
> Mark
>
> On 06/01/13 14:55, Xing Lin wrote:
>
>> After changing the client-side code, I can map/unmap rbd block devices
>> at client machines. However, I am not able to list rbd block devices. At
>> the client machine, I first installed 0.48.2argonaut package for Ubuntu
>> then I compiled and installed my own version according to instructions
>> on this page ( http://ceph.com/docs/master/install/building-ceph/). The
>> client failed to recognize the fifth bucket algorithm I added. I
>> searched "unsupported bucket algorithm" in the ceph code base and that
>> text only appeared in the src/crush/CrushWrapper.cc. I checked
>> decode_crush_bucket() and it should be able to recognize the fifth
>> algorithm. Even after I changed the error message (added print of
>> "[XXX]" and values for two bucket algorithm macros), it still prints the
>> same error message. So, it seems that my new version of CrushWrapper.cc
>> is not used during compilation to create the final rbd binary. Would you
>> please tell me where the problem is and how I can fix it? Thank you very
>> much.
>>

