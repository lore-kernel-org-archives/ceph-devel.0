From: David Galloway <dgallowa@redhat.com>
Subject: Re: [ceph-users] dropping trusty
Date: Mon, 4 Dec 2017 10:48:11 -0500
Message-ID: <f6c93e1c-ce88-9e44-fc80-07dfc11e3d92@redhat.com>
References: <alpine.DEB.2.11.1711301711470.12766@piezo.novalocal>
 <f3f4d84b-2df0-0b7d-65f1-074e4d308348@redhat.com>
 <CAJE9aOP_SXaXsS7DAjvyeNtOD9oK=NTt9j-pbQrCXeD6KwsbVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbdLDPsM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Dec 2017 10:48:12 -0500
In-Reply-To: <CAJE9aOP_SXaXsS7DAjvyeNtOD9oK=NTt9j-pbQrCXeD6KwsbVQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>


On 12/04/2017 01:12 AM, kefu chai wrote:
> On Fri, Dec 1, 2017 at 1:55 AM, David Galloway <dgallowa@redhat.com> wrote:
>> On 11/30/2017 12:21 PM, Sage Weil wrote:
>>> We're talking about dropping trusty support for mimic due to the old
>>> compiler (incomplete C++11), hassle of using an updated toolchain, general
>>> desire to stop supporting old stuff, and lack of user objections to
>>> dropping it in the next release.
>>>
>>> We would continue to build trusty packages for luminous and older
>>> releases, just not mimic going forward.
>>>
>>> My question is whether we should drop all of the trusty installs on smithi
>>> and focus testing on xenial and centos.  I haven't seen any trusty related
>>> failures in half a year.  There were some kernel-related issues 6+ months
>>> ago that are resolved, and there is a valgrind issue with xenial that is
>>> making us do valgrind only on centos, but otherwise I don't recall any
>>> other problems.  I think the likelihood of a trusty-specific regression on
>>> luminous/jewel is low.  Note that we can still do install and smoke
>>> testing on VMs to ensure the packages work; we just wouldn't stress test.
>>>
>>> Does this seem reasonable?  If so, we could reimage the trusty hosts
>>> immediately, right?
>>>
>>> Am I missing anything?
>>>
>>
>> Someone would need to prune through the qa dir and make sure nothing
>> relies on trusty for tests.  We've gotten into a bind recently with the
> 
> David, thanks for point out the direction. i removed the references to trusty
> and updated related bits in https://github.com/ceph/ceph/pull/19307.
> 
>> testing of FOG [1] where jobs are stuck in Waiting for a long time
>> (tying up workers) because jobs are requesting Trusty.  We got close to
>> having zero Trusty testnodes since the wip-fog branch has been reimaging
>> baremetal testnodes on every job.
>>
>> But other than that, yes, I can reimage the Trusty testnodes.  Once FOG
>> is merged into teuthology master, we won't have to worry about this
>> anymore since jobs will automatically reimage machines based on what
>> distro they require.
> 
> since https://github.com/ceph/teuthology/pull/1126 is merged, could you help
> reimage the trusty test nodes?
> 

No need.  Since that's merged, all testnodes are automatically reimaged
on every job now :).  An e-mail to Sepia user list is forthcoming with
more details.

>>
>> [1] https://github.com/ceph/teuthology/compare/wip-fog

