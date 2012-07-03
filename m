From: Wido den Hollander <wido@widodh.nl>
Subject: Re: URL-safe base64 encoding for keys
Date: Tue, 03 Jul 2012 21:18:51 +0200
Message-ID: <4FF3459B.1050708@widodh.nl>
References: <4FF2E40B.8090705@widodh.nl> <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:34255 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab2GCTSy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 15:18:54 -0400
In-Reply-To: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 07/03/2012 05:35 PM, Tommi Virtanen wrote:
> On Tue, Jul 3, 2012 at 5:22 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> CloudStack's API expects a URI to be passed when adding a storage pool,
>> e.g.:
>>
>> addStoragePool?uri=rbd://user:cephxkey@monitor.addr/poolname
>>
>> If 'cephxkey' contains a / the URI parser in Java fails (java.net.URI) and
>> splits the URI in the wrong place.
>
> First, I actually agree with you -- urlsafe b64 just makes sense. We'd
> have to go through some sort of a transition period, accepting both,
> perhaps generating old-style, for some time.
>

My thoughts exactly.

> Second, have you tried quoting the unsafe characters? / is %2f, + is
> %2b, % is %25.

Yes, I have thought about that, but it would mean extra docs in the 
CloudStack API docs.

Warning: Please URL-encode your cephx secret since it may contain 
invalid characters

In the WebGUI (which talks to the API) I could do a URL-encode in 
JavaScript and do the decode again in the CloudStack management server, 
but it's not what you want.

So yes, that has crossed my mind, but for now I took the easy way out 
and generated myself a new key which doesn't contain slashes.

Wido

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

