From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Caught the first erroneous translated errorcode
Date: Sun, 18 Jun 2017 19:18:55 +0200
Message-ID: <028757af-a82b-d873-648d-294961984bbb@digiware.nl>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
 <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
 <5ca934f2-0f95-bb6c-0fce-267468cb59b4@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:52351 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752501AbdFRRTI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 18 Jun 2017 13:19:08 -0400
In-Reply-To: <5ca934f2-0f95-bb6c-0fce-267468cb59b4@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

On 17-6-2017 22:59, Willem Jan Withagen wrote:
> On 17-6-2017 19:52, John Spray wrote:
>> On Sat, Jun 17, 2017 at 11:50 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> I think I've found the first fact where the errno translation (ceph ->
>>> hostos -> client-ceph ) goes wrong....
>>>
>>> Repeatedly I get the following error:
>>> 116:
>>> /home/jenkins/workspace/ceph-master/src/test/libradosstriper/rados-striper.sh:42:
>>> run:  rados --pool rbd --striper put toy
>>> file td/rados-striper/toyfile
>>> 116: 2017-06-17 12:32:05.290234 810016000 -1 libradosstriper:
>>> RadosStriperImpl::openStripedObjectForWrite : could not set new s
>>> ize for toyfile : rc = -125error putting rbd/toyfile: (125) Unknown
>>> error: 125
>>>
>>> 125 is ECANCELD on Linux
>>> but FreeBSD
>>> #define ECANCELED       85              /* Operation canceled */
>>>
>>> So probably the server returns ECANCELD in network format (125)
>>> but the client does not translate back...
>>
>> Somewhat related perhaps: people running cephfs on ARM recently had
>> this problem, for that case the solution was simply to define in Ceph
>> some constants that mirror the linux ones, see commit 88d2da5e9.
> 
> Hi John,
> 
> I think is at the other end I'm working at.
> This commit is about the flags being issued to file open.
> Where I'm sort of suprised since this is Linux <> Linux.
> So perhaps it is all about big-endian <> Little Endian.
> 
> My PR is more about the error code that differ between Linux and
> FreeBSD. So A FreeBSD client would not (correctly) understand the error
> codes that a Linux server issues.
> So I translate all wire error codes to Linux codes on a server
> (hostos_to_ceph_errno_conv()), and in a FreeBSD client I translate the
> wire-error codes into FreeBSD codes. (ceph_to_hostoserrno_conv())
> 
> Specific in this case:
> ECANCELED is 125 on Linux, and is the on wire code.
> So the servers started in the test will signal ECANCELED with value 125,
> but because the rados-stripe code does not translate that back into 85
> (FreeBSD ECANCELED) it is reported as a unkonwn error. Whereas in this
> part of the code ECANCELED is a valid return and is adequately handled.
> 
> So that is why I suspect that the rados code does not take this
> translation into account. Which is not supprising, since only the code
> from OS to wire was available, but the back path was not included until
> I introduced it. But it is hard to find all locations where it should be
> applied.
> 
> So I'm looking for (all) the correct place to insert:
> 	ceph_to_hostos_errno_conv(err)

I think I might have found some locations where the result on the wire
is fetched.... But not sure is this is at the correct level?

os/fs/aio.h:42:  int get_return_value() {
libradosstriper/MultiAioCompletionImpl.h:116:  int get_return_value() {
librados/AioCompletionImpl.h:115:  int get_return_value() {
librados/PoolAsyncCompletionImpl.h:59:    int get_return_value() {
librbd/io/AioCompletion.cc:199:ssize_t AioCompletion::get_return_value() {

--WjW


