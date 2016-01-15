From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, Bluestore requires AIO
Date: Fri, 15 Jan 2016 12:21:08 +0100
Message-ID: <5698D624.6000301@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <5698CF58.7020206@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43544 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcAQQaI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Jan 2016 11:30:08 -0500
In-Reply-To: <5698CF58.7020206@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mykola Golub <mgolub@mirantis.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 15-1-2016 11:52, Willem Jan Withagen wrote:
> On 30-11-2015 14:21, Sage Weil wrote:
>> The problem with all of the porting code in general is that it is doomed
>> to break later on if we don't have (at least) ongoing build tests.  In
>> order for a FreeBSD or OSX port to continue working we need VMs that run
>> either gitbuilder or a jenkins job or similar so that we can tell when it
>> breaks.
>>
>> If someone is willing to run a VM somewhere to do this we can pretty
>> easily stick it on the gitbuilder page at
>>
>>     http://ceph.com/gitbuilder.cgi
>
> Well this is real nice case of such an incident.
>
> I'm verifying my changes to the C/C++ code, after having forwarded to HEAD.
> And now I get bluestore complaining that it requires AIO.
> Something I've thusfar excluded in the build.
>
> Does Bluestore really require AIO??
> FreeBSD does have AIO, but to take simple steps one at the time, I
> excluded it
> with configure. Mainly because it bombs at compile time. Probably due to
> different include files, or function nameing.....
>
> So, in order of preference:
> - Can I disable AIO for Bluestore
> - Can I disable bluestore being build?

Spoke a bit too soon.

FreeBSD has AIO, loadable as kernelmodule. with the following systemcalls.
aio_cancel(2), aio_error(2), aio_read(2), aio_return(2), aio_suspend(2),
      aio_waitcomplete(2), aio_write(2), lio_listio(2)

But libaio is based on:
/* Actual syscalls */
extern int io_setup(int maxevents, io_context_t *ctxp);
extern int io_destroy(io_context_t ctx);
extern int io_submit(io_context_t ctx, long nr, struct iocb *ios[]);
extern int io_cancel(io_context_t ctx, struct iocb *iocb, struct 
io_event *evt);
extern int io_getevents(io_context_t ctx_id, long min_nr, long nr, 
struct io_event *events, struct timespec *timeout);

So glueing that together is not just fixing some include files, and or 
fetching
some shim-library that is lurking out in /usr/ports...

And for the time being I would like to skip over the libaio hurdle.

Is that possible?

--WjW
