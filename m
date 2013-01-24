From: John Nielsen <lists@jnielsen.net>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 10:16:06 -0700
Message-ID: <48951A5C-C8B0-4AE1-9FF5-0BE7FDE95DFD@jnielsen.net>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net> <5101572E.2080207@bmrb.wisc.edu> <CAKMAVE8_DaRs4=SXjsJeseK5JrT389pfat96upzw=hEsxBaA5Q@mail.gmail.com> <51016AD5.4080701@bmrb.wisc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from secure.freebsdsolutions.net ([69.55.234.48]:53071 "EHLO
	ns1.jnielsen.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753773Ab3AXRQJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 12:16:09 -0500
In-Reply-To: <51016AD5.4080701@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dmaziuk@bmrb.wisc.edu
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Jan 24, 2013, at 10:09 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:

> Yes, but when I'm trying to set up a ceph server using the quick start guide, mkcephfs is failing with an error message I didn't write down, but the complaint was along the lines of missing rbd.ko. Booting a 3.7 kernel made it go away.
> 
> This is the part where everyone says "server stuff should run on the stock centos kernel" but in my reality it doesn't. (So I'm trying to figure out why my reality is different from everyone else's ;)
> 
> I'll see if I can reproduce it and post the exact error message.

That would be helpful.

RBD is totally optional (it's just another client, really) and should not be needed on a ceph server to have a functional cluster. My comment about Qemu was intended to illustrate that; you certainly don't need qemu.


On Jan 23, 2013, at 7:41 PM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:

> On 01/23/2013 06:17 PM, John Nielsen wrote:
> 
>> http://ceph.com/docs/master/install/rpm/
>> http://ceph.com/docs/master/start/quick-start/
>> 
>> Between those two links my own quick-start on CentOS 6.3 was maybe 6 minutes. YMMV.
> 
> I guess the other obvious question is did you use bobtail rpms or
> "development release"? - I installed bobtail.

I used the bobtail RPM's without problem.

JN

