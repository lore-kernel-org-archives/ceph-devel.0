From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: "Unix Domain socket path too long" failures in Jenkins make check
Date: Sat, 1 Jul 2017 22:34:33 +0200
Message-ID: <d3bab4db-1a03-13bf-c04a-b28dd8e25939@suse.cz>
References: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
 <5079a3cd-8b60-949f-a413-e159902aa275@digiware.nl>
 <bd8f5518-e9a6-98ac-7f0f-646ac01edd4b@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59625 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbdGAUef (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 1 Jul 2017 16:34:35 -0400
In-Reply-To: <bd8f5518-e9a6-98ac-7f0f-646ac01edd4b@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'll backport https://github.com/ceph/ceph/pull/15770 to kraken and see 
if that helps, even though the PR says the errors only occurred in arm64.

On 07/01/2017 10:25 PM, Nathan Cutler wrote:
> Hi Willem,
> 
> On 07/01/2017 03:17 PM, Willem Jan Withagen wrote:
>> I know Loic has done work to shorten the path on all of the tests by 
>> renaming /testdir/ to /td/ and perhaps even some more because of this.
>> Things like:
>> ./src/test/vstart_wrapper.sh:22:export 
>> CEPH_DIR="${TMPDIR:-$PWD}/td/t-$CEPH_PORT"
>>
>> But I do not know if this was sufficient, and if this is the only place.
>> But it is a good start to find the comit that did the fix.
> 
> Looks like the patch you referred to is there:
> 
> 2017-07-01 07:06:34.244781 7f8d48b7c700 -1 asok(0x7f8d44000b30) 
> AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen: The 
> UNIX domain socket path 
> /home/jenkins-build/build/workspace/ceph-pull-requests/build/src/test/td/t-7202/out/client.xx-profile-ro.31748.asok 
> is too long! The maximum length on this system is 107
> 
> So it's apparently not sufficient. I haven't heard of master being 
> affected by this, so you're probably right that there's some other patch 
> that is missing in kraken.
> 
> Nathan

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
