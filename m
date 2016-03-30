From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Virtualenv tests still nort running...
Date: Wed, 30 Mar 2016 11:25:52 +0200
Message-ID: <56FB9BA0.2060901@digiware.nl>
References: <56FA67A8.6050809@digiware.nl> <56FA74F4.5040905@dachary.org>
 <56FA9B5C.5060307@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:23041 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbcC3J0L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Mar 2016 05:26:11 -0400
In-Reply-To: <56FA9B5C.5060307@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 29-3-2016 17:12, Willem Jan Withagen wrote:
> On 29-3-2016 14:28, Loic Dachary wrote:
>> Hi Willem,
>>
>> This has undergone various fixes all of them wrong in a context or
>> another. The last of them is (hopefully ;-)
>> https://github.com/ceph/ceph/pull/8320
> 
> Hi Loic,
> 
> I watched the discussion carefully, and was under the assemption that
> everything was already merged. But I'll take your pull and see what happens.

Hi Loic,

I saw that #8320 was merged and rebased. So running/compiling to see
what brings.

There might be one change that you'd care to take along in this as well,
which I have to keep my tests running ATM.
Otherwise I'll just keep it in my patchset to the time to come.

--WjW

: ${CEPH_DETECT_INIT_VIRTUALENV:=ceph-detect-init-virtualenv}

case `uname` in
 FreeBSD)
    echo FreeBSD init system has not been integrated.
    exit 0
    ;;
 *)
    # run from the ceph-detect-init directory or from its parent
    test -d ceph-detect-init && cd ceph-detect-init
    source ${CEPH_DETECT_INIT_VIRTUALENV}/bin/activate
    tox > ${CEPH_DETECT_INIT_VIRTUALENV}/tox.out 2>&1
    status=$?
    grep -v InterpreterNotFound < ${CEPH_DETECT_INIT_VIRTUALENV}/tox.out
    exit $status
    ;;
esac

