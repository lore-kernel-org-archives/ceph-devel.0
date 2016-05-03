From: Jesse Williamson <jwilliamson@suse.com>
Subject: Re: building boost statically
Date: Mon, 2 May 2016 18:01:44 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1605021757210.21305@ancalagon.suse.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com> <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com> <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com> <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
 <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com> <20160502032831.GA8719@ultraspiritum.redhat.com> <alpine.LSU.2.20.1605020907510.21305@ancalagon.suse.com> <20160502161449.GA2654@ultraspiritum.redhat.com>
 <2129674447.23940924.1462230258123.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:52017 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452AbcECBBu (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 2 May 2016 21:01:50 -0400
In-Reply-To: <2129674447.23940924.1462230258123.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, Sage Weil <sage@newdream.net>, Allen Samuels <Allen.Samuels@sandisk.com>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, ceph-devel@vger.kernel.org

On Mon, 2 May 2016, Matt Benjamin wrote:

So, just a quick update here: I used bcp to extract boost containers. This 
works nicely, but you end up with 1628 files. It's doing what it's 
/supposed/ to do, since part of the purpose is to provide all the 
dependencies (for example, Boost::MPL is used), but that seems like maybe 
not what we want to do.

Just using the boost/container headers is also possible, at a bit of risk 
that if we try to build on a system where one of the dependencies is 
incompatible in some way, Ceph won't build (perhaps a fairly low risk, but 
I'm throwing it out there). If that risk is acceptable, then we wouldn't 
have a large set of headers, but in effect would still be shipping our own 
little mini-fork.

CMake looks like it has a module that can help us, and the general 
direction during an IRC chat was that we should do this as part of the 
move to cmake, rather than fidding with autoconf.

-Jesse

> Just wanted to ++ this.
>
> Matt
>
> ----- Original Message -----
>> From: "Adam C. Emerson" <aemerson@redhat.com>
>> To: "Jesse Williamson" <jwilliamson@suse.com>
>> Cc: "Sage Weil" <sage@newdream.net>, "Allen Samuels" <Allen.Samuels@sandisk.com>, "Ken Dreyer" <kdreyer@redhat.com>,
>> "Haomai Wang" <haomai@xsky.com>, ceph-devel@vger.kernel.org
>> Sent: Monday, May 2, 2016 12:14:50 PM
>> Subject: Re: building boost statically
>>
>> On 02/05/2016, Jesse Williamson wrote:
>>> I think that in the long run, rather than bundling or using bcp, it would
>>> be
>>> nice to have cmake/autoconf let you point to the boost version you'd like
>>> to
>>> use.
>>
>> If we could manage it, that would be my ideal world. Rather than
>> making it A Submodule, say, if we could have cmake examine the system
>> boost to see what version it is and, if the version is greater than or
>> equal to the required version, just use it. Otherwise just fetch the
>> required version and build against it statically.
>>
>> --
>> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
>> IRC: Aemerson@{RedHat, OFTC, Freenode}
>> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> -- 
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
