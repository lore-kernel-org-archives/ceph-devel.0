From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: "Unix Domain socket path too long" failures in Jenkins make check
Date: Sat, 1 Jul 2017 22:56:32 +0200
Message-ID: <2b4bf096-1f15-c5f7-2a32-9cdfe88462df@suse.cz>
References: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
 <5079a3cd-8b60-949f-a413-e159902aa275@digiware.nl>
 <bd8f5518-e9a6-98ac-7f0f-646ac01edd4b@suse.cz>
 <d3bab4db-1a03-13bf-c04a-b28dd8e25939@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751978AbdGAU4e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 1 Jul 2017 16:56:34 -0400
In-Reply-To: <d3bab4db-1a03-13bf-c04a-b28dd8e25939@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> I'll backport https://github.com/ceph/ceph/pull/15770 to kraken and see 
> if that helps, even though the PR says the errors only occurred in arm64.

Nope, it's not that PR (it modifies a test that is missing in kraken), 
but after looking at it a little more closely I see the error is 
happening in test_auth_profiles. Here is the relevant log excerpt:

/home/jenkins-build/build/workspace/ceph-pull-requests/qa/workunits/cephtool/test.sh:534: 
test_auth_profiles:  ceph -n client.xx-profile-ro -k client.xx.keyring 
status
2017-07-01 07:06:34.237801 7f8d48b7c700 -1 WARNING: the following 
dangerous and experimental features are enabled: *
2017-07-01 07:06:34.244725 7f8d48b7c700 -1 WARNING: the following 
dangerous and experimental features are enabled: *
2017-07-01 07:06:34.244781 7f8d48b7c700 -1 asok(0x7f8d44000b30) 
AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen: The 
UNIX domain socket path 
/home/jenkins-build/build/workspace/ceph-pull-requests/build/src/test/td/t-7202/out/client.xx-profile-ro.31748.asok 
is too long! The maximum length on this system is 107

Which happens 
here:https://github.com/ceph/ceph/blob/kraken/qa/workunits/cephtool/test.sh#L534

Since the Jenkins logs seem to disappear after just a couple days, I 
saved the entire log of test_auth_profiles here: https://paste2.org/m6vM0MY8

Any help is welcome: test_auth_profiles fails like this almost every 
time, so this is blocking further work on 11.2.1.

Nathan
