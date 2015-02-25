From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: [ceph-users] who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 12:10:33 +1300
Message-ID: <54EE5669.9090906@catalyst.net.nz>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net> <CAANLjFpHND2uyUvdzJ-pz4QOXp6SpYK=sD1WQz=rT-Two6izqw@mail.gmail.com> <alpine.DEB.2.00.1502251348170.25838@cobra.newdream.net> <loom.20150225T233013-453@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:43181 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbbBYXTD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 18:19:03 -0500
In-Reply-To: <loom.20150225T233013-453@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Deneau <tom.deneau@amd.com>, ceph-devel@vger.kernel.org

On 26/02/15 11:50, Tom Deneau wrote:
> Sage Weil <sweil <at> redhat.com> writes:
>
>>
>> On Wed, 25 Feb 2015, Robert LeBlanc wrote:
>>> We tried to get radosgw working with Apache + mod_fastcgi, but due to
>>> the changes in radosgw, Apache, mode_*cgi, etc and the documentation
>>> lagging and not having a lot of time to devote to it, we abandoned it.
>>> Where it the documentation for civetweb? If it is appliance like and
>>> easy to set-up, we would like to try it to offer some feedback on your
>>> question.
>>
>> In giant and hammer, it is enabled by default on port 7480.  On firefly,
>> you need to add the line
>>
>>   rgw frontends = fastcgi, civetweb port=7480
>>
>> to ceph.conf (you can of course adjust the port number if you like) and
>> radosgw will run standalone w/ no apache or anything else.
>>
>> sage
>>
>
> Like Robert, I have had trouble getting the gateway working with the Apache
> methods.  So civetweb is something we would like to try.
>
> I am running 0.92 built from sources using rpmbuild.  (This is on arm64).
> So I assume I do not need any rgw frontends line in ceph.conf.
>
> It would be good to document what steps from
> http://docs.ceph.com/docs/master/radosgw/config/ are still required when
> using civetweb.
>

+1. I was considering using civetweb whilst experimenting with radosgw - 
and didn't because I had no idea how to get it going. It is funny that I 
probably had it running anyway (0.92), but highlights the importance of 
having the docs up to date!

Cheers

Mark

