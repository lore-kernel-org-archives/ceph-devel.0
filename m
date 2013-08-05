From: George Dunlap <george.dunlap@eu.citrix.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 5 Aug 2013 16:20:20 +0100
Message-ID: <51FFC2B4.6010100@eu.citrix.com>
References: <20130419064524.GQ11427@reaktio.net> <6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au> <CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B62E7E7E4@BITCOM1.int.sbss.com.au> <CAF6-1L6OrfOQssCWFqQL7KXTvMy+SyCd1XNrfme80p_7EEHj=Q@mail.gmail.com> <20130805111213.GM2924@reaktio.net> <CAF6-1L4vZeu69GVVoi4yg6irRVSPFZ-oeX=rQaMkmqy-09=Emg@mail.gmail.com> <CAFLBxZYT8aOJdKv9qY5HPrk3W6+BFvxpT6Ra6RYuB=rYxJ6uMQ@mail.gmail.com> <CAF6-1L6BJh3OMsCXocuTd_VV0orD2sUgP7KqD1hZhRyMeRO17A@mail.gmail.com> <51FFB0FF.7070607@eu.citrix.com> <20130805151814.GG27858@zion.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:15129 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab3HEPU1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 11:20:27 -0400
In-Reply-To: <20130805151814.GG27858@zion.uk.xensource.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Liu <wei.liu2@citrix.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, =?ISO-8859-1?Q?Pasi_?= =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, James Harper <james.harper@bendigoit.com.au>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Roger Pau Monne <roger.pau@citrix.com>

On 05/08/13 16:18, Wei Liu wrote:
> On Mon, Aug 05, 2013 at 03:04:47PM +0100, George Dunlap wrote:
>> On 05/08/13 14:55, Sylvain Munaut wrote:
>>> Hi George,
>>>
>>>
>>>> Yes; qemu knows how to be a Xen PV block back-end.
>>> Very interesting. Is there documentation about this somewhere ?
>>> I had a look some time ago and it was really not very clear.
>>>
>>> Things like what Xen version support this. And with which features (
>>> indirect descriptors, persistent grants, discard, flush, ...) and/or
>>> which limitation.
>> I don't think this is documented anywhere; you'll need to ask the
>> experts.  Stefano? Roger? Wei?
>>
> These are Linux features not Xen ones AFAICT. In theory they are not
> bound to specific Xen versions.
>
> For the network part I don't think new features depend on any specific
> hypercall. However for block Roger and Stefano seem to introduce
> new hypercalls for certain features (I might be wrong though).

We're talking about qemu; so the toolstack needs to know how to set up 
qdisk, and I think qdisk would need to be programmed to use, for 
example, persistent grants, yes?

  -G

